Subject: Re: [PATCH 3/3] Refpolicy: allow netlabelctl to be run at boot
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Paul Moore <paul.moore@hp.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <4607E9AC.80408@redhat.com>
References: <20070309203327.709750017@hp.com>
	 <20070309203513.357373998@hp.com> <1174922303.28830.24.camel@sgc>
	 <200703261129.51045.paul.moore@hp.com>  <4607E9AC.80408@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Mar 2007 11:43:06 -0400
Message-Id: <1174923786.3864.124.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-03-26 at 11:41 -0400, Daniel J Walsh wrote:
> Paul Moore wrote:
> > On Monday, March 26 2007 11:18:23 am Christopher J. PeBenito wrote:
> >   
> >> On Fri, 2007-03-09 at 16:33 -0400, Paul Moore wrote:
> >>     
> >>> Allow the NetLabel management tools to be run at boot from the init
> >>> scripts.
> >>>       
> >> Is this actually a daemon or just a regular application?  If its not a
> >> daemon it should be using init_system_domain() instead.
> >>     
> >
> > Check our email from last Friday (3/23).  It's okay, it's Monday morning ;)
> >
> > I agree, knowing what I know now it should be init_system_domain(), there is 
> > probably another change needed as this patch seemed to introduce a bug (or 
> > flush out an old one) which Dan fixed in selinux-policy-2.4.6-47 for RHEL5.  
> > Unfortunately, I can't get at the RPM right now (got a pointer Dan?) so I 
> > can't do a diff and see what changed ...
> >
> > It is probably best to hold on this for now, sorry for the confusion, but I 
> > was hoping to have the fix for this by now.
> >
> >   
> RHEL5 and Rawhide policy are identical.  I have no problem changing to 
> init_system_domain.

IIRC, using init_daemon_domain() was causing problems (over on
redhat-lspp list) because it was causing netlabelctl to trigger a role
transition to system_r when run by the admin, and the admin wasn't
necessarily authorized for system_r directly.  Not sure whether that is
just a misconfiguration of users there (i.e. you must authorize admins
for system_r if you are going to use automatic role transitions to
system_r rather than run_init, but I don't think run_init really works
for Fedora or RHEL today since it won't be invoked when rpm %post
scriptlets restart services).

But in any event, netlabelctl is not a daemon, so init_system_domain is
more appropriate anyway (along with whatever is needed to also
transition when run by an admin).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
