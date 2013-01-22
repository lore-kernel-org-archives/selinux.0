Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MIKuru008415
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 13:20:56 -0500
Message-ID: <50FED87F.4050202@tresys.com>
Date: Tue, 22 Jan 2013 13:20:47 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Hung Truong <hung.truong@tridsys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Turn off "dontaudit" rules in monolithic policy
References: <3086262d0228a121663cb87f5d77a07a@mail.gmail.com> <50FED43F.9030909@tresys.com> <8f15e085e4c5384591bf85e5d1ee68fa@mail.gmail.com>
In-Reply-To: <8f15e085e4c5384591bf85e5d1ee68fa@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

No, a monolithic policy can't be managed like that at run time.  The policy is supposed to be static.  You'd have to use make enableaudit when you build it, as Dan previously mentioned, and redeploy the policy.

On 01/22/13 13:12, Hung Truong wrote:
> Thanks for the clarification.  I thought the "semodule -DB" could be used
> for monolithic policy as well.
> 
> Daniel Walsh gave a solution by compiling a policy without dontaudit rules
> and that worked perfectly fine for me.  But, just curious if there is an
> equivalent command to turn off dontaudit for monolithic policy at runtime?
> 
> 
> --Hung Truong
> 
> 
> -----Original Message-----
> From: Christopher J. PeBenito [mailto:cpebenito@tresys.com]
> Sent: Tuesday, January 22, 2013 1:03 PM
> To: Hung Truong
> Cc: SELinux
> Subject: Re: Turn off "dontaudit" rules in monolithic policy
> 
> To clarify terminology, if you're using semodule, you're using a modular
> policy, not a monolithic policy.  A monolithic policy would be fully
> compiled on the development machine, and the policy.27 would be deployed
> to the running machine.  A modular policy deploys the *.pp files to the
> running machine and links them together to make a policy.27.
> 
> On 01/21/13 12:25, Hung Truong wrote:
>> I have a custom monolithic build based on RHEL6 policy.
>> I get this error when try to turn off dontaudit rules:
>>
>> $ semodule -DB
>>
>>
>> libsemanage.semanage_link_sandbox: Could not access sandbox base file
> /etc/selinux/targeted/modules/bmp/base.pp. (No such file or directory)
>>
>> Is there other way to turn off dontaudit rules in a monilithic policy?
>>
>>
>>
>> Many thanks,
>>
>> --Hung Truong
>>
> 
> 


-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
