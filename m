Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i728mwrT010660
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 04:48:59 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i728muKV004779
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 08:48:57 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: hotplug 0.030 not setting selinux permissions on /dev/tty*
Date: Mon, 2 Aug 2004 18:48:22 +1000
Cc: linux-hotplug-devel@lists.sourceforge.net,
   SE-Linux <selinux@tycho.nsa.gov>
References: <20040801160019.GC15949@lkcl.net> <20040801164440.GD15949@lkcl.net>
In-Reply-To: <20040801164440.GD15949@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408021848.22461.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2 Aug 2004 02:44, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> GOT IT!  gotit,gotit,gotit.
>
> watching stuff go by during boot-up, i observed the same
> "matchpathcon cannot find file" error that i - fortunately -
> observed earlier today.
>
> the [unnamed] file it's searching for is of course
> /etc/selinux/something/file_contexts/file_contexts
>
> this file is on /usr/share/selinux and has a symlink to it from
> /etc/selinux.

Then your system is messed up.  It was on older versions of the 
selinux-policy-default package that /etc/selinux was a sym-link.  
Now /etc/selinux/src is a sym-link and /etc/selinux/./contexts/file_contexts 
is on the root file system.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
