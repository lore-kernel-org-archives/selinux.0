Message-ID: <52652DE1.4020504@tresys.com>
Date: Mon, 21 Oct 2013 09:36:33 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>
CC: James Carter <jwcart2@tycho.nsa.gov>,
        Dominick Grift
	<dominick.grift@gmail.com>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Update to CIL
References: <52617C02.4060500@tycho.nsa.gov> <1382199839.82880.YahooMailNeo@web87903.mail.ir2.yahoo.com>
In-Reply-To: <1382199839.82880.YahooMailNeo@web87903.mail.ir2.yahoo.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/19/2013 12:23 PM, Richard Haines wrote:
> Thanks for the update. I added the fix used by Dominick and tested the various
> fixes that are now okay. However (sorry) but one new bug has been introduced
> and some others are still present:
>

Thanks for the bug reports and examples. Very helpful.

> 1) New bug - I've been using tunables to select the different levels of
>     support between Tresys and NSA compilers. Since this update, mapping
>     inside tunables does not work (but only when using classpermissionset).
>     The "tunable-mapping-error.cil" module demos this error.
>
> 2) classmapping only takes the first entry whether in a boolean or not. The
>     "map-perm-error.cil" module demos this error. The Tresys compiler has
>     a different problem - see text in "map-perm-error.cil".
>
> 3) Fails to resolve neverallow "*". The "neverallow-STAR.cil" module demos
>     this error.
>
> 4) Not sure if this is a bug or 'as designed', I tried using "in" in a
>     booleanif statement but failed. The "in-boolean.cil" module demos
>     this error.
>

This should not be allowed. The only thing that should be allowed in a 
booleanif statement are typetransitions, typerules, and avrules.


> These only apply to the Tresys compiler (as do 2, 3, & 4):
> 5) Does not expand all entries in a typeattribute for allow rules within
>     a boolean. The "ta-bool-error.cil" module demos this error.
>
> 6) Neverallow fails when rule defined in a dontaudit rule. The NSA compiler
>     and checkpolicy do not generate an error.  The "neverallow-error.cil"
>     module demos this error.
>

I would start only using Jim's repo. The changes to that repo have fixed 
many of the problems. It is what we are working on.

> The attached "cil-base.cil" supplies the user, role etc. requirements
>
> Finally I know the NSA version resolves constraints okay now, but the output
> is reversed in Tresys. The "mlsconstrain-diff.cil" shows the difference but
> in the end they resolve to the same. I have not tried complex constraints.
>
> Hope all this helps

Very helpful. Thanks!

> Richard
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
