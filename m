Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA06939
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 10:11:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA19015
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 14:09:37 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA19011 for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 14:09:34 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>
Subject: Re: FYI: woody startup messages
Date: Tue, 27 Aug 2002 16:11:01 +0200
References: <20020827125607.A20398@lemuria.org>
In-Reply-To: <20020827125607.A20398@lemuria.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020827141101.5DFB12355@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 27 Aug 2002 12:56, you wrote:
> there's a few other puzzles in there I'll try to solve myself, e.g. why
> proftpd tries to bind some high port.

> Aug 27 12:56:57 nsa kernel: avc:  denied  { name_bind } for  pid=254
> exe=/usr/sbin/proftpd port=5376 scontext=system_u:system_r:ftpd_t
> tcontext=system_u:object_r:ftp_port_t tclass=tcp_socket

5376 >> 8 = 21.

As a quick test on my system, "netcat -l -p 106" as user_t gives the 
following:
avc:  denied  { name_bind } for  pid=22563 exe=/bin/nc port=27136 
scontext=rjc:user_r:user_t tcontext=system_u:object_r:pop_port_t
tclass=tcp_socket

Maybe there's one too many ntohs() calls in the audit code...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
