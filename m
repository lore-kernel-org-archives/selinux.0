From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: sshd policy
Date: Fri, 24 Jun 2005 01:21:53 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200506231632.32753.russell@coker.com.au> <1119529295.28493.0.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1119529295.28493.0.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200506240121.56790.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 23 June 2005 22:21, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2005-06-23 at 16:32 +1000, Russell Coker wrote:
> > I have attached the source files and the diff for a change to the way
> > sshd works.
> >
> > Recent versions of OpenSSH by default will re-exec the sshd as part of
> > the login process.  This means that there is no need for one process to
> > have all the permissions that sshd is usually granted.  So I have split
> > up the sshd policy into two domains, one of which listens on the port and
> > the other does most of the sshd work.
>
> How does sshd respond to SIGHUP?  Also a re-exec?  If so, then this
> could be problematic, as it would transition domains on the initial
> daemon incorrectly, right?

Correct.  I tested all the functions I use, but I never kill -1 the sshd so it 
didn't occur to me to test it.

It looks like my idea is not usable.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
