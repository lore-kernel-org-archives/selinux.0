Message-ID: <52651FA2.4010502@tresys.com>
Date: Mon, 21 Oct 2013 08:35:46 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
CC: James Carter <jwcart2@tycho.nsa.gov>,
        SELinux List
	<selinux@tycho.nsa.gov>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Update to CIL
References: <52617C02.4060500@tycho.nsa.gov> <1382126564.3041.13.camel@d30>
In-Reply-To: <1382126564.3041.13.camel@d30>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/18/2013 04:02 PM, Dominick Grift wrote:
> On Fri, 2013-10-18 at 14:20 -0400, James Carter wrote:
>> I pushed an update of CIL to bitbucket.
>
> I had to do this, to make it compile ( not sure what i might have broken
> by doing this ):
>
> --- a/src/cil.c
> +++ b/src/cil.c
> @@ -1493,7 +1493,6 @@ void cil_userbounds_init(struct cil_userbounds
> **userbounds)
>          *userbounds = cil_malloc(sizeof(**userbounds));
>
>          (*userbounds)->user_str = NULL;
> -       (*userbounds)->user = NULL;
>          (*userbounds)->bounds_str = NULL;
>   }
>
> Also a thing i noticed, which is unrelated to secilc, but related to
> cilpolicy is that object_r role is associated to identities.
>
> The object_r string is not really a role, although it looks like it.
>

It is a role, it's just one that has been created and associated with 
all types by default, so you've never needed to do it before in 
refpolicy. In an attempt to make CIL consistent and to prevent errors in 
policy, you now need to create and associate object_r just like you 
would any other role.

> Its just a string that is used as a place holder for the role security
> attribute of objects.
>
> Anyhow, i am going to write a minimum policy with secilc tomorrow i
> think, so maybe then i will find new bugs, insights.
>
> Thanks for your work
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
