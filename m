Date: Fri, 12 Apr 2002 16:18:20 -0400
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: Stephen Smalley <sds@tislabs.com>
Cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        Russell Coker <russell@coker.com.au>, Tom <tom@lemuria.org>,
        SELinux@tycho.nsa.gov
Subject: Re: db conflict ?
Message-ID: <20020412161820.B15470@gricklegrass.epoch.ncsc.mil>
References: <72222DC86846D411ABD300A0C9EB08A10152433D@csoc-mail-box.csoconline.com> <Pine.GSO.4.33.0204121514350.21729-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0204121514350.21729-100000@raven>; from sds@tislabs.com on Fri, Apr 12, 2002 at 03:17:05PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think I agree with Russell that binary packages shouldn't be installing
things in /usr/local/.  Perhaps we can add an environment variable for the
"prefix" that will default to /usr/local/ but can be set to /usr by
package maintainers.  I really think the right answer for policy source is
in /usr/share which by FHS standards should be sharable between
architectures (and I believe the policy source should be.)  Of course, the
policy binary has to be on the root partition for booting purposes, but
I think it's best if for machines that are sharing /usr within an
architecture and /usr/share between architectures, we let them put policy
source in /usr/share/.  I can't envision a situation where you would
need to recompile policy on a system too crippled to mount /usr/share/.

I'm not sure why Russell decided on /usr/share/doc/selinux/examples/policy/.
I probably would have put the policy directory higher in the hierarchy
something like /usr/share/selinux/policy/ maybe, but that's not a big issue.

On Fri, Apr 12, 2002 at 03:17:05PM -0400, Stephen Smalley wrote:
> On Fri, 12 Apr 2002, Westerman, Mark wrote:
> 
> > Could you think about placing the policy sources
> > into the /usr/local/selinux Directory
> >
> > For new version of selinux the install could look and
> > see if there is a /usr/local/selinux/policy and setfiles
> > if the directories are present the install will populate then
> > with the example policy. If the directories are present just
> > overwrite the /usr/local/selinux/share/doc/example files.
> 
> This is fine with me.  It merely involves adding a new target to the
> policy and setfiles Makefiles to install the sources for the
> configurations and then adjusting the README and quickinstall target to
> include that step.

--
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
