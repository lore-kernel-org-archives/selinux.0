Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8S1wEVT005441
	for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2006 21:58:15 -0400
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8S1v9hw008953
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 01:57:10 GMT
Date: Wed, 27 Sep 2006 20:58:10 -0500
From: Klaus Weidner <klaus@atsec.com>
To: Russell Coker <russell@coker.com.au>
Cc: Salvo Giuffrida <giuffsalvo@hotmail.it>, selinux@tycho.nsa.gov
Subject: Re: MLS and Biba
Message-ID: <20060928015809.GB10204@w-m-p.com>
References: <BAY114-F93133EE31869D548BEF16AF250@phx.gbl> <200609270924.31088.russell@coker.com.au> <20060927220346.GA10204@w-m-p.com> <200609281105.11769.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200609281105.11769.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 28, 2006 at 11:05:09AM +1000, Russell Coker wrote:
> can_exec(high_t, high_file_t)
> can_exec(medium_t, { medium_file_t, high_file_t })
> can_exec(low_t, file_type)
[...]
> It seems that we can do BIBA stuff with the domain-type model.  The above is a 
> demonstration of how it might start.  Probably the best thing to do would be 
> to have a set of N levels and N-1 attributes for all possible <X and >X 
> values and a set of macros to define the BIBA policy.

But that means that you won't be able to combine the integrity controls
with the existing TE controls, or if you want both you'll have to use
combined types such as high_passwd_exec_t, medium_user_t and so on, and
that way lies madness.

The advantage of the bitmasks would be that you could use TE, MLS, MCS,
and MIC within a single policy, including backwards compatibility to the
current type labels.

> As has been mentioned in the past, the domain-type model is flexible enough to 
> implement MLS etc.  It's just a matter of whether you would want to.

I think the problem is that if you overload the types too much, you get a
combinatorial explosion of types, and the current size of the policy is
already getting unwieldy.

> I might have some spare time in a couple of weeks.  Maybe I'll hack something 
> up for fun.

I'm short on spare time, but I'd also be curious to hack up the bitmask
approach ;-)

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
