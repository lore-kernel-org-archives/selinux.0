Message-ID: <1382541329.3041.88.camel@d30>
Subject: Re: Update to CIL
From: Dominick Grift <dominick.grift@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        Steve Lawrence
 <slawrence@tresys.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Date: Wed, 23 Oct 2013 17:15:29 +0200
In-Reply-To: <52617C02.4060500@tycho.nsa.gov>
References: <52617C02.4060500@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2013-10-18 at 14:20 -0400, James Carter wrote:
> I pushed an update of CIL to bitbucket.

I noticed that cilpolicy does not have refpolicies
"selinux_labeled_boolean" interface

I tried to implement it myself but i cannot get it to parse ARG2 no
matter what i try

This is what i currently have:

macro:

> ; Associate the specified type and name with booleans
> 
> (macro selinux_labeled_boolean ((type ARG1) (name ARG2))
>   (call selinux_boolean_type (ARG1))
>   (genfscon "selinuxfs" ARG2 (system_u object_r ARG1 ((s0)
>             (s0)))))

call:

> (type secure_mode_insmod_t)
> (call selinux_labeled_boolean (secure_mode_insmod_t
>              "/booleans/secure_mode_insmod"))

result:

> # seinfo --genfscon | grep secure_mode_insmod
>    genfscon selinuxfs ARG2      system_u:object_r:secure_mode_insmod_t

Is there a work around for this?

I realize that the nature of cil make these kind of things less useful
but it would have been nice if it worked




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
