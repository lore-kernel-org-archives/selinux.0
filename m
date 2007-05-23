Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4NDO72f011953
	for <selinux@tycho.nsa.gov>; Wed, 23 May 2007 09:24:07 -0400
Received: from mail2.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4NDO6m0017386
	for <selinux@tycho.nsa.gov>; Wed, 23 May 2007 13:24:06 GMT
Date: Wed, 23 May 2007 09:24:03 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
cc: sds@tycho.nsa.gov, jmorris@redhat.com, eparis@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: selinux: add object class discovery v2
In-Reply-To: <1179925929721-git-send-email-cpebenito@tresys.com>
Message-ID: <Line.LNX.4.64.0705230923490.30455@d.namei>
References: <1179925929721-git-send-email-cpebenito@tresys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 23 May 2007, Christopher J. PeBenito wrote:

> Add support to SELinux for userland to discover object classes and their
> permissions.  This patch set adds a class directory to the root of selinuxfs
> and a tree of object classes and permissions, with the value for each of the
> respective component.

Looks good.  I'll do some testing & wait for an ack from Stephen.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
