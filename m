From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
Subject: Re: SELinux on Wheezy
Date: Fri, 10 Feb 2012 00:05:26 +1100
Cc: Stephen Smalley <sds@tycho.nsa.gov>, "SE-Linux" <selinux@tycho.nsa.gov>
References: <1328502407.14110.7074.camel@calcifer> <1328707470.19254.16.camel@moss-pluto> <1328722790.23833.9.camel@foxtrot.cjac.ntr.f5net.com>
In-Reply-To: <1328722790.23833.9.camel@foxtrot.cjac.ntr.f5net.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201202100005.26791.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 9 Feb 2012, "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org> wrote:
> On Wed, 2012-02-08 at 08:24 -0500, Stephen Smalley wrote:
> > On Tue, 2012-02-07 at 13:05 -0800, C.J. Adams-Collier wrote:
> > > cjac@foxtrot:~$ sudo which seinfo
> > > cjac@foxtrot:~$ apt-file search seinfo | grep bin | wc -l
> > > 0
> > 
> > seinfo is part of the setools package.
> 
> $ apt-cache search -n setools
> erlang-parsetools - Erlang/OTP parsing tools
> 
> Hmm.

# apt-cache search -n setools
erlang-parsetools - Erlang/OTP parsing tools
libsetools-java - SETools Java bindings (architecture-independent)
libsetools-jni - SETools Java bindings (architecture-dependent)
libsetools-tcl - SETools Tcl bindings
python-setools - SETools Python bindings
setools - tools for Security Enhanced Linux policy analysis

Works for me when tracking unstable.

http://bugs.debian.org/cgi-bin/pkgreport.cgi?package=setools

But it's got a grave bug and an important bug.  CJ Would you like to help in 
fixing these?  It's probably not going to be any more difficult than building 
your own copy from upstream source.

> > > Sounds reasonable.  Do I get policy from my distribution, or should I
> > > generate one myself?
> > 
> > Normally from your distribution, assuming the selinux packages for
> > Debian are still being maintained.

Of course they are still being maintained.

> I believe they are.  I exchanged email with Russell about it not long
> ago.  But then, gtkglarea is still officially maintained and I made the
> first update in nearly a year 36 hours ago.  Perhaps the package needs 1
> or more co-maintainers to improve coverage.

Yes, more help would be good.

Manoj has disappeared, he has not answered any mail I sent him for a long 
time.  Everything that lists him as the maintainer needs a new maintainer.

> > IIRC, the Debian selinux policy package tries to minimize the set of
> > installed policy modules based on the set of installed packages, but
> > that isn't an exact mapping and might be leaving you without a complete
> > policy.  Whereas Fedora installs all policy modules unconditionally.
> 
> If the overhead is not too great, perhaps this can be duplicated in
> Debian.  I do hate paying for things I don't use, though.  Especially
> when the cost is substantial.  The same is probably true of many other
> Debian users.

The only problem in Debian in this regard is when you install new packages 
after installing the SE Linux policy.  I plan to somehow hook into the package 
installation process to install new policy modules as needed.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
