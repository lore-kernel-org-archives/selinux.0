Message-Id: <F12C2798C0979C4E88A2D8543B821B06397002@us-layton.mail.saic.com>
From: "Meldrum, Matthew S" <MATTHEW.S.MELDRUM@saic.com>
To: "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
Subject: RAID arrays
Date: Tue, 22 Apr 2003 13:37:42 -0700
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm trying to install SELinux on a Dell PE2650 with a RAID-5 array and
running Redhat 8.  

When I do a quickinstall on a clean machine, I configure it with RAID-5 and
ext3 file support, and it runs until exiting with this error:

make[3]: *** [apol_gui.o] Error 1
make[3]: Leaving directory '/root/selinux/tools/setools/apol'
make[2]: *** [install-apol] Error 2
make[2]: Leaving directory '/root/selinux/tools/setools'
make[1]: *** [install] Error 2
make[1]: Leaving directory '/root/selinux/tools'
make: *** [quickinstall] Error 2

When I try to do a step-by-step installation on a clean machine, I configure
it with RAID-5 and ext3 file support in the menu, and each step exits
without an error until I do a make install from the lsm-2.4 directory.  I
get this error message:

/lib/modules/2.4.20-selinux is not a directory.
make[1]: *** [install] Error 1
make[1]: Leaving directory '/root/lsm-2.4/arch/i386/boot'
make: *** [install] Error 2


after trying the quick install and failing, I do the full install, and I get
this when I run make install:

No module aacraid found for kernel 2.4.20-selinux
make[1]: *** [install] Error 1
make[1]: Leaving directory '/root/lsm-2.4/arch/i386/boot'
make: *** [install] Error 2

This all seems to have to do with the RAID array, since aacraid is the
driver for the RAID array.  Any idea why it doesn't work?

Thanks
Matt

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
