Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA07008
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 10:16:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA25864
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 14:15:28 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id OAA25860
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 14:15:27 GMT
Date: Tue, 27 Aug 2002 16:16:33 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: FYI: woody startup messages
Message-ID: <20020827161633.A23590@lemuria.org>
References: <20020827125607.A20398@lemuria.org> <20020827141101.5DFB12355@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020827141101.5DFB12355@lyta.coker.com.au>; from russell@coker.com.au on Tue, Aug 27, 2002 at 04:11:01PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 27, 2002 at 04:11:01PM +0200, Russell Coker wrote:
> Maybe there's one too many ntohs() calls in the audit code...

maybe there is also a bug in the path output? look at this:

Aug 27 16:24:30 nsa kernel: avc:  denied  { getattr } for  pid=614 exe=/bin/ls path=/local/bin dev=03:06 ino=1586155 scontext=tom:user_r:user_t tcontext=system_u:object_r:seuser_exec_t tclass=dir
Aug 27 16:24:30 nsa kernel: avc:  denied  { read } for  pid=614 exe=/bin/ls path=/local/bin dev=03:06 ino=1586155 scontext=tom:user_r:user_t tcontext=system_u:object_r:seuser_exec_t tclass=dir


the command that caused this error was:

tom@nsa:~$ ls /usr/local/bin


and this is consistent. everywhere I look, the initial /usr is stripped
from the path. same for content in /var, but not for /etc. on this
system, /usr and /var are on their own partitions, /etc is not - is it 
possible that it strips the mount point away?


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
