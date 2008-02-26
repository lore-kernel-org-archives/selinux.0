Subject: Re: I have begun merging XWindows Controls into Rawhide.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: russell@coker.com.au, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1204034227.2804.292.camel@moss-spartans.epoch.ncsc.mil>
References: <47C2CBA1.5040807@redhat.com> <1203957368.32061.74.camel@gorn>
	 <47C32259.10505@tycho.nsa.gov>  <200802262026.15197.russell@coker.com.au>
	 <1204033348.32061.168.camel@gorn>
	 <1204034227.2804.292.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 26 Feb 2008 09:01:31 -0500
Message-Id: <1204034491.32061.174.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-02-26 at 08:57 -0500, Stephen Smalley wrote:
> On Tue, 2008-02-26 at 08:42 -0500, Christopher J. PeBenito wrote:
> > On Tue, 2008-02-26 at 20:26 +1100, Russell Coker wrote:
> > > On Tuesday 26 February 2008 07:17, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
> > 
> > > > > This comes back to forthcoming effort for trying to use RBAC for role
> > > > > separation.  That would eliminate the structural complexity we see due
> > > > > to using TE for the role separation
> > > >
> > > > Is work being done on this?  I recall you said you were interested in
> > > > taking on this task.
> > > 
> > > Is this going to involve using roles on filesystem objects?  If not then how 
> > > would you distinguish the files created by different roles?
> > 
> > Yes, the plan is to use roles on objects.
> 
> (note: requires a kernel change)

Right, if you label a directory with a role other than object_r and
create a file in it, the file will get object_r.  Also theres some
userland changes so login programs set the role on the terminal, newrole
changes the role on the terminal, etc.  Now that I think about it, that
causes a problem for RHEL4 and even RHEL5 compatibility for upstream
refpolicy.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
