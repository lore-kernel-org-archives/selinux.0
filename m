From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Jim Meyering <jim@meyering.net>
Subject: Re: infelicity in context_user_set; new syscalls: setfileconat, etc.?
Date: Mon, 31 Jul 2006 22:35:20 +1000
Cc: Valdis.Kletnieks@vt.edu, SELinux@tycho.nsa.gov
References: <87zmeslb2v.fsf@rho.meyering.net> <200607310458.k6V4wScX009997@turing-police.cc.vt.edu> <87odv6kw1v.fsf@rho.meyering.net>
In-Reply-To: <87odv6kw1v.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607312235.24871.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 31 July 2006 18:39, Jim Meyering <jim@meyering.net> wrote:
> > And I suspect that nobody's running an SELinux system with no /proc
> > mounted (except on some *really* Martian-logic design for a Really Secure
> > embedded system or something...)
>
> Let's assume that all properly-configured environments do mount /proc.

Let's not, think of chroot environments.

> Are the required features[*] of /proc usable even in the most restrictive
> environments?

I doubt it at the moment.  But it wouldn't be difficult to enable these things 
for the rare cases where they are needed.

> If so, then the only remaining argument for adding syscalls 
> is one of efficiency -- not very compelling.
>
> [*] The ability to access any FILE via /proc/self/fd/N/FILE,
> where the directory containing FILE is open on file descriptor N.

I believe that the real question is whether processes in restrictive 
environments such as chroot's need to do chcon -R operations anyway, and if 
they do whether they need to go to great depth.

I have set up many chroot environments, many of which were so restrictive that 
they would not permit what you desire.  But I can't think of any of them 
having a need for deep chcon -R operations.

Would it be possible to use the current functionality and only skip to the 
other type when the path depth is exceeded?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
