Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3DEWURb016556
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 10:32:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3DEWTmw014123
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 14:32:29 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i3DEWS4w014117 for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2004 14:32:28 GMT
Subject: RE: Problems with 2.4.24
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: =?iso-8859-2?Q?Jaros=B3aw?= Nozderko <jaroslaw.nozderko@polkomtel.com.pl>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <2A857CE92C11FE40858689CAEC7BED490A439367@E2K2.corp.plusnet>
References: <2A857CE92C11FE40858689CAEC7BED490A439367@E2K2.corp.plusnet>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1081866741.21530.88.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 13 Apr 2004 10:32:21 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-04-13 at 10:20, Jarosław Nozderko wrote:
> OK... Is it possible to boot in permissive mode and then manually 
> switch to enforcing with loading policy or something like this,
>  just for testing ?

You need to load policy very early in order for the system to function
as expected.  It was originally loaded by the kernel itself, then pushed
up into userspace and handled via an initrd, and then finally moved into
/sbin/init.

> Or is it easier to just use Fedora Core for educational purposes ?

I'm not sure what the status on SuSE SELinux packages is; hopefully
someone else on the list will respond to that.  Other options include
Fedora Core 2 test2/devel, Hardened Gentoo, and Debian.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
