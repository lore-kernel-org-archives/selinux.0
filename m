From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: general security lib (was: 2.6.0-test3)
Date: Sun, 24 Aug 2003 00:09:57 +1000
Cc: Magos?nyi ?rp?d <mag@bunuel.tii.matav.hu>, SELinux <SELinux@tycho.nsa.gov>
References: <1061555921.1648.142.camel@kusturica> <200308230009.19552.russell@coker.com.au> <20030823092141.GB18656@snoopy.apana.org.au>
In-Reply-To: <20030823092141.GB18656@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308240009.57083.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 23 Aug 2003 19:21, Brian May wrote:
> On Sat, Aug 23, 2003 at 12:09:19AM +1000, Russell Coker wrote:
> > Theodore Ts'o suggested to me that a new PAM call be added to run the
> > shell which takes appropriate parameters about user-name etc.  Then a SE
> > Linux version of this module could change the security context
> > appropriately, thus requiring only one copy of the code to determine the
> > context to use, and not requiring any on-going modification to
> > applications.
>
> Would this work properly with the chroot authentication stuff in sshd?

As the shared object itself is not in the chroot environment it must be loaded 
before the chroot(), therefore at that time it should be able to load and 
cache any files it needs.

This may need some modifications to the SE Linux library code, but it 
shouldn't be too difficult.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
