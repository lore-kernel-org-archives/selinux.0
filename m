Subject: Re: su problems again
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: selinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1202156505.2801.122.camel@bluejay.goodinassociates.com>
References: <1202151733.2801.116.camel@bluejay.goodinassociates.com>
	 <1202152318.3070.121.camel@moss-spartans.epoch.ncsc.mil>
	 <1202154013.2801.119.camel@bluejay.goodinassociates.com>
	 <1202155858.3070.127.camel@moss-spartans.epoch.ncsc.mil>
	 <1202156505.2801.122.camel@bluejay.goodinassociates.com>
Content-Type: text/plain
Date: Mon, 04 Feb 2008 15:27:40 -0500
Message-Id: <1202156860.3070.132.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-02-04 at 14:21 -0600, Jeremiah Jahn wrote:
> that generally resorts to errors like:
> make: *** No rule to make target `usbbases.if', needed by `tmp/all_interfaces.conf'.  Stop.

Ah, that's just because my sample sed script was a bit too aggressive
and changed usbmodules = module to usbbases = base ;)  Just fix that by
hand and you should be fine.  Chris likely knows a cleaner way to do it
(cc'd).

> 
> or when I just changed the build.conf to monolithic=y mono.te throws
> errors. At least the modules actually compile.
> 
> -jj-
> 
> 
> On Mon, 2008-02-04 at 15:10 -0500, Stephen Smalley wrote:
> > On Mon, 2008-02-04 at 13:40 -0600, Jeremiah Jahn wrote:
> > > Apparently I'm not. I'm using 1.33 on a pretty clean RHEL5 box. Any idea
> > > of how difficult it will be to jump to the devel version? Or is there
> > > another way to disable the dontaudits?
> > 
> > Since you said you are building policy from source, you can always just
> > sed -i "s/module/base" policy/modules.conf and then make enableaudit to
> > build everything into base with all dontaudits removed.
> >  
> > > 
> > > 
> > > On Mon, 2008-02-04 at 14:11 -0500, Stephen Smalley wrote:
> > > > On Mon, 2008-02-04 at 13:02 -0600, Jeremiah Jahn wrote:
> > > > > Is there some way to turn of the dontaudit  w/ the refpolicy and a
> > > > > module policy build. make enableaudit seems to only change the base
> > > > > policy, and not any of the policies that actually do anything. 
> > > > > 
> > > > > This is with the refpolicy selinux-refpolicy-sources-20071214-1 running
> > > > > on RHEL5. 
> > > > > 
> > > > > For some reason, when the policy is enforced, I can't su  from a staff_r
> > > > > user, yet when I try with enforcing=0 I don't get any audit messages,
> > > > > and I'm not really comfortable modifying every user oriented admin
> > > > > modules to remove the dontaudit rules. doing so in su.te helped find a
> > > > > few things, but I'm not sure what's blocking it now. 
> > > > 
> > > > If using a recent semodule, you can do semodule -DB to strip the entire
> > > > policy of dontaudit rules and load the result, then semodule -B to
> > > > revert to the original policy.
> > > > 
> > > In 1880 the French captured Detroit but gave it back ... they couldn't
> > > get parts.
> Parkinson's Fifth Law: If there is a way to delay in important decision,
> the good bureaucracy, public or private, will find it.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
