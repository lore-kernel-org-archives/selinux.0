Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1RDsdKK028141
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 08:54:39 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1RDsZDp019747
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 13:54:35 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id m1RDrHae006923
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 08:53:18 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id m1RDrHsY006922
	for selinux@tycho.nsa.gov; Wed, 27 Feb 2008 08:53:17 -0500
Subject: Re: default user roles
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1203707351.3669.961.camel@bluejay.goodinassociates.com>
References: <1203704148.3669.953.camel@bluejay.goodinassociates.com>
	 <1203706878.32061.28.camel@gorn>
	 <1203707351.3669.961.camel@bluejay.goodinassociates.com>
Content-Type: text/plain
Date: Fri, 22 Feb 2008 14:38:49 -0500
Message-Id: <1203709129.32061.31.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-02-22 at 13:09 -0600, Jeremiah Jahn wrote:
> Since I'm working with the refpolicy source can I set it up there, or
> does this have to be a file separate from the source?

The equivalent file in the refpolicy source tree would be
config/appconfig-(mcs|mls)/secstaff_u_default_contexts

> On Fri, 2008-02-22 at 14:01 -0500, Christopher J. PeBenito wrote:
> > On Fri, 2008-02-22 at 12:15 -0600, Jeremiah Jahn wrote:
> > > I can't seem to get the login to set the proper initial role for a user.
> > > Every time I login, I end up as auditadm, and not secstaff.
> > > 
> > > I have the following in my policy:
> > [...]
> > > user secstaff_u roles { secstaff_r secadm_r auditadm_r } level s0 range s0 - s0;
> > 
> > You want to make the file /etc/selinux/NAME/contexts/users/secstaff_u
> > with the default contexts that you want.  You probably want at least
> > this:
> > 
> > system_r:local_login_t:s0     auditadm_r:auditadm_t:s0
> > system_r:remote_login_t:s0    auditadm_r:auditadm_t:s0
> > system_r:sshd_t:s0            auditadm_r:auditadm_t:s0

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
