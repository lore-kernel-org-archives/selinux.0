Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1OKwXRb026182
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 15:58:34 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1OKwXQQ020370
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 20:58:33 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i1OKwWP0020367 for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 20:58:32 GMT
Subject: Re: odd segfault in checkpolicy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1077655600.3508.4.camel@nexus.verbum.private>
References: <1077577191.4374.9.camel@nexus.verbum.private>
	 <1077629291.21221.16.camel@moss-spartans.epoch.ncsc.mil>
	 <1077655600.3508.4.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1077656311.21221.200.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 24 Feb 2004 15:58:31 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-02-24 at 15:46, Colin Walters wrote:
> Ah, that makes sense.  On little-endian machines, the statement 
>    buf[i] = le32_to_cpu(buf[i]);
> became
>    buf[i] = buf[i];
> so gcc optimized it to nothing with -O2.  But on big-endian machines, it
> should have never worked, and it kind of surprises me no one has
> apparently run SELinux on a big-endian machine, at least recently.

Most people don't try to load binary policies with checkpolicy; they
only use it to compile policy.conf, which wouldn't run into this
problem.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
