Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA24993
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 15:03:46 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA19675
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 20:02:24 GMT
Received: from c001.snv.cp.net (c001-h001.c001.snv.cp.net [209.228.32.115])
	by jazzswing.ncsc.mil  with SMTP id UAA19671
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 20:02:24 GMT
From: "Leslie J. French" <ljf@semandex.net>
To: <selinux@tycho.nsa.gov>
Subject: RE: SMP mode?
Date: Wed, 20 Mar 2002 15:04:38 -0500
Message-ID: <BFEMIIHKHLALNELLMPOMCEMFCAAA.ljf@semandex.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.GSO.4.33.0203201355360.11981-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen D. Smalley wrote:

> As far as I know, SELinux _should_ work on SMP, but it hasn't been tested.
> SELinux uses coarse-grained locking at present, but that shouldn't
> manifest as denials.  What are your kernel config option settings,
> particularly the CONFIG_SECURITY_* settings?

I have =y on the following options (via modules/lsm-patch)

 _PACKET _NETLINK _RTNETLINK _NETFILTER _UNIX _INET
 security: _CAPABILITIES _IP _SELINUX _SELINUX_DEVELOP

the errors are occuring on a UDP socket, at random positions in a dataflow.

Leslie





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
