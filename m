Message-ID: <72222DC86846D411ABD300A0C9EB08A101524365@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'f980215'" <f980215@mailandnews.com>,
        "Westerman, Mark"
	 <Mark.Westerman@csoconline.com>
Cc: SELinux@tycho.nsa.gov
Subject: RE: Install SELinux RPM
Date: Thu, 25 Apr 2002 08:27:43 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


on Thursday, April 25, 2002 1:20 AM, f980215 wrote
> 
> I download selinux-2.4.18-2002031409.i386.rpm
> 
> When I install, found error infomation:
> 
> rpm -Uvh selinux-2.4.18-2002031409.i386.rpm
> 
> ========
> error:unpacking of archive failed on file 
> /lib/modules/2.4.18-selinux/kernel/drivers/char
> /agp/agpgart.o;3cc79ba6: cpio: MD5 sum mismatch

This was verified to be a problem. There was an
error in the upload. I am fixing that and
the EXTRAVERION today. The rpm package will
be taken offline till the fix


Mark

 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
