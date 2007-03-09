Subject: Re: Running racoon from init_t?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul.moore@hp.com>, SE Linux <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1173462020.3241.131.camel@moss-spartans.epoch.ncsc.mil>
References: <200703091209.24393.paul.moore@hp.com>
	 <1173461816.3241.129.camel@moss-spartans.epoch.ncsc.mil>
	 <1173462020.3241.131.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 09 Mar 2007 21:30:09 +0000
Message-Id: <1173475809.29664.14.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-09 at 12:40 -0500, Stephen Smalley wrote:
> On Fri, 2007-03-09 at 12:36 -0500, Stephen Smalley wrote:
> > On Fri, 2007-03-09 at 12:09 -0500, Paul Moore wrote:
> > > This is in regards to RHEL5 and the MLS policy.
> > > 
> > > I'm trying to run racoon at startup, from within the rc.local script, which 
> > > means it is being run from init/init_t.  Whenever I try to do this I see the 
> > > following AVC denials:
> > 
> > Should be run from initrc_t (rc.local should have initrc_exec_t on it).
> > Although the inherited fds may still have init_t on them due to being
> > created by /sbin/init and then just inherited by the descendants.
> > 
> > > 
> > > ***
> > > type=AVC msg=audit(1173457995.784:305): avc:  denied  { use } for  pid=2105 
> > > comm="racoon" name="console" dev=tmpfs ino=725 
> > > scontext=system_u:system_r:racoon_t:s0-s15:c0.c1023 
> > > tcontext=system_u:system_r:init_t:s0-s15:c0.c1023 tclass=fd
> > > type=AVC msg=audit(1173457995.784:305): avc:  denied  { use } for  pid=2105 
> > > comm="racoon" name="console" dev=tmpfs ino=725 
> > > scontext=system_u:system_r:racoon_t:s0-s15:c0.c1023 
> > > tcontext=system_u:system_r:init_t:s0-s15:c0.c1023 tclass=fd
> > > type=AVC msg=audit(1173457995.784:305): avc:  denied  { use } for  pid=2105 
> > > comm="racoon" name="console" dev=tmpfs ino=725 
> > > scontext=system_u:system_r:racoon_t:s0-s15:c0.c1023 
> > > tcontext=system_u:system_r:init_t:s0-s15:c0.c1023 tclass=fd
> > > ***
> > > 
> > > I suspect this can fixed by adding the following to the policy, suggestions?
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

I agree.  Actually there's a noticeable amount of services that allow
this already.  If the service has rules that allow the console access,
we can leave the init fd inheritance for now (making note to revisit
it).  But if it doesn't use the console, we can remove the
init_use_fds() and have the fds be dontaudited through the
init_daemon_domain() interface.  Make sense?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
