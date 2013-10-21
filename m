Message-ID: <52657D00.5070903@tycho.nsa.gov>
Date: Mon, 21 Oct 2013 15:14:08 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>
CC: Steve Lawrence <slawrence@tresys.com>,
        Dominick Grift <dominick.grift@gmail.com>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Update to CIL
References: <52617C02.4060500@tycho.nsa.gov> <1382199839.82880.YahooMailNeo@web87903.mail.ir2.yahoo.com>
In-Reply-To: <1382199839.82880.YahooMailNeo@web87903.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/19/2013 12:23 PM, Richard Haines wrote:
> Thanks for the update. I added the fix used by Dominick and tested the various
> fixes that are now okay. However (sorry) but one new bug has been introduced
> and some others are still present:
>
> 1) New bug - I've been using tunables to select the different levels of
>     support between Tresys and NSA compilers. Since this update, mapping
>     inside tunables does not work (but only when using classpermissionset).
>     The "tunable-mapping-error.cil" module demos this error.
>

I have noticed a problem with constraints in tunables not showing up as well.

> 2) classmapping only takes the first entry whether in a boolean or not. The
>     "map-perm-error.cil" module demos this error. The Tresys compiler has
>     a different problem - see text in "map-perm-error.cil".
>

I did know about this. We are going to be making some changes to classmappings 
and classpermissionsets, so this will be taken care of soon.

> 3) Fails to resolve neverallow "*". The "neverallow-STAR.cil" module demos
>     this error.
>

The "*" is currently seen to be an expression in CIL rather than as the name of 
a set that includes all types. We are making some changes to expression and list 
handling, so this could change. We have also been taking a look at using "all" 
instead of "*" (since we use names instead of symbols elsewhere in CIL).

At any rate, currently you would have to define a typeattributeset and use that 
in the neverallow.


Thanks for your help.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
