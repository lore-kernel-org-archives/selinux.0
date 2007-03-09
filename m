From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Running racoon from init_t?
Date: Fri, 9 Mar 2007 14:31:11 -0500
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J.PeBenito" <cpebenito@tresys.com>
References: <200703091209.24393.paul.moore@hp.com> <1173461816.3241.129.camel@moss-spartans.epoch.ncsc.mil> <1173462020.3241.131.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1173462020.3241.131.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703091431.12416.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, March 9 2007 12:40:20 pm Stephen Smalley wrote:
> On Fri, 2007-03-09 at 12:36 -0500, Stephen Smalley wrote:
> > On Fri, 2007-03-09 at 12:09 -0500, Paul Moore wrote:
> > > I suspect this can fixed by adding the following to the policy,
> > > suggestions?
> > >
> > >  init_use_fds(racoon_t)
> >
> > I'd have expected it to pick up the right rules from being an
> > init_daemon_domain().
>
> Actually, I'd tend to think that should be dontaudit'd - it doesn't have
> a legitimate need to access the console, right?  Then SELinux will just
> close the descriptor silently and replace it with a ref to the null
> device.

That sounds reasonable as any configuration done in in this context will have 
to be from a configuration file and not from stdin.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
