Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Dale Amon <amon@vnl.com>, SELinux@tycho.nsa.gov
Subject: Re: 2.2 kernel series
Date: Wed, 20 Feb 2002 23:35:04 +1100
References: <20020220005027.31760.qmail@web20602.mail.yahoo.com> <20020220021551.GB29004@vnl.com>
In-Reply-To: <20020220021551.GB29004@vnl.com>
MIME-Version: 1.0
Message-Id: <20020220123505.6F58B6CD8@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Feb 2002 13:15, Dale Amon wrote:
> On Tue, Feb 19, 2002 at 04:50:27PM -0800, Metrix wrote:
> > why develop 2.4, 2.5 even? 2.4 has had quite a lot of
> > problems, most people are sticking with 2.2 in a
> > production enviroment,
>
> 2.4.x has been more than stable enough for reasonably
> critical applications for many months now, and I and
> many, many others are so using it.

SE Linux is (IMHO) still in a beta stage.  There are many issues that need to 
be improved before large-scale deployment can be performed.  Documentation 
needs improvement, integration into distributions needs to be done, and lots 
more testing!

> Changing from 2.2.17 to 2.2.17-se in a mission critical
> system is exactly as risky (fixing what ain't broken)
> as going to 2.4.x. I can't see any admin going to that

Changing from a non-SE system to a SE system is much more risky than going 
from 2.2.17 to 2.4.17!

> > it would seem that the 2.2
> > selinux patches are not being updated, which is a
> > shame.
>
> I don't think there are very many new systems going
> up with 2.2.x. Selinux is still experimental anyway,
> and by the time it's "done" we'll probably be using
> 2.6.x kernels with the conservative applications
> hanging back on 2.4.x

I hope that there will be some limited deployment in 2.4.x, but I agree that 
it won't become really popular until 2.6.x.

> > also, does selinux audit there code ala openbsd?
>
> All of the kernel is pretty well audited if you

I doubt that.

> ask me; and I think Russ Coker has gone through
> the security critical apps as well as Dr. Smalley.

I have been trying to get them working properly.  I have read quite a bit of 
code to understand what it does (particularly where documentation is lacking) 
and done some work in porting patches to different programs.

But I have not even started any sort of serious audit work!  When I feel that 
I know SE Linux well and have my Debian packages working well then I plan to 
read through some large chunks of code looking for errors or trojans.  I 
don't expect to find trojans and I think it's unlikely that I'll fine any 
serious errors, but to do this properly I have to check it (trust but verify).

-- 
Signatures >4 lines are rude.  If you send email to me or to a mailing list
that I am subscribed to which has >4 lines of legalistic junk at the end
then you are specifically authorizing me to do whatever I wish with the
message (the sig won't be read).

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
