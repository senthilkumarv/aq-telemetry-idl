// Telemetry Thrift IDL
namespace rs telemetry
namespace swift AquariumTelemetry

typedef i64 TimestampMs

enum ChartKind {
  LINE = 1,
  MULTILINE = 2
}

struct SDAquarium { 1: string id, 2: string name }
struct SDPoint { 1: TimestampMs t_ms, 2: double v }
struct SDSeries { 1: string id, 2: string name, 3: optional string color, 4: list<SDPoint> points }
struct SDChart { 1: string id, 2: string title, 3: optional string unit, 4: ChartKind kind, 5: optional double yMin, 6: optional double yMax, 7: optional i32 fractionDigits, 8: list<SDSeries> series }
struct SDTile { 1: string id, 2: string title, 3: optional string unit, 4: optional double value, 5: optional i32 precision }
struct SDOverlay { 1: string id, 2: string name, 3: optional string color, 4: list<SDPoint> points }
struct SDPage { 1: string title, 2: list<SDTile> tiles, 3: list<SDChart> charts, 4: optional list<SDOverlay> overlays }

// Streaming message types for progressive loading
enum StreamMessageType {
  SKELETON = 1,
  TILE_UPDATE = 2,
  CHART_UPDATE = 3,
  COMPLETE = 4
}

// Widget skeleton metadata (no data, just structure)
struct TileSkeleton { 1: string id, 2: string title, 3: optional string unit, 4: optional i32 precision }
struct SeriesSkeleton { 1: string id, 2: string name, 3: optional string color }
struct OverlaySkeleton { 1: string id, 2: string name, 3: optional string color }
struct ChartSkeleton { 1: string id, 2: string title, 3: optional string unit, 4: ChartKind kind, 5: optional double yMin, 6: optional double yMax, 7: optional i32 fractionDigits, 8: list<SeriesSkeleton> series, 9: optional list<OverlaySkeleton> overlays }

struct DashboardSkeleton {
  1: string aquariumId,
  2: list<TileSkeleton> tiles,
  3: list<ChartSkeleton> charts
}

// Progressive data updates
struct TileUpdate { 1: string id, 2: optional double value }
struct SeriesUpdate { 1: string id, 2: list<SDPoint> points }
struct OverlayUpdate { 1: string id, 2: list<SDPoint> points }
struct ChartUpdate { 1: string id, 2: list<SeriesUpdate> series, 3: optional list<OverlayUpdate> overlays }
struct CompletionEvent { 1: i32 totalWidgets, 2: i64 durationMs }

// Streaming message wrapper
struct StreamMessage {
  1: StreamMessageType type,
  2: optional DashboardSkeleton skeleton,
  3: optional TileUpdate tileUpdate,
  4: optional ChartUpdate chartUpdate,
  5: optional CompletionEvent complete
}

service TelemetryService { list<SDAquarium> Aquariums(), SDPage Dashboard(1: string aquarium_id, 2: i32 hours) }
