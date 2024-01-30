const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Compiler Flags
    const mmdvm_cpp_cflags = [_][]const u8{
        "-g",
        "-O3",
        "-Wall",
        "-std=c++0x",
        "-pthread",
    };

    // Linker Flags
    var libs = [_][]const u8{
        "pthread",
        "util",
        "samplerate",
    };

    var lib_paths = &[_][]const u8{
        "/opt/homebrew/lib",
    };

    const mmdvmHost = b.addExecutable(.{
        .name = "MMDVMHost",
        .target = target,
        .optimize = optimize,
    });

    mmdvmHost.linkLibC();
    mmdvmHost.linkLibCpp();

    const mmdvmhost_cpp_sources = [_][]const u8{
        "AMBEFEC.cpp",
        "BCH.cpp",
        "AX25Control.cpp",
        "AX25Network.cpp",
        "BPTC19696.cpp",
        "CASTInfo.cpp",
        "Conf.cpp",
        "CRC.cpp",
        "Display.cpp",
        "DMRControl.cpp",
        "DMRCSBK.cpp",
        "DMRData.cpp",
        "DMRDataHeader.cpp",
        "DMRDirectNetwork.cpp",
        "DMREMB.cpp",
        "DMREmbeddedData.cpp",
        "DMRFullLC.cpp",
        "DMRGatewayNetwork.cpp",
        "DMRLookup.cpp",
        "DMRLC.cpp",
        "DMRNetwork.cpp",
        "DMRShortLC.cpp",
        "DMRSlot.cpp",
        "DMRSlotType.cpp",
        "DMRAccessControl.cpp",
        "DMRTA.cpp",
        "DMRTrellis.cpp",
        "DStarControl.cpp",
        "DStarHeader.cpp",
        "DStarNetwork.cpp",
        "DStarSlowData.cpp",
        "FMControl.cpp",
        "FMNetwork.cpp",
        "Golay2087.cpp",
        "Golay24128.cpp",
        "Hamming.cpp",
        "I2CController.cpp",
        "IIRDirectForm1Filter.cpp",
        "LCDproc.cpp",
        "Log.cpp",
        "M17Control.cpp",
        "M17Convolution.cpp",
        "M17CRC.cpp",
        "M17LSF.cpp",
        "M17Network.cpp",
        "M17Utils.cpp",
        "MMDVMHost.cpp",
        "Modem.cpp",
        "ModemPort.cpp",
        "ModemSerialPort.cpp",
        "Mutex.cpp",
        "NetworkInfo.cpp",
        "Nextion.cpp",
        "NullController.cpp",
        "NullDisplay.cpp",
        "NXDNAudio.cpp",
        "NXDNControl.cpp",
        "NXDNConvolution.cpp",
        "NXDNCRC.cpp",
        "NXDNFACCH1.cpp",
        "NXDNIcomNetwork.cpp",
        "NXDNKenwoodNetwork.cpp",
        "NXDNLayer3.cpp",
        "NXDNLICH.cpp",
        "NXDNLookup.cpp",
        "NXDNNetwork.cpp",
        "NXDNSACCH.cpp",
        "NXDNUDCH.cpp",
        "P25Audio.cpp",
        "P25Control.cpp",
        "P25Data.cpp",
        "P25LowSpeedData.cpp",
        "P25Network.cpp",
        "P25NID.cpp",
        "P25Trellis.cpp",
        "P25Utils.cpp",
        "PseudoTTYController.cpp",
        "POCSAGControl.cpp",
        "POCSAGNetwork.cpp",
        "QR1676.cpp",
        "RemoteControl.cpp",
        "RS129.cpp",
        "RS241213.cpp",
        "RSSIInterpolator.cpp",
        "SerialPort.cpp",
        "SMeter.cpp",
        "StopWatch.cpp",
        "Sync.cpp",
        "SHA256.cpp",
        "TFTSurenoo.cpp",
        "Thread.cpp",
        "Timer.cpp",
        "UARTController.cpp",
        "UDPController.cpp",
        "UDPSocket.cpp",
        "UserDB.cpp",
        "UserDBentry.cpp",
        "Utils.cpp",
        "YSFControl.cpp",
        "YSFConvolution.cpp",
        "YSFFICH.cpp",
        "YSFNetwork.cpp",
        "YSFPayload.cpp",
    };

    mmdvmHost.addCSourceFiles(&mmdvmhost_cpp_sources, &mmdvm_cpp_cflags);

    for (libs) |lib_name| {
        mmdvmHost.linkSystemLibrary(lib_name);
    }
    for (lib_paths) |path| {
        mmdvmHost.addLibraryPath(.{ .path = path });
    }

    // RemoteCommand executae
    //const remoteCommand = b.addExecutable("RemoteCommand", null);
    //remoteCommand.setTarget(target);
    //const remoteCommandSources = &[_][]const u8{
    //    "src/Log.cpp", "src/RemoteCommand.cpp", "src/UDPSocket.cpp",
    //};
    //for (remoteCommandSources) |file| {
    //    remoteCommand.addCxxFile(file);
    //}
    //for (globalLibPaths) |path| {
    //    remoteCommand.addLibPath(path);
    //}
    //for (globalLibs) |lib| {
    //    remoteCommand.linkSystemLibrary(lib);
    //}
    //remoteCommand.setOutputDir("zig-out/bin");

    // Set default steps
    b.default_step.dependOn(&mmdvmHost.step);
    //b.default_step.dependOn(&remoteCommand.step);

    b.installArtifact(mmdvmHost);
}
