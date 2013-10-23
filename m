Message-ID: <1382536756.3041.81.camel@d30>
Subject: Re: Update to CIL
From: Dominick Grift <dominick.grift@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        Steve Lawrence
 <slawrence@tresys.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Date: Wed, 23 Oct 2013 15:59:16 +0200
In-Reply-To: <52617C02.4060500@tycho.nsa.gov>
References: <52617C02.4060500@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2013-10-18 at 14:20 -0400, James Carter wrote:
> I pushed an update of CIL to bitbucket.

Not sure if this is useful but today i got secilc to segfault (due to my
incompetence needless to say)

This seems to have been faulty policy that cecilc could not handle
gracefully (i fixed the policy syntax error later):

> (classpermissionset nottransitionordyntransitionprocess (process (not
>             transition dyntransition)))

This was what happened:

> # ./examplepolicy.sh
> Invalid syntax
> Invalid expression syntax
> Bad expression tree
> Bad permission list or expression
> Bad class-permissions
> Problem filling class-permissions list
> Bad classpermissionset declaration at line 243 of /root/examplepolicy/policy/modules/kernel/kernel
> Failed to build AST
> Failed to build ast
> Failed to compile cildb: -1
> ./examplepolicy.sh: line 33:  2147 Segmentation fault      "$SECILC_PATH"/secilc -U allow -c "$POLICY_VERSION" -v --output="$POLICY_PATH"/policy."$POLICY_VERSION" --filecontext="$POLICY_PATH"/file_contexts `cat "$POLICY_PATH"/LISTING`




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
