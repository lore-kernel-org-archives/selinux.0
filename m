Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA14312
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 09:46:30 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h14EkTI19932
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 14:46:29 GMT
Received: from nox.lemuria.org (nox.lemuria.org [213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id h14EkTf19928 for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 14:46:29 GMT
Date: Tue, 4 Feb 2003 15:46:13 +0100
From: Tom <tom@lemuria.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux question?
Message-ID: <20030204154613.A7115@lemuria.org>
References: <200301271320.IAA05862@moss-shockers.ncsc.mil> <200302012351.48969.russell@coker.com.au> <3E3F72AE.1070503@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E3F72AE.1070503@redhat.com>; from dwalsh@redhat.com on Tue, Feb 04, 2003 at 02:58:38AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, Feb 04, 2003 at 02:58:38AM -0500, Daniel J Walsh wrote:
> Why are certain applications (ls, cp, cd) ported to use SELinux with the 
> standard names, while others
> (spasswd, schfn) have a prefix added?  

ls, ps and others are modified versions of the originals.

spasswd, and the other s* programs are wrappers around the original
tools. For various reasons, this was the only or better way of making
them SE-aware in those cases.



-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
