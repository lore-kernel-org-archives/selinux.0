From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: =?iso-8859-2?q?Magos=E1nyi=20=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Subject: Re: general security lib (was: 2.6.0-test3)
Date: Sat, 23 Aug 2003 00:09:19 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <1061468940.1665.16.camel@kusturica> <1061487623.22355.27.camel@columbia> <1061555921.1648.142.camel@kusturica>
In-Reply-To: <1061555921.1648.142.camel@kusturica>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200308230009.19552.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 22 Aug 2003 22:38, Magosányi Árpád wrote:
> 2003-08-21, cs keltezéssel Colin Walters ezt írta:
> > at all.  Russell, what do you think about starting to send these patches
> > to the Debian package maintainers and get them integrated?  At least the
>
> It might be the least unconvenient solution for the short run.
>
> But for the long run it would be better if the upstream maintainers
> would integrate support for the userspace security API. And they

A modification to PAM could allow the sshd, login, and cron patches to go 
away.

Theodore Ts'o suggested to me that a new PAM call be added to run the shell 
which takes appropriate parameters about user-name etc.  Then a SE Linux 
version of this module could change the security context appropriately, thus 
requiring only one copy of the code to determine the context to use, and not 
requiring any on-going modification to applications.

This design concept sounds really good, and as it's Ted's suggestion I don't 
expect any great resistance to accepting the patch upstream once it's been 
tested and proven to work.

I've been meaning to work on this for almost a year, I might start work next 
week.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
