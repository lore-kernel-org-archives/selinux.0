From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: =?iso-8859-2?q?Magos=E1nyi=20=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Subject: Re: [selinux] Re: SElinux vs. Grsecruity vs. RSBAC (vs. TrustedBSD?)
Date: Tue, 26 Aug 2003 21:06:21 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <FAB2059733EB46409AD28AC957F663F70BEE5C@pusmde04.mt.pweh.com> <20030825170259.GB4409@rahul.net> <1061889339.1665.1548.camel@kusturica>
In-Reply-To: <1061889339.1665.1548.camel@kusturica>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200308262106.21978.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 26 Aug 2003 19:15, Magosányi Árpád wrote:
> It is too much connected to Redhat.

It always annoys me when people say that.  Try using Debian SE Linux systems 
and Red Hat SE Linux systems at any time over tha past 18 months and you 
won't say that.

There is much sample policy that has not been tested properly on Red Hat 
systems, and no work has been done on upgrading live servers with RPM.

Just because the NSA has always released patches against Red Hat versions of 
the various packages does not mean much.  You don't generally expect the 
upstream maintainers of any software to provide patches against all 
distributions' code.  You merely expect them to support what they use.

Red Hat has recently announced support for SE Linux in a future version of the 
AS product and have hired me to work on it.  This means that in the next 
couple of weeks I will get my policy working as well on Red Hat as it does on 
Debian, and then I will work on adding RPM specific features as well as 
policy for all software that is in the AS product.  This will give an 
advantage for Red Hat as there are no plans to write policy for all 
applications in Debian.  One thing that makes this task possible for Red Hat 
AS is that they don't have four different choices for every task.

> It makes an unnecessary
> inconvenience for a lot of users; why the userspace changes are given
> as srpms instead of patches to the upstream? (I guess this can be drawn

The patches are in some cases large and in some cases weren't done in the way 
the upstream desired.  With the new SE Linux a focus will be made by me and 
other people who are involved in getting the patches accepted upstream.  This 
does not have to require that much work by the NSA people.  The NSA have 
limited resources to spend on this, I think it's best for everyone if they 
concentrate on kernel work and other things that they are best at, while 
people from distributions deal with getting patches merged upstream (what 
they are best at).

> from the fact that the authors are americans; considering other
> cultures

Let's not be offensive.  There are lots of other lists that are better suited 
to nationalistic flames.

> Fortunately
> there are good debian maintainers for the selinux packages.
> Not a directly technical but very important consideration: selinux
> is the first and yet only MAC model in the upstream kernel, and is

Along with DTE.  But DTE does not have the level of support that SE Linux has.

> supported by the NSA. It means that selinux have very great probability
> to be the winner implementation, like Apache in web servers.

Also SE Linux is supported by Red Hat, Debian, and Gentoo.  Having the two 
major distributions in English-speaking countries and the distribution that's 
getting the largest amount of users wanting to try new things supporting SE 
Linux puts it in a very good position.

> It might be interesting to include TrustedBSD in the comparison, but I
> know very few of it. It seems that it is a DoD MAC implementation,

It also has support for the SE Linux model.  I've been meaning to install a 
TrustedBSD machine to play with it, but haven't had time.  If someone could 
setup a TBSD play machine then it would be really good.

I suspect that SE Linux would not work out of the box on TBSD.  SE Linux 
configuration needs to know the locations of files and device names.  There 
is no support for TBSD device and file names in the sample policy, so either 
the TBSD people have been holding back on us or they don't have good policy 
support yet.  I would be happy to assist anyone who wants to develop sample 
policy for TBSD and/or to run a TBSD play machine.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
