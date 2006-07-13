Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6DEo15l008629
	for <selinux@tycho.nsa.gov>; Thu, 13 Jul 2006 10:50:01 -0400
Received: from mail7.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6DEnxuS012204
	for <selinux@tycho.nsa.gov>; Thu, 13 Jul 2006 14:49:59 GMT
Date: Thu, 13 Jul 2006 10:49:57 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] Fix security check for joint context= and fscontext=
 mount options
In-Reply-To: <1152793426.10075.193.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0607131048500.5956@d.namei>
References: <1152729678.2823.72.camel@localhost.localdomain>
 <1152793426.10075.193.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 13 Jul 2006, Stephen Smalley wrote:

> On Wed, 2006-07-12 at 14:41 -0400, Eric Paris wrote:
> > After some discussion on the actual meaning of the filesystem class
> > security check in try context mount it was determined that the checks
> > for the context= mount options were not correct if fscontext mount
> > option had already been used.  When labeling the superblock we should be
> > checking relabel_from and relabel_to.  But if the superblock has already
> > been labeled (with fscontext) then context= is actually labeling the
> > inodes, and so we should be checking relabel_from and associate.  This
> > patch fixes which checks are called depending on the mount options.
> > 
> > This is issue is in 2.6.8-rc1-git4 and should probably be fixed before
> > 2.6.18 releases.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: James Morris <jmorris@namei.org>

Eric, you might as well post it to akpm & lkml, as there's nothing else to 
coordinate at this stage.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
