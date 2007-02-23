Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1NEighS014154
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 09:44:42 -0500
Received: from mail3.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1NEk0gx022157
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 14:46:00 GMT
Date: Fri, 23 Feb 2007 09:45:55 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] Reassign printk levels in selinux kernel code
In-Reply-To: <1172236552.19041.10.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0702230945420.30571@d.namei>
References: <1172185891.3142.48.camel@localhost.localdomain>
 <1172236552.19041.10.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 23 Feb 2007, Stephen Smalley wrote:

> On Thu, 2007-02-22 at 18:11 -0500, Eric Paris wrote:
> > Below is a patch which demotes many printk lines to KERN_DEBUG from
> > KERN_INFO.  It should help stop the spamming of logs with messages in
> > which users are not interested nor is there any action that users should
> > take.  It also promotes some KERN_INFO to KERN_ERR such as when there
> > are improper attempts to register/unregister security modules.
> > 
> > A similar patch was discussed a while back on list:
> > http://marc.theaimsgroup.com/?t=116656343500003&r=1&w=2
> > This patch addresses almost all of the issues raised.  I believe the
> > only advice not taken was in the demoting of messages related to
> > undefined permissions and classes.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Applied to git://git.infradead.org/~jmorris/selinux-2.6#for-akpm



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
