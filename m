Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4MDlKI4021341
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 09:47:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4MDlKtV013384
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 13:47:20 GMT
Received: from nox.lemuria.org (nox.lemuria.org [213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id h4MDlHal013381 for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 13:47:18 GMT
Date: Thu, 22 May 2003 15:48:22 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: pxe, tftpd and rsync policies
Message-ID: <20030522154816.C6588@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I'm currently trying to write policies for a pxe daemon, tftpd and
rsync run as a daemon. This is part of a system imager server that I'm
installing at work. The background is that an image server definitely 
needs to be trustworthy. 
That might not mesh very well with tftpd and rsync at first glance, but
that is a different problem.


The relationship between pxe and tftpd is pretty close. I was thinking 
of merging them into one policy, in fact. Likewise, rsync is used 
slightly customized in this setting, and will need new file types and
access rules just for system imager operation.

I'm looking for input on how to organize this policy. So far, I've
edited the tftpd policy and written new ones for rsync and pxe. I will
also have to write policies for the system imager tool set.

On the other hand, I could merge all these changes into one
systemimager policy. But then this policy would overlap in part with
other policies (currently just tftpd, but who says there won't be an
rsync or pxe policy one day?).

I could also write a systemimager.te for the tools and sprinkle
ifdef(`systemimager.te' throughout the other policies - but do we
really want to fill policies with dozens of "if this special package is
being used..." ?


What's the preferred approach here?


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
