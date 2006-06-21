Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5LGMdjU026475
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 12:22:39 -0400
Received: from mail4.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5LGMcsi018426
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 16:22:38 GMT
Date: Wed, 21 Jun 2006 12:22:35 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        kmacmillan@tresys.com
Subject: Re: [PATCH] repost: new sockcreate interface to specify context of
 socket when they are created
In-Reply-To: <1150905799.27531.33.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0606211221590.10410@d.namei>
References: <1150902506.27852.35.camel@localhost.localdomain>
 <1150905799.27531.33.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 21 Jun 2006, Stephen Smalley wrote:
> 
> /proc/self/attr/keycreate is in -mm, so this patch won't apply relative
> to it.  Permission definition also has to be regenerated relative to the
> keycreate refpolicy patch, as that took the same permission slot.

I'm manually merging with -mm now.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
