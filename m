From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: sds@tycho.nsa.gov
Subject: Re: Changes to policycoreutils.
Date: Tue, 21 Mar 2006 07:27:40 +1100
Cc: Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@namei.org>,
        Valdis.Kletnieks@vt.edu, SE Linux <selinux@tycho.nsa.gov>
References: <441B2C7B.7050307@redhat.com> <441EC183.6000404@redhat.com> <1142869863.16487.57.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1142869863.16487.57.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200603210727.47903.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 21 March 2006 02:51, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> There are
> also recently added new syscalls to help reduce races in walking the
> file tree (i.e. openat and friends) - possibly there should be some for
> lsetxattr as well so that lsetfileconat() could be implemented?

Yes, I think a lsetxattrat() syscall is necessary, and I agree that we need 
better code to deal with race conditions in the library.

Incidentally it's the first time I've heard of coreutils being cited as a good 
example in this regard.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
