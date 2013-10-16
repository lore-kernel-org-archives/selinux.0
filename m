Message-ID: <1381952836.5556.7.camel@d30>
Subject: Re: Common Intermediate Language (CIL) Update
From: Dominick Grift <dominick.grift@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        Steve Lawrence
 <slawrence@tresys.com>
Date: Wed, 16 Oct 2013 21:47:16 +0200
In-Reply-To: <51F6A808.5080204@tycho.nsa.gov>
References: <51F6A808.5080204@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2013-07-29 at 13:36 -0400, James Carter wrote:
> The CIL compiler, secilc, is now able to create MLS, MCS, and non-MLS binary 
> policies from a slightly modified version of Refpolicy that has been converted 
> to CIL.
> 
> Anyone interested in trying CIL out can do the following:

I cloned both the repositories in this mail as well as the one hosted by
tresys but no new commits in either

A couple of things stand out when i try this

both non-mls and mls policy have no constraints according to seinfo
both non-mls and mls policy have no neverallow rules according to seinfo
the non-mls policy has a category "c0"

I like what i am seeing a lot, unfortunately it is not really usable yet
because user land can't work with it yet, and i need it to create home
directory contexts

looking forward to and update to this


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
