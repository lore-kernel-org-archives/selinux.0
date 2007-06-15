Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5FKoTmo009573
	for <selinux@tycho.nsa.gov>; Fri, 15 Jun 2007 16:50:29 -0400
Received: from web36605.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5FKoSY9007785
	for <selinux@tycho.nsa.gov>; Fri, 15 Jun 2007 20:50:29 GMT
Date: Fri, 15 Jun 2007 13:50:28 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC v2][PATCH] selinux:  enable authoritative granting of capabilities
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Sellers <csellers@tresys.com>, Steve G <linux_4ever@yahoo.com>
In-Reply-To: <1181936209.17547.943.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <686318.23489.qm@web36605.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2007-06-15 at 09:05 -0700, Casey Schaufler wrote:
> > Look, you're always badgering people to explain why their LSM
> > facilities can't be done using SELinux, or a tweek to SELinux.
> > When you take this to LKML expect to get exactly the same question
> > (as I posed here) about why SELinux "can't just use" the file
> > capabilities.
> 
> File capabilities don't allow us to assign domain Foo (corresponding to
> a program, a set of programs, a user role, whatever) a capability solely
> through SELinux policy; we have to separately and independently set a
> file capability bitmask on the file in addition to allowing the
> capability under the SELinux policy, and we are limited to the fixed
> capability evolution rules - we can't adjust them to fit specific needs
> as domains transition as we can in policy.  That's the difference; file
> capabilities remain an orthogonal mechanism outside of our policy that
> has to be separately managed, assigned to files, preserved across
> prelinks and updates, incorporated into analysis, etc.
> 
> > My concern is with the future of file capabilities, which I like.
> > I would like to see them move forward for my own nefarious purposes.
> > Those purposes do not require the sophistication of SELinux, so
> > I do not want to see the advance of file capabilities run up
> > against the "SELinux does that, ''just'' use SELinux" argument
> > every time someone wants to improve it. It gets tiresome and
> > consumes way to much of the limited time I have to work on projects.
> 
> This provides a mechanism for people who use SELinux already to manage
> their capabilities fully via SELinux based on roles and domains.  File
> capabilities provides a mechanism for people who don't use SELinux to
> manage their capabilities based on per-file EAs.  They can both be
> merged into mainline as far as I'm concerned.
> 
> > So please explain, so that even an MLS junkie like me can understand,
> > why you can't "just" use the file capability machanism as it's
> > designed.
> 
> It is about being able to fully manage capabilities in policy, just as
> we already fully manage MLS overrides in policy.
> 
> Look, with current SELinux, we have policy rules like:
> 	allow ping_t self:capability net_raw;
> 	allow ping_t ping_exec_t:file entrypoint;
> 	...
> and rpm and friends apply the file contexts mapping to assign
> ping_exec_t to /bin/ping for us when ping is installed/updated and
> prelink knows to preserve that context when prelink'ing the binary, etc.
> And although /bin/ping is suid root, it can only ever use the
> capabilities we've allowed it in policy.
> 
> With my patch, we can further take away the suid root'ness of /bin/ping
> and add a single allow ping_t self:cap_override net_raw; to policy and
> we're done - ping is now able to run with net_raw and policy is
> centralized.  In fact, we wouldn't even need that separate allow rule if
> we just made the existing SELinux capability allow rules always
> authoritative, but I'm taking the conservative and compatible route - no
> change to existing behavior.
> 
> With file capabilities, we have to add an entirely new extended
> attribute (security.capability) to /bin/ping, where that attribute
> directly encodes policy (the actual capability bits, not just a
> descriptive type tag), and now we have duplicated state between policy
> and filesystem.  From a management point of view, the situation is now
> worse than the setuid root binary - I have redundant capability bitmaps
> that I am managing in policy and on a per-file basis.  Meanwhile, rpm
> and friends, prelink, etc have no knowledge of this security.capability
> and will cheerfully blow it away until they are all updated.
> 
> File capabilities are helpful for non-selinux systems.  They don't help
> users of SELinux much at all, if any.

Thank you.

Are you planning to do the same with mode bits? Your arguments
would apply equally well for them, too. It's the authoritative
hooks arguement.




Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
