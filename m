Message-ID: <5267DD43.7070306@tycho.nsa.gov>
Date: Wed, 23 Oct 2013 10:29:23 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
CC: SELinux List <selinux@tycho.nsa.gov>,
        Steve Lawrence <slawrence@tresys.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Update to CIL
References: <52617C02.4060500@tycho.nsa.gov> <1382536756.3041.81.camel@d30>
In-Reply-To: <1382536756.3041.81.camel@d30>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/23/2013 09:59 AM, Dominick Grift wrote:
> On Fri, 2013-10-18 at 14:20 -0400, James Carter wrote:
>> I pushed an update of CIL to bitbucket.
>
> Not sure if this is useful but today i got secilc to segfault (due to my
> incompetence needless to say)
>

It is useful, because bad syntax shouldn't cause a segfault. Thanks for the report.

> This seems to have been faulty policy that cecilc could not handle
> gracefully (i fixed the policy syntax error later):
>
>> (classpermissionset nottransitionordyntransitionprocess (process (not
>>              transition dyntransition)))
>
> This was what happened:
>
>> # ./examplepolicy.sh
>> Invalid syntax
>> Invalid expression syntax
>> Bad expression tree
>> Bad permission list or expression
>> Bad class-permissions
>> Problem filling class-permissions list
>> Bad classpermissionset declaration at line 243 of /root/examplepolicy/policy/modules/kernel/kernel
>> Failed to build AST
>> Failed to build ast
>> Failed to compile cildb: -1
>> ./examplepolicy.sh: line 33:  2147 Segmentation fault      "$SECILC_PATH"/secilc -U allow -c "$POLICY_VERSION" -v --output="$POLICY_PATH"/policy."$POLICY_VERSION" --filecontext="$POLICY_PATH"/file_contexts `cat "$POLICY_PATH"/LISTING`
>
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
