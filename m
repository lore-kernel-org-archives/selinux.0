MIME-Version: 1.0
In-Reply-To: <1274287613.1143.212.camel@moss-pluto.epoch.ncsc.mil>
References: <BAY111-W21E4613ED1D1458B53C3A6ABE10@phx.gbl>
	 <1274190359.8879.28.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTilIi9IGW2LehHbc1FMw-T7NCjeyF9LSoHRbHtvm@mail.gmail.com>
	 <1274210546.8879.139.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTikDEXmWbKQMp_clbGxCVoqpxwp21sUPmF0oaC_d@mail.gmail.com>
	 <1274276003.1143.74.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTim9goaYNqDSrQZtfOWJWMywBFV-fPieBJEXYfir@mail.gmail.com>
	 <1274281931.1143.148.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTim39ccwJAroJoAmKc2NsbUl3V1ISlx2Rnfm9PMX@mail.gmail.com>
	 <1274287613.1143.212.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 19 May 2010 21:49:54 +0500
Message-ID: <AANLkTilkA3DuRmoAawZr7AlxBZioAtzzguSf-sz0lNfx@mail.gmail.com>
Subject: Re: How to cross install policy store?
From: Shaz <shazalive@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        TaurusHarry <harrytaurus2002@hotmail.com>,
        selinux-mailing-list <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> How can we deny the usefulness of building the module on the target at
>> this point? This is where my mind is stuck. I query the available
>> interfaces on target and send a policy that will build with those
>> interfaces using package manager and it's post and pre scripts for the
>> package in context. Are there any weaknesses here that I am
>> overlooking.
>
> I simply answered your question about compatibility if you were to build
> the modules on a build host and then ship them to the target system.
> Remember that my proposal was to instead build the complete policy on
> the build host and only ship the final generated policy to the target
> system, thereby avoiding the need for libsemanage, semodule/semanage,
> and the module store on the target system at all.  Then we don't care
> about module version compatibility (no modules on the target), only
> kernel policy version compatibility.
>
> If you are going to require the target system to support modules, then
> yes, you could just ship it the source text of the module and compile it
> there as long as you are willing to require the target system to have
> checkmodule and the policy interface headers installed.  In fact, that
> is the current trend in selinux userspace development (look for Source
> Policy Support and src-policy in the list archives), although I think
> we're still a ways from making that transition.
>
>> Before I can learn m4 or something similar and get command over policy
>> writing I think experimenting with reference policy is suitable.
>
> That's fine - I'm not trying to convince you to not use refpolicy, just
> making sure you understand that you have other options if it doesn't fit
> your goals.

Thank you Stephen. Reasoning with you makes me sure that I am on the
right track.


-- 
Shaz


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
