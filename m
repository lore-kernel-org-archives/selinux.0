Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA07200
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 10:33:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA26963
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 14:32:01 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA26939
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 14:31:59 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>
Subject: Re: FYI: woody startup messages
Date: Tue, 27 Aug 2002 16:32:58 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20020827125607.A20398@lemuria.org> <20020827141101.5DFB12355@lyta.coker.com.au> <20020827161633.A23590@lemuria.org>
In-Reply-To: <20020827161633.A23590@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020827143258.A077D2355@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 27 Aug 2002 16:16, Tom wrote:
> On Tue, Aug 27, 2002 at 04:11:01PM +0200, Russell Coker wrote:
> > Maybe there's one too many ntohs() calls in the audit code...
>
> maybe there is also a bug in the path output? look at this:
>
> Aug 27 16:24:30 nsa kernel: avc:  denied  { getattr } for  pid=614
> exe=/bin/ls path=/local/bin dev=03:06 ino=1586155
> scontext=tom:user_r:user_t tcontext=system_u:object_r:seuser_exec_t
> tclass=dir Aug 27 16:24:30 nsa kernel: avc:  denied  { read } for  pid=614
> exe=/bin/ls path=/local/bin dev=03:06 ino=1586155
> scontext=tom:user_r:user_t tcontext=system_u:object_r:seuser_exec_t
> tclass=dir
>
>
> the command that caused this error was:
>
> tom@nsa:~$ ls /usr/local/bin

dev=03:06 is /dev/hda6 which would be the device node for your /usr file 
system.

Steve previously mentioned that the mount point information is not easily 
available to that kernel code (and may be obscured in the case of mount 
--bind).

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
