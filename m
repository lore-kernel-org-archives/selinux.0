Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAULAtIi021141
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 16:10:55 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAUL9M8x024570
	for <selinux@tycho.nsa.gov>; Tue, 30 Nov 2004 21:09:22 GMT
Subject: Re: libselinux fails to build on mips and mipsel machines, patch
	included
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <87k6smjl6u.fsf@glaurung.internal.golden-gryphon.com>
References: <87k6smjl6u.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Message-Id: <1101848691.4401.127.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 30 Nov 2004 16:04:51 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-16 at 02:40, Manoj Srivastava wrote:
>         The asm syntax on mips and mipsel machines is similar to that
>  of the alphas, so the following patch is required to have libselinux
>  build on mips machines.

Thanks, merged.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
