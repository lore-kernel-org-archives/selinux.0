Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA11056
	for <selinux@tycho.nsa.gov>; Sat, 23 Mar 2002 12:29:44 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA29979
	for <selinux@tycho.nsa.gov>; Sat, 23 Mar 2002 17:28:41 GMT
Received: from c001.snv.cp.net (c001-h000.c001.snv.cp.net [209.228.32.114])
        by jazzband.ncsc.mil  with SMTP id RAA29975 for <selinux@tycho.nsa.gov>; Sat, 23 Mar 2002 17:28:40 GMT
From: "Leslie J. French" <ljf@semandex.net>
To: <selinux@tycho.nsa.gov>
Subject: RE: SMP mode?
Date: Sat, 23 Mar 2002 12:30:06 -0500
Message-ID: <BFEMIIHKHLALNELLMPOMMEMOCAAA.ljf@semandex.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.GSO.4.33.0203201538540.11981-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Mar 2002, Leslie J. French wrote:

> I have =y on the following options (via modules/lsm-patch)
>
>  _PACKET _NETLINK _RTNETLINK _NETFILTER _UNIX _INET
>  security: _CAPABILITIES _IP _SELINUX _SELINUX_DEVELOP
>
> the errors are occuring on a UDP socket, at random positions in a
dataflow.

To follow up on my own message -- the same code works perfectly on a
single-processor board built with the "enterprise" kernel with the above
security settings.

Also, I can get the programs to run on the SMP if I slow them down, for
example
by adding print statements.  There is a point at which the operation is
"marginal,"
i.e. sometimes works sometimes doesn't, which is at around
1-character-output-per-packet.
More, and it runs, less and it fails.

I read somewhere that SeLinux will return EPERM if it thinks I'm trying a
buffer overflow exploitation.  Is it possible that running the network at a
very high rate on a dual-processor could confuse the kernel into thinking
it's being attacked?  Is there any way I can check why the EPERM is being
generated?

Thx,  Leslie


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
