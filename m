Date: Wed, 20 Feb 2002 02:15:51 +0000
From: Dale Amon <amon@vnl.com>
To: SELinux@tycho.nsa.gov
Subject: Re: 2.2 kernel series
Message-ID: <20020220021551.GB29004@vnl.com>
References: <20020220005027.31760.qmail@web20602.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020220005027.31760.qmail@web20602.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Feb 19, 2002 at 04:50:27PM -0800, Metrix wrote:
> why develop 2.4, 2.5 even? 2.4 has had quite a lot of
> problems, most people are sticking with 2.2 in a
> production enviroment,

Hardly, or at least no more than the delay for really
mission critical applications that occurred between
2.0.36 and 2.2.17 jump. 

2.4.x has been more than stable enough for reasonably
critical applications for many months now, and I and
many, many others are so using it.

Changing from 2.2.17 to 2.2.17-se in a mission critical
system is exactly as risky (fixing what ain't broken) 
as going to 2.4.x. I can't see any admin going to that
much trouble to recertify a 2.2.x. Same amount of work
to make the transition to 2.4.x-selinux.

> it would seem that the 2.2
> selinux patches are not being updated, which is a
> shame. 

I don't think there are very many new systems going
up with 2.2.x. Selinux is still experimental anyway,
and by the time it's "done" we'll probably be using
2.6.x kernels with the conservative applications
hanging back on 2.4.x

> also, does selinux audit there code ala openbsd?

All of the kernel is pretty well audited if you
ask me; and I think Russ Coker has gone through 
the security critical apps as well as Dr. Smalley.

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
