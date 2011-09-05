Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p85EWkhj010746
	for <selinux@tycho.nsa.gov>; Mon, 5 Sep 2011 10:32:46 -0400
Received: from nm3-vm0.bt.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p85EWicV013660
	for <selinux@tycho.nsa.gov>; Mon, 5 Sep 2011 14:32:45 GMT
Message-ID: <1315233158.40398.YahooMailClassic@web87010.mail.ird.yahoo.com>
Date: Mon, 5 Sep 2011 15:32:38 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: SELinux Common Intermediate Language Update
To: Steve Lawrence <slawrence@tresys.com>
Cc: jwcart2@tycho.nsa.gov, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4E5D2EA1.2070607@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for this useful information. I've now managed to modify mdp to generate the CIL code for a simple policy and tested an MLS and non-MLS version of the binary policies.

To achieve this I also had to patch the CIL compiler to output initial SIDs correctly.

What I will do now is send out emails with:

1) Patches for mdp to output CIL format policy (I also added a flag to output an MLS policy suitable for checkpolicy).

2) The patch for the CIL compiler to output SIDs correctly. This patch is very simple but it's probably not the right way to fix the problem - but it does work.

Richard

--- On Tue, 30/8/11, Steve Lawrence <slawrence@tresys.com> wrote:

> From: Steve Lawrence <slawrence@tresys.com>
> Subject: Re: SELinux Common Intermediate Language Update
> To: "Richard Haines" <richard_c_haines@btinternet.com>
> Cc: jwcart2@tycho.nsa.gov, "SELinux" <selinux@tycho.nsa.gov>
> Date: Tuesday, 30 August, 2011, 19:40
> It actually means you need a valid
> range component. If you build a
> binary policy without the --mls flag, it just doesn't write
> any of the
> mls information to the binary. As Jim said, this is just
> required so as
> to minimize special cases.
> 
> If you don't want to have to specify the range every time
> you create a
> context, you can create a named levelrange with only one
> category and
> sensitivity and use that in contexts, for example:
> 
> (category c0)
> (categoryorder (c0))
> (sensitivity s0)
> (dominance (s0))
> (sensitivitycategory s0 (c0))
> (levelrange default ((s0 (c0)) (s0 (c0))))
> 
> (context context1 (unconfined_u unconfined_r unconfined_t
> default))
> 
> This is similar to the way the gen_context statement in
> refpolicy works,
> which just discards the range when not building an mls
> policy.
> 
> Also, if you get the simple CIL policy working, we'd love
> to see it.
> 
> - Steve
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
