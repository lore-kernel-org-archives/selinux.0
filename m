Date: Mon, 15 Apr 2002 10:44:24 -0400
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@tislabs.com>,
        "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        SELinux@tycho.nsa.gov
Subject: Re: db conflict ?
Message-ID: <20020415104424.B23600@gricklegrass.epoch.ncsc.mil>
References: <Pine.GSO.4.33.0204121514350.21729-100000@raven> <20020412201148.E8D262870D@lyta.coker.com.au> <20020412162551.C15470@gricklegrass.epoch.ncsc.mil> <20020412210141.AD99F3EFE7@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020412210141.AD99F3EFE7@lyta.coker.com.au>; from russell@coker.com.au on Fri, Apr 12, 2002 at 11:01:41PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Could you elaborate on the problems with symbolic links.  My understanding
(perhaps flawed) of RPMS is that it's possible to create a configuration
alterable symbolic link.  (i.e., a symbolic link marked as a configuration
file so that if it's altered, RPM won't restore it when upgrading the
package.)  As little as I know about RPM, I know dramatically less about
Debian packaging, so I really don't know what the situation might be for
.debs.

As I mentioned in my response to Mark W., I think cp -a might loose a lot
of the benefits of the link if I understand you correctly.

On Fri, Apr 12, 2002 at 11:01:41PM +0200, Russell Coker wrote:
> On Fri, 12 Apr 2002 22:25, Howard Holm wrote:
> > Bringing up again a proposal of mine from April 3rd, I suggest that we
> > put the "example" policy in /usr/share/selinux/policy/default/ and
> > compile the policy in automated scripts from
> > /usr/share/selinux/policy/current/.  When creating current, it should
> > be a link to default.  If the admin changes the link or removes it
> > in favor of an actuall local directory then all that happens when an
> > automated script installs new default policy language and recompiles
> > and installs "current" is that the real current policy is reinstalled
> > if it is different than the default.  If it is a link to the default,
> > then the updated default policy is compliled and installed.  This
> > seems to be a good compromise between not arbitrarily replacing a
> > local administrative policy while still allowing the majority of
> > people who use the default policy to have it automatically maintained
> > and added to when adding new packages.
> 
> I like this idea, apart from one issue.
> 
> Symbolically linking to default does not work well with packaging systems, so 
> I'll use "cp -a" instead.
> 
> One benefit of this is that it allows for easily creating several sets of 
> sample configurations that could be used.

--
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
