Date: Mon, 15 Apr 2002 10:40:26 -0400
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
Cc: Stephen Smalley <sds@tislabs.com>, Russell Coker <russell@coker.com.au>,
        Tom <tom@lemuria.org>, SELinux@tycho.nsa.gov
Subject: Re: db conflict ?
Message-ID: <20020415104026.A23600@gricklegrass.epoch.ncsc.mil>
References: <72222DC86846D411ABD300A0C9EB08A101524343@csoc-mail-box.csoconline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524343@csoc-mail-box.csoconline.com>; from Mark.Westerman@csoconline.com on Fri, Apr 12, 2002 at 03:33:44PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 12, 2002 at 03:33:44PM -0500, Westerman, Mark wrote:
> Ok,
> 
> How about this.
> 
> For a binary RPM package.
> I will rename all added utils from the NSA
> i.e 
> logrotate-3.5.9 to logrotate-selinux-3.5.9
> 
> The binary package will install the logrotate into
> it normal (for Redhat at least) location.
> I will have rpm do an uninstall of the
> previous version of logrotate then instll the 
> NSA modified logrotate. The NSA modified version will 
> insert a conflict to the normal logrotate.

I'm not sure what you mean by "have rpm do an uninstall"
I would think that a "supercedes: logrotate" and maybe
"provides: logrotate" would cause the replacement to be
automatic and cause less confusion for other packages
that might depend on logrotate than a "conflicts" would.

> When changes for the modified packages are migrated
> upstream with the standard source then the modified
> NSA packages can be deleted
> 
> Standard Example Policy will install to 
> 
> /usr/share/doc/selinux/examples/policy/
> 
> (Howard, I agree with Russell on the
>  example policy directory, that is where 
>  standard examples go)
> 
> if the Directory
> 
> /etc/selinux/policy
> /etc/selinux/setfiles
> 
> do not exist I will install the example policy into
> the respective directories. If they do exist I will
> treat the install as an upgrade and not touch the
> touch the /etc/selinux directory structure
> This will require a single user mode installation

I'm not sure I I'm not understanding you or you and
Russell aren't understanding me.  The reason I thought
that (by default) a link would be good in
/usr/share/doc/selinux/examples/policy is that it
allows the policy to be built by packages containing
new policy unconditionally.  If the policy has been
replaced by a local policy it is rebuilt, but nothing
is changed.  However, if the policy hasn't been
modified locally, any updates are automatically
included.  It was my understanding (although I'm not
an RPM expert) that the link could be "labeled" as
a configuration file in the RPM and thus if it is
altered locally, RPM won't complain or replace it.

Maybe I'm still not awake after the weekend, I'm not
sure why this would require a single user mode
installation,  If the RPM is reloading the policy
it may fail the first time (when the new kernel
hasn't yet been booted, but I don't see why this
couldn't be handled gracefully by the RPM.  It doesn't
seem any worse than most kernel upgrades (which also
require a reboot to complete.)

> > -----Original Message-----
> > From: Howard Holm [mailto:hdholm@epoch.ncsc.mil]
> > Sent: Friday, April 12, 2002 3:18 PM
> > To: Stephen Smalley
> > Cc: Westerman, Mark; Russell Coker; Tom; SELinux@tycho.nsa.gov
> > Subject: Re: db conflict ?
> > 
> > 
> > I think I agree with Russell that binary packages shouldn't 
> > be installing
> > things in /usr/local/.  Perhaps we can add an environment 
> > variable for the
> > "prefix" that will default to /usr/local/ but can be set to /usr by
> > package maintainers.  I really think the right answer for 
> > policy source is
> > in /usr/share which by FHS standards should be sharable between
> > architectures (and I believe the policy source should be.)  
> > Of course, the
> > policy binary has to be on the root partition for booting 
> > purposes, but
> > I think it's best if for machines that are sharing /usr within an
> > architecture and /usr/share between architectures, we let 
> > them put policy
> > source in /usr/share/.  I can't envision a situation where you would
> > need to recompile policy on a system too crippled to mount 
> > /usr/share/.
> > 
> > I'm not sure why Russell decided on 
> > /usr/share/doc/selinux/examples/policy/.
> > I probably would have put the policy directory higher in the hierarchy
> > something like /usr/share/selinux/policy/ maybe, but that's 
> > not a big issue.
> > 
> > On Fri, Apr 12, 2002 at 03:17:05PM -0400, Stephen Smalley wrote:
> > > On Fri, 12 Apr 2002, Westerman, Mark wrote:
> > > 
> > > > Could you think about placing the policy sources
> > > > into the /usr/local/selinux Directory
> > > >
> > > > For new version of selinux the install could look and
> > > > see if there is a /usr/local/selinux/policy and setfiles
> > > > if the directories are present the install will populate then
> > > > with the example policy. If the directories are present just
> > > > overwrite the /usr/local/selinux/share/doc/example files.
> > > 
> > > This is fine with me.  It merely involves adding a new target to the
> > > policy and setfiles Makefiles to install the sources for the
> > > configurations and then adjusting the README and 
> > quickinstall target to
> > > include that step.

--
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
