Subject: Re: [patch] selinux:  handle files opened with flags 3 by checking
	ioctl permission
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        selinux <selinux@tycho.nsa.gov>, linux-security-module@vger.kernel.org,
        casey@schaufler-ca.com
In-Reply-To: <1205762476.3919.0.camel@localhost.localdomain>
References: <1205349239.2925.11.camel@localhost.localdomain>
	 <7e0fb38c0803121220w21275aadl7f148eccf645a7f1@mail.gmail.com>
	 <43af0f430803130456y844d429j2a64fb46ec4d71a7@mail.gmail.com>
	 <1205504199.22912.52.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0803170840430.24928@us.intercode.com.au>
	 <1205758518.22912.154.camel@moss-spartans.epoch.ncsc.mil>
	 <1205762476.3919.0.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 17 Mar 2008 10:19:49 -0400
Message-Id: <1205763589.22912.201.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-03-17 at 10:01 -0400, Eric Paris wrote:
> On Mon, 2008-03-17 at 08:55 -0400, Stephen Smalley wrote:
> > On Mon, 2008-03-17 at 08:41 +1100, James Morris wrote:
> > > On Fri, 14 Mar 2008, Stephen Smalley wrote:
> > > 
> > > > Alternatively, we could default to returning FILE__IOCTL from
> > > > file_to_av() if the f_mode has neither FMODE_READ nor FMODE_WRITE, and
> > > > thus check ioctl permission on exec or transfer, thereby validating such
> > > > descriptors early as with normal r/w descriptors and catching leaks of
> > > > them prior to attempted usage.
> > > 
> > > I think this sounds like a good plan.
> > 
> > Handle files opened with flags 3 by checking ioctl permission.
> > 
> > Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
> > 
> > ---
> > 
> >  security/selinux/hooks.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 4bf4807..7d82aa2 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -1629,6 +1629,12 @@ static inline u32 file_to_av(struct file *file)
> >  		else
> >  			av |= FILE__WRITE;
> >  	}
> > +	if (!av) {
> 
> We have the flags, would we rather check
> 
> if ((file->f_flags & O_ACCMODE) == O_ACCMODE)
> 
> This way we would still catch and BUG's we don't know about?

That would be a bug in the core kernel, not a bug in SELinux, so it
seems more like something one would test in the VFS than in SELinux.

Also, even if there were other ways to create such an open file other
than opening with flags 3, I'm not sure we'd do anything differently
here - the descriptor is for control purposes only and checking ioctl
makes sense.

> 
> > +		/*
> > +		 * Special file opened with flags 3 for ioctl-only use.
> > +		 */
> > +		av = FILE__IOCTL;
> > +	}
> >  
> >  	return av;
> >  }
> > 
> > 
> > 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
