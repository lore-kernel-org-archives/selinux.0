Message-ID: <457EC2CE.5040503@mentalrootkit.com>
Date: Tue, 12 Dec 2006 09:55:10 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?=B2=CC=BC=CE=D3=C2?= <millerfor@gmail.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: help: 2 conditional expressions in refpolicy must match?
References: <d032e8510612120128u7a1aa53ege2d5cdc849b3dad1@mail.gmail.com>
In-Reply-To: <d032e8510612120128u7a1aa53ege2d5cdc849b3dad1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

²Ì¼ÎÓÂ wrote:
> while i am testing refpolicy conditional expression by switching
> monolic and module compile mode, i found a strange thing. following is
> the steps i took:
> 
> step 1: add a new boolean to policy
>   in policy/global_tunables:
>     gen_tunable(user_ping,false)
>     gen_tunable(test_ping,false)
> 
> step 2: modify conditional expression
>    in policy/modules/admin/netutils.if:
> 
> interface(`netutils_run_ping_cond',`
>        gen_require(`
>                type ping_t;
>                bool user_ping;
>                bool test_ping;
>        ')
> 
>        role $2 types ping_t;
> 
>        if ( test_ping && user_ping ) {
>                netutils_domtrans_ping($1)
>                allow ping_t $3:chr_file rw_term_perms;
>        }
> ')
> 
> then i try to build policy in monolic and module mode, i use apol to
> check binary policy. monolinc is ok, it shows the conditional rules
> exactly, while modules building boolean test_ping  is in the policy,
> but the rules are lost!!!!
> 

How are you checking that the rules are lost? Linking and expanding the 
module and then loading in Apol? Could you use the dismod and dispol 
programs in the checkpolicy/test directory of the source distribution to 
verify this? Also, what versions of the checkpolicy/checkmodule, 
libsepol, are you using? Some very old versions exhibited this sort of 
behavior, but it is not likely you are using those.

Thanks - Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
