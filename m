Subject: Re: Current/Future Plans to Support Stacking LSM Modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: Karl MacMillan <kmacmill@redhat.com>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <681036.75164.qm@web36611.mail.mud.yahoo.com>
References: <681036.75164.qm@web36611.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 15:29:59 -0500
Message-Id: <1169152199.22731.397.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-01-18 at 10:12 -0800, Casey Schaufler wrote:
> --- Karl MacMillan <kmacmill@redhat.com> wrote:
> 
> > > There are others who would argue that SELinux
> > > has abandoned the Linux privilege model and
> > > thus disrupted the unity of the existing
> > > security model.
> > > 
> > 
> > No clue what this means.
> 
> Pre-SE Linux has a rational and well
> established security model that includes
> DAC and Privilege. The capability scheme
> is designed to fit that model, adding the
> logical extention from the POSIX statements
> of "appropruate privilege" to defining what
> those privileges would be.
> 
> SELinux does not use capabilities to identify
> where "policy" is excepted, rather it defines
> policy in such a way as to make the notion of
> exception unnecessary. Many people think this
> is good. I personally like the traditional
> scheme, and would be happier with SELinux if
> it held to it.

If the argument is that we should favor the traditional over the good,
then I think you've lost your case.  Besides, Type Enforcement has quite
a bit of history behind it, coming from at least the LOCK work in the
early 80s, with the underlying origins traceable to the Lampson ('71)
and Linden ('76) papers, so let's compare traditions, shall we?

> Restictive LSM modules ought to be completely
> stackable if they are in fact strictly
> restrictive.

Strictly restrictive relative to base Linux DAC, but not necessarily to
one another.  See the issues noted in the next-to-last para of:
http://www.nsa.gov/selinux/papers/module/x341.html

Also, getting the stacker module correct even for the "simple"
combination of capabilities and SELinux was surprisingly difficult - see
the lsm list archives for the history of that.  Serge made a valiant
effort of fixing each issue as I discovered them, but the history shows
that it isn't as trivial as one might think.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
