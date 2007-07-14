Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6EE9r9c004322
	for <selinux@tycho.nsa.gov>; Sat, 14 Jul 2007 10:09:53 -0400
Received: from mail2.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6EE9qRj009322
	for <selinux@tycho.nsa.gov>; Sat, 14 Jul 2007 14:09:52 GMT
Date: Sat, 14 Jul 2007 10:09:48 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, michal.k.k.piotrowski@gmail.com
Subject: Re: [PATCH 2/2] NetLabel: enable dynamic activation/deactivation of
 NetLabel/SELinux enforcement
In-Reply-To: <20070714031651.566974004@hp.com>
Message-ID: <Line.LNX.4.64.0707141008330.25781@d.namei>
References: <20070714030401.888612123@hp.com> <20070714031651.566974004@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 13 Jul 2007, Paul Moore wrote:

> Create a new NetLabel KAPI interface, netlbl_enabled(), which reports on the
> current runtime status of NetLabel based on the existing configuration.  LSMs
> that make use of NetLabel, i.e. SELinux, can use this new function to determine
> if they should perform NetLabel access checks.  This patch changes the
> NetLabel/SELinux glue code such that SELinux only enforces NetLabel related
> access checks when netlbl_enabled() returns true.

This should be the first patch, so a git-bisect doesn't break userspace. 
(I can re-order them for merge, as long as they apply ok in that order).


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
