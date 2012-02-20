From: "Radzykewycz, T (Radzy)" <radzy@windriver.com>
To: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Subject: RE: SE Android Issue Compiling Kernel for the Emulator
Date: Mon, 20 Feb 2012 18:36:37 +0000
Message-ID: <33006C99F5A5194A9B7A7715DFA3E38364C709CA@ALA-MBB.corp.ad.wrs.com>
References: <99E44A153A242A488492D7FE003CD99D0487B864@bb-corp-ex3.corp.cubic.cub>
In-Reply-To: <99E44A153A242A488492D7FE003CD99D0487B864@bb-corp-ex3.corp.cubic.cub>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Jason

Since you are running on MAC instead of Linux, you need to change the final build line so that it picks up
the MAC binaries instead of the Linux ones, or make sure that you have Linux compatability enabled.

Enjoy!

                                                       -- radzy

________________________________________
From: owner-selinux@tycho.nsa.gov [owner-selinux@tycho.nsa.gov] on behalf of Fullen, Jason [jason.fullen@cubic.com]
Sent: Monday, February 20, 2012 9:39 AM
To: SELinux@tycho.nsa.gov
Subject: SE Android Issue Compiling Kernel for the Emulator

Hello,

I am having a problem getting SE Android to compile using Mac OS X 10.6 Snow Leopard. First off, I have successfully built and run AOSP, using the Mac, on the emulator. I have also built and installed Ice Cream Sandwich on the Nexus S phone. So I can pretty much guarantee that my build environment has been configured correctly.

I followed the directions on the SE Android wiki and put the  local_manifest.xml file into my .repo directory and then ran “repo sync –j1” again. My next step was to use the following four commands from the SE Android wiki to compile the necessary kernel for the emulator:

export PREFIX=/path/to/your/aospclone
cd $PREFIX/kernel/goldfish
make ARCH=arm goldfish_armv7_defconfig
make ARCH=arm CROSS_COMPILE=$PREFIX/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-

Everything went fine with the first “make” command but the second “make” command that cross compiles with something in that Linux x86 directory failed with the following error:

Imaginuity3:goldfish jfullen$ make ARCH=arm CROSS_COMPILE=$PREFIX/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-
/Volumes/SEAndroid/WORKING_DIRECTORY/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-gcc: /Volumes/SEAndroid/WORKING_DIRECTORY/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-gcc: cannot execute binary file
  CHK     include/linux/version.h
make[1]: `include/asm-arm/mach-types.h' is up to date.
  CHK     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-arm
  CC      kernel/bounds.s
/bin/sh: /Volumes/SEAndroid/WORKING_DIRECTORY/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-gcc: cannot execute binary file
make[1]: *** [kernel/bounds.s] Error 126

I was kind of confused by the “Cannot Execute Binary File” error. I manually checked and confirmed that I had “read and execute” privileges so my user account should have had sufficient privileges to execute that binary file. Has anyone successfully built SE Android using a Mac and seen this error? If so, how did you get around this error? Otherwise, does anyone have any insight into how this problem might be solved?

Thanks in advance,

-Jason



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
