Date: Fri, 12 Apr 2002 16:25:51 -0400
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@tislabs.com>,
        "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        Tom <tom@lemuria.org>, SELinux@tycho.nsa.gov
Subject: Re: db conflict ?
Message-ID: <20020412162551.C15470@gricklegrass.epoch.ncsc.mil>
References: <Pine.GSO.4.33.0204121514350.21729-100000@raven> <20020412201148.E8D262870D@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020412201148.E8D262870D@lyta.coker.com.au>; from russell@coker.com.au on Fri, Apr 12, 2002 at 10:11:48PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Bringing up again a proposal of mine from April 3rd, I suggest that we
put the "example" policy in /usr/share/selinux/policy/default/ and
compile the policy in automated scripts from
/usr/share/selinux/policy/current/.  When creating current, it should
be a link to default.  If the admin changes the link or removes it
in favor of an actuall local directory then all that happens when an
automated script installs new default policy language and recompiles
and installs "current" is that the real current policy is reinstalled
if it is different than the default.  If it is a link to the default,
then the updated default policy is compliled and installed.  This
seems to be a good compromise between not arbitrarily replacing a
local administrative policy while still allowing the majority of
people who use the default policy to have it automatically maintained
and added to when adding new packages.

On Fri, Apr 12, 2002 at 10:11:48PM +0200, Russell Coker wrote:
> On Fri, 12 Apr 2002 21:17, Stephen Smalley wrote:
> > On Fri, 12 Apr 2002, Westerman, Mark wrote:
> > > Could you think about placing the policy sources
> > > into the /usr/local/selinux Directory
> > >
> > > For new version of selinux the install could look and
> > > see if there is a /usr/local/selinux/policy and setfiles
> > > if the directories are present the install will populate then
> > > with the example policy. If the directories are present just
> > > overwrite the /usr/local/selinux/share/doc/example files.
> >
> > This is fine with me.  It merely involves adding a new target to the
> > policy and setfiles Makefiles to install the sources for the
> > configurations and then adjusting the README and quickinstall target to
> > include that step.
> 
> This is no benefit for me, and may actually just add work as I have to remove 
> your code.
> 
> To do this in Debian packages I have to do this all myself, and I expect that 
> the same applies to RPMs.  So essentially if you do the same thing in the 
> upstream you'll possibly benefit Slackware users, but no-one else.
> 
> Also we need more than this.  We need code to detect changes in the sample 
> policy and to offer the users conveniant ways of tracking them.

--
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
