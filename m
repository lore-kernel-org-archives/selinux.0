Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6VH1LrT003543
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 13:01:22 -0400 (EDT)
Received: from smtp804.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6VH0nHs007763
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 17:00:49 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 31 Jul 2004 17:01:20 -0000
Date: Sat, 31 Jul 2004 18:12:24 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Erich Schubert <erich@debian.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: policy version jumped to 18
Message-ID: <20040731171224.GS3378@lkcl.net>
References: <20040731120634.GK3378@lkcl.net> <20040731141841.GQ3378@lkcl.net> <1091290289.24888.4.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091290289.24888.4.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jul 31, 2004 at 06:11:29PM +0200, Erich Schubert wrote:
> Hi Luke,
> when you use policy utilities and policy files for version 18 you
> probably should upgrade your kernel to support verison 18, too.
 
 ha :)

> I had the same problem; i hacked the makefile so the tools explicitely
> generate a version 17 policy, but the better way to get the kernel patch
> from the selinux homepage and just build a kernel with version 18.

 well, i grabbed the source code from sf.net instead, along with
 apt-get source kernel-image-2.6.7-k7, copied /usr/src/k..../config/k7
 and enabled the selinux stuff.

 so far so bad... :)

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
