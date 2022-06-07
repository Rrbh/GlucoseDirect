//
//  DetailsView.swift
//  GlucoseDirect
//

import SwiftUI

// MARK: - SensorView

struct SensorView: View {
    // MARK: Internal

    @Environment(\.colorScheme) var colorScheme

    @EnvironmentObject var store: AppStore
    @State var deviceColorScheme = ColorScheme.light

    var body: some View {
        Group {
            if let sensor = store.state.sensor {
                Section(
                    content: {
                        HStack {
                            Text("Sensor state")
                            Spacer()
                            Text(sensor.state.localizedString)
                        }

                        if let startTimestamp = sensor.startTimestamp {
                            HStack {
                                Text("Sensor starting date")
                                Spacer()
                                Text(startTimestamp.toLocalDateTime())
                            }
                        }

                        if let remainingWarmupTime = sensor.remainingWarmupTime, sensor.state == .starting {
                            HStack {
                                Text("Sensor remaining warmup time")
                                Spacer()
                                Text(remainingWarmupTime.inTime)

                                if let endAngle = remainingWarmupEndAngle {
                                    ZStack {
                                        GeometryReader { geo in
                                            Circle()
                                                .fill(Config.color)
                                                .position(x: geo.size.width / 2, y: geo.size.height / 2)
                                                .frame(width: geo.size.width, height: geo.size.width)

                                            Path { path in
                                                path.move(to: CGPoint(x: geo.size.width / 2, y: geo.size.height / 2))
                                                path.addArc(center: CGPoint(x: geo.size.width / 2, y: geo.size.height / 2), radius: geo.size.width / 2, startAngle: .degrees(0), endAngle: .degrees(endAngle), clockwise: false)
                                            }
                                            .rotation(.degrees(-90))
                                            .fill(Color.accentColor)
                                        }
                                    }.frame(width: Config.size, height: Config.size)
                                }
                            }
                        } else if sensor.state != .expired && sensor.state != .shutdown && sensor.state != .unknown {
                            HStack {
                                Text("Sensor possible lifetime")
                                Spacer()
                                Text(sensor.lifetime.inTime)
                            }

                            HStack {
                                Text("Sensor age")
                                Spacer()
                                Text(sensor.age.inTime)

                                if let endAngle = elapsedEndAngle {
                                    ZStack {
                                        GeometryReader { geo in
                                            Circle()
                                                .fill(Config.color)
                                                .position(x: geo.size.width / 2, y: geo.size.height / 2)
                                                .frame(width: geo.size.width, height: geo.size.width)

                                            Path { path in
                                                path.move(to: CGPoint(x: geo.size.width / 2, y: geo.size.height / 2))
                                                path.addArc(center: CGPoint(x: geo.size.width / 2, y: geo.size.height / 2), radius: geo.size.width / 2, startAngle: .degrees(360), endAngle: .degrees(endAngle), clockwise: false)
                                            }
                                            .rotation(.degrees(-90))
                                            .fill(Color.accentColor)
                                        }
                                    }.frame(width: Config.size, height: Config.size)
                                }
                            }

                            if let remainingLifetime = sensor.remainingLifetime {
                                HStack {
                                    Text("Sensor remaining lifetime")
                                    Spacer()
                                    Text(remainingLifetime.inTime)

                                    if let endAngle = remainingEndAngle {
                                        ZStack {
                                            GeometryReader { geo in
                                                Circle()
                                                    .fill(Config.color)
                                                    .position(x: geo.size.width / 2, y: geo.size.height / 2)
                                                    .frame(width: geo.size.width, height: geo.size.width)

                                                Path { path in
                                                    path.move(to: CGPoint(x: geo.size.width / 2, y: geo.size.height / 2))
                                                    path.addArc(center: CGPoint(x: geo.size.width / 2, y: geo.size.height / 2), radius: geo.size.width / 2, startAngle: .degrees(360), endAngle: .degrees(endAngle), clockwise: false)
                                                }
                                                .rotation(.degrees(-90))
                                                .fill(Color.accentColor)
                                            }
                                        }.frame(width: Config.size, height: Config.size)
                                    }
                                }
                            }
                        }
                    },
                    header: {
                        Label("Sensor lifetime", systemImage: "timer")
                    }
                )
            }

            if let sensor = store.state.sensor {
                Section(
                    content: {
                        HStack {
                            Text("Sensor type")
                            Spacer()
                            Text(sensor.type.localizedString)
                        }

                        HStack {
                            Text("Sensor region")
                            Spacer()
                            Text(sensor.region.localizedString)
                        }

                        HStack {
                            Text("Sensor UID")
                            Spacer()
                            Text(sensor.uuid.hex)
                        }

                        HStack {
                            Text("Sensor PatchInfo")
                            Spacer()
                            Text(sensor.patchInfo.hex)
                        }

                        if let serial = sensor.serial {
                            HStack {
                                Text("Sensor serial")
                                Spacer()
                                Text(serial.description)
                            }
                        }
                    },
                    header: {
                        Label("Sensor details", systemImage: "text.magnifyingglass")
                    }
                )
            }

            if let transmitter = store.state.transmitter {
                Section(
                    content: {
                        HStack {
                            Text("Transmitter name")
                            Spacer()
                            Text(transmitter.name)
                        }

                        HStack {
                            Text("Transmitter battery")
                            Spacer()
                            Text(transmitter.battery.description)

                            if let endAngle = batteryEndAngle {
                                ZStack {
                                    GeometryReader { geo in
                                        Circle()
                                            .fill(Config.color)
                                            .position(x: geo.size.width / 2, y: geo.size.height / 2)
                                            .frame(width: geo.size.width, height: geo.size.width)

                                        Path { path in
                                            path.move(to: CGPoint(x: geo.size.width / 2, y: geo.size.height / 2))
                                            path.addArc(center: CGPoint(x: geo.size.width / 2, y: geo.size.height / 2), radius: geo.size.width / 2, startAngle: .degrees(0), endAngle: .degrees(endAngle), clockwise: false)
                                        }
                                        .rotation(.degrees(-90))
                                        .fill(Color.accentColor)
                                    }
                                }.frame(width: Config.size, height: Config.size)
                            }
                        }

                        if let hardware = transmitter.hardware {
                            HStack {
                                Text("Transmitter hardware")
                                Spacer()
                                Text(hardware.description)
                            }
                        }

                        if let firmware = transmitter.firmware {
                            HStack {
                                Text("Transmitter firmware")
                                Spacer()
                                Text(firmware.description)
                            }
                        }
                    },
                    header: {
                        Label("Transmitter Details", systemImage: "antenna.radiowaves.left.and.right.circle")
                    }
                )
            }
        }.onChange(of: colorScheme) { scheme in
            if deviceColorScheme != scheme {
                AppLog.info("onChange colorScheme: \(scheme)")

                deviceColorScheme = scheme
            }
        }
    }

    // MARK: Private

    private enum Config {
        static let size: CGFloat = 20

        static var color: Color { Color(.sRGB, red: 0.89, green: 0.90, blue: 0.92) | Color(.sRGB, red: 0.25, green: 0.25, blue: 0.25) }
    }

    private var batteryEndAngle: Double? {
        if let transmitter = store.state.transmitter {
            let angle = 3.6 * Double(transmitter.battery)
            return angle
        }

        return nil
    }

    private var remainingWarmupEndAngle: Double? {
        if let sensor = store.state.sensor, let remainingWarmupTime = sensor.remainingWarmupTime {
            let angle = (360.0 / Double(sensor.warmupTime)) * Double(remainingWarmupTime)
            return angle
        }

        return nil
    }

    private var remainingEndAngle: Double? {
        if let sensor = store.state.sensor, let remainingLifetime = sensor.remainingLifetime {
            let angle = (360.0 / Double(sensor.lifetime)) * Double(remainingLifetime)
            return angle
        }

        return nil
    }

    private var elapsedEndAngle: Double? {
        if let sensor = store.state.sensor, let elapsedLifetime = sensor.elapsedLifetime {
            let angle = (360.0 / Double(sensor.lifetime)) * Double(elapsedLifetime)
            return angle
        }

        return nil
    }
}