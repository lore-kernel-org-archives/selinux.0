Message-ID: <003701c1ec21$5199e2c0$780aa8c0@r213>
From: "f980215" <f980215@mailandnews.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
Cc: <SELinux@tycho.nsa.gov>
References: <72222DC86846D411ABD300A0C9EB08A101524360@csoc-mail-box.csoconline.com>
Subject: Install SELinux RPM
Date: Thu, 25 Apr 2002 14:20:22 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,all

I download selinux-2.4.18-2002031409.i386.rpm

When I install, found error infomation:

rpm -Uvh selinux-2.4.18-2002031409.i386.rpm

========
error:unpacking of archive failed on file /lib/modules/2.4.18-selinux/kernel/drivers/char
/agp/agpgart.o;3cc79ba6: cpio: MD5 sum mismatch

Also,

Where can found:  SELINUX  + FreeS/WAN rpm package ?

Can someone help me?

Thanks

f980215

----- Original Message ----- 
Subject: SELinux RPM


The RedHat rpm version of selinux
has been release to sourceforge

www.sourceforge.net/projects/selinux

This a beta release and feedback will
only make it better




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
