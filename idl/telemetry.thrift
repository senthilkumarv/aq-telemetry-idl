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
service TelemetryService { list<SDAquarium> Aquariums(), SDPage Dashboard(1: string aquarium_id, 2: i32 hours) }
