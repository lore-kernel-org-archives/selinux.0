Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MI34hM006693
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 13:03:04 -0500
Message-ID: <50FED43F.9030909@tresys.com>
Date: Tue, 22 Jan 2013 13:02:39 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Hung Truong <hung.truong@tridsys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Turn off "dontaudit" rules in monolithic policy
References: <3086262d0228a121663cb87f5d77a07a@mail.gmail.com>
In-Reply-To: <3086262d0228a121663cb87f5d77a07a@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

To clarify terminology, if you're using semodule, you're using a modular policy, not a monolithic policy.  A monolithic policy would be fully compiled on the development machine, and the policy.27 would be deployed to the running machine.  A modular policy deploys the *.pp files to the running machine and links them together to make a policy.27.

On 01/21/13 12:25, Hung Truong wrote:
> I have a custom monolithic build based on RHEL6 policy.
> I get this error when try to turn off dontaudit rules:
> 
> $ semodule -DB
> 
> 
> libsemanage.semanage_link_sandbox: Could not access sandbox base file /etc/selinux/targeted/modules/bmp/base.pp. (No such file or directory)
> 
> Is there other way to turn off dontaudit rules in a monilithic policy?
> 
>  
> 
> Many thanks,
> 
> --Hung Truong
> 


-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
