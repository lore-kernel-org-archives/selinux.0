Date: Mon, 15 Apr 2002 17:08:42 +0100
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@tislabs.com>,
        "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        Russell Coker <russell@coker.com.au>, Tom <tom@lemuria.org>,
        SELinux@tycho.nsa.gov
Subject: Re: db conflict ?
Message-ID: <20020415160842.GA15960@vnl.com>
References: <72222DC86846D411ABD300A0C9EB08A10152433D@csoc-mail-box.csoconline.com> <Pine.GSO.4.33.0204121514350.21729-100000@raven> <20020412161820.B15470@gricklegrass.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020412161820.B15470@gricklegrass.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 12, 2002 at 04:18:20PM -0400, Howard Holm wrote:
> things in /usr/local/.  Perhaps we can add an environment variable for the
> "prefix" that will default to /usr/local/ but can be set to /usr by
> package maintainers.  I really think the right answer for policy source is
> in /usr/share which by FHS standards should be sharable between
> architectures (and I believe the policy source should be.)  Of course, the
> policy binary has to be on the root partition for booting purposes, but
> I think it's best if for machines that are sharing /usr within an
> architecture and /usr/share between architectures, we let them put policy
> source in /usr/share/.  I can't envision a situation where you would
> need to recompile policy on a system too crippled to mount /usr/share/.

I was playing around with this over Christmas but got swamped with
other things. What you want is for your build script to use "prefix" so
package maintainers can build using:

	configure prefix=/

If you let the default be /usr/local/, then anyone who builds direct
will install to /usr/local.

The problem I ran across was that the various selinux utils have
all sorts of different vars for configure; and also to do it right
you often need to regen the configure script from configure.in.
Some of the utils use just Makefile; others use configure/automake.
It's a real mess.




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
