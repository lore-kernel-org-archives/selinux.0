Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3HGMhg8012487
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 12:22:43 -0400
Received: from Bishop.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3HGMfW2007705
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 16:22:42 GMT
From: "Jeremy A. Mowery" <jmowery@tresys.com>
To: Ken YANG <spng.yang@gmail.com>
Subject: Re: autoreconf fails in setools of revision 4290
Date: Tue, 17 Apr 2007 12:26:50 -0400
References: <4624897D.5030205@gmail.com>
In-Reply-To: <4624897D.5030205@gmail.com>
Cc: selinux@tycho.nsa.gov, setools@tresys.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200704171226.51102.jmowery@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 17 April 2007 04:46, you wrote:
> 
> hi all,
> 
> i use autoconf-2.61-8.fc7 in fc7 rawhide
> 
> autoreconf of this version fails in building setools of
> revision 4290.
> 
> i also test setools 3.1 tags, it fails with the same errors:
> 
> ......
> sediff/Makefile.am:45: notdir $@: non-POSIX variable name
> sediff/Makefile.am:45: (probably a GNU make extension)
> sediff/Makefile.am:48: notdir $@: non-POSIX variable name
> sediff/Makefile.am:48: (probably a GNU make extension)
> sediff/Makefile.am:51: notdir $@: non-POSIX variable name
> sediff/Makefile.am:51: (probably a GNU make extension)
> autoreconf: automake failed with exit status: 1
> 
We were unable to reproduce this error.
We are currently building with:
autoconf (GNU Autoconf) 2.59
automake (GNU automake) 1.9.6
GNU Make 3.80

Could you send further information about the build tools you are using?

 - Jeremy A. Mowery
> thanks in advance
> 
> Ken YANG

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
