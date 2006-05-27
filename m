From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Petre Rodan <kaiowas@gentoo.org>
Subject: Re: nepenthes policy
Date: Sun, 28 May 2006 09:07:36 +1000
Cc: SELinux@tycho.nsa.gov, Chris PeBenito <cpebenito@tresys.com>
References: <20060526170318.GA10733@peter.sunspire.org> <200605272136.43846.russell@coker.com.au> <20060527165749.GE6721@peter.sunspire.org>
In-Reply-To: <20060527165749.GE6721@peter.sunspire.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605280907.40813.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 28 May 2006 02:57, Petre Rodan <kaiowas@gentoo.org> wrote:
> > Why not use honeypot_t?
> >
> > Having one set of policy for all honeypot programs should work reasonably
> > well.
> >  When we get the MCS changes as recently discussed merged it will be
> > possible to isolate multiple instances of a single honeypot program (or
> > multiple programs that perform the honeypot function) by categories.
>
> I almost agree with your idea, but I think it be wiser to wait for another
> honeypot policy and decide at that point if it makes sense merging them

Of course changing the names of domains is a minor pain and rarely gets done.  
More generally anything that involves removing lines from a .te file will 
take a lot of work to get accepted.  It's best to do it right the first time.

> into honeypot_t. for the time being I do not see another honeypot-related
> policy in cvs. specialized honeypots (ie spam traps) would need far less
> privileges then what we have now for nepenthes.

Spam traps generally are not referred to as honeypots.  When talking about a 
honeypot you are generally talking about a program to simulate a vulnerable 
system.  Honeyd is almost synonymous with the term honeypot, it would be best 
to have a policy that supports nepenthes and honeyd and then for every new 
honeypot a decision would be made as to whether it should run in the same 
domain or a different one.

Why do you think that another honeypot policy won't be written?  Surely it's 
inevitable that the most popular program which provides this service (honeyd) 
will get policy support.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
