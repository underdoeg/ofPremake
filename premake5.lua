OF_LIBS_DIR = "../../../libs"
OF_LOCATION = OF_LIBS_DIR .. "/openFrameworks"


workspace "testApp"
	configurations { "Debug", "Release" }
	language "c++"
	location "project"
	
	buildoptions { 
		"-g3 -Wall -std=c++14 -D_GLIBCXX_USE_CXX11_ABI=0 -DOF_USING_GTK -DOF_USING_GTK -DOF_USING_MPG123 -D_REENTRANT -pthread",
		"`pkg-config freetype2 cairo gtk+-3.0 gstreamer-1.0 fontconfig sndfile glew --cflags`"
	}
	
	defines {
		"GST_VERSION=1.0"
	}
	
	
	includedirs {
		OF_LOCATION,
		OF_LOCATION .. "/**",
		OF_LIBS_DIR .. "/tess2/include",
		OF_LIBS_DIR .. "/poco/include",
		OF_LIBS_DIR .. "/kiss/include",
		OF_LIBS_DIR .. "/glfw/include",
		OF_LIBS_DIR .. "/fmodex/include"
	}
	
	libdirs {
		OF_LIBS_DIR .. "/glfw/lib/linux64/",
		OF_LIBS_DIR .. "/poco/lib/linux64/"
	}
	
	---
	project "openFrameworks"
		files {
			OF_LOCATION .. "/**.cpp", 
			OF_LOCATION .. "/**.h"
		}
		
		removefiles {
			OF_LOCATION .. "/video/ofDirectShowPlayer.cpp",
			OF_LOCATION .. "/video/ofQtUtils.cpp",
			OF_LOCATION .. "/video/ofQuickTimeGrabber.cpp",
			OF_LOCATION .. "/video/ofQuickTimePlayer.cpp"
		}
		
		targetdir "build/"
		
		kind "StaticLib"
 	
 	---
	project "testApp"
		files {"**.cpp", "**.h"}
		kind "ConsoleApp"
		
		targetdir "bin/"
		
		linkoptions {
			"`pkg-config freetype2 cairo gtk+-3.0 gstreamer-1.0 fontconfig sndfile glew --libs`"
		}
		
		links {
			"openFrameworks",
			"boost_system",
			"boost_filesystem",
			"rtaudio",
			"pthread",
			"X11",
			"GL",
			"freeimage",
			"glfw3",
			"PocoCrypto",
			"PocoNet",
			"PocoFoundation"
		}
		
