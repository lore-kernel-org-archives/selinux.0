Message-ID: <3B7E54C4.E19EA07E@telocity.com>
Date: Sat, 18 Aug 2001 07:43:00 -0400
From: LeRoy Cressy <lcressy@telocity.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Re: [Fwd: Partial TOC for Comment]
References: <3B7C7C69.E7B84C68@earthlink.net> <20010817001226.J18183@vnl.com> <3B7D591A.EA28B00C@earthlink.net> <20010817122305.P18183@vnl.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dale Amon wrote:
> 
> On Fri, Aug 17, 2001 at 10:49:14AM -0700, John Scroggins wrote:
> > > I find the idea of real time revokation interesting, because if
> > > you see signs of an attack in progress, you can pull the rug
> > > right out from under it... but again, only if you *realize* it
> > > is an attack.
> > >
> > After reading constantly for the last few days, help me out, please
> > point me to the portion of text that speaks about R/T revocation, so I
> > can build some info on that subject.
> 
> I'm certainly not the best person here to discuss this: it is simply
> something that I found of interest when I read the papers on the
> technology. If you revoke a capability, the change will percoloate
> through to even those who have already passed the gate and it will
> stop them cold. (However I'm not sure now that I think of it whether
> this feature was specific to FLASK or is part of SELinux).
There are some on this list using various forms of RPM or Debian package
management systems.  There is a package in the admin section of the
debian system called `slay' which will slay all the process of the user
mentioned.  If you see an unauthorized attack in progress happening you
can slay the user who is initiating the attack.  Slay will stop that
yser dead in their tracks.  As a system administrator you can then go
back and edit edit the /etc/passwd file and set the user's login shell
as false and place an * in the password field.  This will keep the
user's password in the shadow password file, but the user who's password
has been ``hacked'' can be reviewed to find the flaws in the user's
password.  


One way to tighten up security is to assign passwords and turn off the
SUID bit on /bin/passwd.  

> 
> I remember years back madly trying to finish up a project on
> a computer account that was due to expire. I pulled an all-nighter
> and the "revocation" of my account on that machine did not take
> affect until *after* I logged out. While this was a nice feature
> for a someone trying to finish a late project at a university,
> it is not the best way to run a high security system ;-)
> 
> I think the designers like Dr. Smalley are much better sources
> of information on this than I.
> 
> --
> ------------------------------------------------------
> Use Linux: A computer        Dale Amon, CEO/MD
> is a terrible thing          Village Networking Ltd
> to waste.                    Belfast, Northern Ireland
> ------------------------------------------------------
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
Rev. LeRoy D. Cressy   mailto:lcressy@telocity.com   /\_/\
                       http://www.netaxs.com/~ldc   ( o.o )
                       Phone:  215-535-4037          > ^ <

Jesus saith unto him, I am the way, the truth, and the life: 
no man cometh unto the Father, but by me. (John 14:6)

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
