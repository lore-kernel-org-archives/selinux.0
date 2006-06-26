Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5QDRoN4024842
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 09:27:51 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5QDRmgW005525
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 13:27:49 GMT
Date: Mon, 26 Jun 2006 09:27:46 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: David Howells <dhowells@redhat.com>
cc: Michael LeMay <mdlemay@epoch.ncsc.mil>, sds@tycho.nsa.gov,
        eparis@parisplace.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: inherit /proc/self/attr/keycreate across fork
In-Reply-To: <14355.1151316226@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0606260927290.20117@d.namei>
References: <1150924813.3432.14.camel@moss-tarheels.epoch.ncsc.mil>
 <14355.1151316226@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 26 Jun 2006, David Howells wrote:

> Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:
> 
> > This patch updates SELinux to cause the keycreate process attribute held in
> > /proc/self/attr/keycreate to be inherited across a fork and reset upon execve.
> > This is consistent with the handling of the other process attributes provided
> > by SELinux and also makes it simpler to adapt logon programs to properly
> > handle the keycreate attribute.
> 
> Please post it to Andrew Morton directly as soon as possible.

I was waiting for an ack from Stephen Smalley, but it looks ok I guess.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
