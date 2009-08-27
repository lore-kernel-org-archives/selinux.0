Subject: Re: bugzilla 518569 discusses making vsftpd SELinux aware.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1251385351.2428.146.camel@moss-pluto.epoch.ncsc.mil>
References: <4A968455.3050209@redhat.com>
	 <1251382591.8357.59.camel@gorn.columbia.tresys.com>
	 <1251385351.2428.146.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 27 Aug 2009 11:07:08 -0400
Message-Id: <1251385628.2428.147.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-08-27 at 11:02 -0400, Stephen Smalley wrote:
> On Thu, 2009-08-27 at 10:16 -0400, Christopher J. PeBenito wrote:
> > On Thu, 2009-08-27 at 09:04 -0400, Daniel J Walsh wrote:
> > > https://bugzilla.redhat.com/show_bug.cgi?id=518569
> > > 
> > > The discussion surrounds potentially adding setcon function to vstfpd
> > > to drop level to a level appropriate the the user when he logs in.
> > > The discussion is around using MCS for this, but I guess I could see
> > > some utilization around MLS.
> > > 
> > > Not sure MLS would go for it though since there is a potential for
> > > information leak.
> > 
> > I'm not sure I like it this idea, but I wanted to throw it out anyway:
> > why not just change to the user's complete login context (or a context
> > that is a subset of it), rather than just the level?
> 
> What happens if we just add pam_selinux entries to /etc/pam.d/vsftpd,
> and add a system_r:ftpd_t entry to the default_contexts configuration?

Oh, obviously that only affects subsequent execve() calls.  Which should
help with e.g. executing /bin/ls, but not with direct accesses by the
main daemon.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
