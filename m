Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1QM8B7N032397
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 17:08:11 -0500
Received: from g5t0006.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1QM899c000426
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 22:08:09 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Eric Paris" <eparis@parisplace.org>
Subject: Re: [PATCH 0/5] New labeled networking permissions for 2.6.25
Date: Tue, 26 Feb 2008 17:08:08 -0500
Cc: selinux <selinux@tycho.nsa.gov>
References: <20080226184032.834798290@hp.com> <7e0fb38c0802261352r52318774v562f8e635a3f44cc@mail.gmail.com>
In-Reply-To: <7e0fb38c0802261352r52318774v562f8e635a3f44cc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802261708.08090.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 26 February 2008 4:52:34 pm Eric Paris wrote:
> On 2/26/08, paul.moore@hp.com <paul.moore@hp.com> wrote:
> >  It is important to note that
> >  while this patchset adds the permissions required it doesn't
> > enable the "network_peer_controls" policy capability.
>
> Darn it, I'm trying to play with a new capability for something I'm
> writing and I just read this whole patch set (before i read 0/5) to
> see where you decided to define it so I could copy that in my policy.
> Thanks for not doing the one thing I was hunting for!

Well, thanks for looking at the code ;)

I currently enable the functionality with a simple module which consists 
solely of the lines below:

 policy_module(peer_test,0.0.2)
 policycap network_peer_controls;
 # dummy type - not used
 type peer_test_t;

However, be warned that the policy toolchain in rawhide won't compile 
this correctly at present (well, as of this morning anyway) so you have 
to get the bits from SVN.  This is one of the reasons why I didn't 
submit a patch enabling the policy capabilities (that and there needs 
to be more testing done first).

> So, does anyone have a good idea suggestions where we should turn
> on/off these new capabilities?  I know it has to be in the base
> module in the end, but I don't know what file to put them in.  I
> might just throw it in kernel.te for now for me to keep testing but I
> assume we are going to want all of these definitions in one place? 
> Are we going to want them all over as long as they end up being built
> into base?

I have no idea but I suspect Chris has given this some thought and 
probably has some ideas.  I tend to think putting them in one place is 
probably a good idea ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
