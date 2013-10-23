Message-ID: <1382549242.3041.94.camel@d30>
Subject: Re: Update to CIL
From: Dominick Grift <dominick.grift@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        Steve Lawrence
 <slawrence@tresys.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Date: Wed, 23 Oct 2013 19:27:22 +0200
In-Reply-To: <526800C8.5050306@tycho.nsa.gov>
References: <52617C02.4060500@tycho.nsa.gov> <1382541329.3041.88.camel@d30>
	 <5267F222.5010606@tycho.nsa.gov> <526800C8.5050306@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2013-10-23 at 13:00 -0400, James Carter wrote:

> 
> I am sorry. I got so caught up in the painful memories of having to deal with 
> the selinux_labeled_boolean interface that I missed what you were actually 
> trying to do.
> 
> What you want to do here is quite reasonable and we should make it possible in CIL.
> 
> Thanks again for the feedback.
> 

I am not sure if it makes sense to make this work, as it sets a
precedence. I mean whats next: specify file contexts via macros?

The nature of CIL will make it easy to do this manually instead:

consider module "mybool":

> (type mybool_t)
> (call selinux_boolean_type (mybool_t))

> (genfscon "selinuxfs" "/booleans/mybool" (system_u object_r
>           mybool_t ((s0) (s0))))


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
