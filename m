From: Paul Moore <paul.moore@hp.com>
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Wed, 29 Aug 2007 08:21:45 -0400
Cc: Joe Nall <joe@nall.com>, Darrel Goeddel <sedgoeddel@gmail.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        Eric Paris <eparis@parisplace.org>
References: <D709A20F2164C84E8B7014B0301F5EF8521359@HAVOC.tcs-sec.com> <46D4EBEA.509@manicmethod.com> <46D4F1E2.4050503@manicmethod.com>
In-Reply-To: <46D4F1E2.4050503@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708290821.46404.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, August 29 2007 12:11:14 am Joshua Brindle wrote:
> Ok, I think my brain is still catching up on this thread.

My brain gave up quite a while ago ... it's just nerves banging away at the 
keyboard now :)

> Because of 
> what I said above I think we should 1) not do node based fallbacks and
> 2) not do nic alias-level fallbacks. This is the safe option (as already
> pointed out) and minimizes trust in untrustworthy things (eg., addresses
> coming from the network).
>
> OTOH it may make some peoples lives easier to allow this. It is a false
> sense of security though so I vote for doing nic level fallbacks only
> and if someone *really* wants to do this they can just plug several nics
> into the same network (hopefully they'd recognize the horrible things
> they are doing if it is explicit like that).
>
> It sounds like the decision is still up in the air though, does anyone
> inherently disagree with me here?

I guess every decision is technically up in the air until the changes/patches 
are included in a released kernel, however, I'm pretty confident that host 
level granularity of both fallback labels and flow control peer label 
filtering is "the right thing".

I understand your point about not extending trust beyond the level of the 
physical wire, that is very easy to rationalize/understand.  However, from a 
practical real-world scenario (see my home network behind a NAT box example, 
as well as others) I think there is real value in extending the labeling 
beyond the wire to the host/network level.  SELinux has always made some 
allowances to facilitate adoption and ease of use, i.e. unconfined_t, but has 
been careful to make sure that these concessions were always at the 
discretion of the system administrator.  Fallback labeling and peer flow 
controls are configuration options which are only available to the system 
administrator and providing host level granularity can be a significant 
benefit to a lot of people.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
