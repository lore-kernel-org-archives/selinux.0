Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MICKwX007284
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 13:12:20 -0500
Received: by mail-wi0-f197.google.com with SMTP id hm6so9077915wib.8
        for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 10:12:16 -0800 (PST)
From: Hung Truong <hung.truong@tridsys.com>
References: <3086262d0228a121663cb87f5d77a07a@mail.gmail.com> <50FED43F.9030909@tresys.com>
In-Reply-To: <50FED43F.9030909@tresys.com>
MIME-Version: 1.0
Date: Tue, 22 Jan 2013 13:12:15 -0500
Message-ID: <8f15e085e4c5384591bf85e5d1ee68fa@mail.gmail.com>
Subject: RE: Turn off "dontaudit" rules in monolithic policy
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for the clarification.  I thought the "semodule -DB" could be used
for monolithic policy as well.

Daniel Walsh gave a solution by compiling a policy without dontaudit rules
and that worked perfectly fine for me.  But, just curious if there is an
equivalent command to turn off dontaudit for monolithic policy at runtime?


--Hung Truong


-----Original Message-----
From: Christopher J. PeBenito [mailto:cpebenito@tresys.com]
Sent: Tuesday, January 22, 2013 1:03 PM
To: Hung Truong
Cc: SELinux
Subject: Re: Turn off "dontaudit" rules in monolithic policy

To clarify terminology, if you're using semodule, you're using a modular
policy, not a monolithic policy.  A monolithic policy would be fully
compiled on the development machine, and the policy.27 would be deployed
to the running machine.  A modular policy deploys the *.pp files to the
running machine and links them together to make a policy.27.

On 01/21/13 12:25, Hung Truong wrote:
> I have a custom monolithic build based on RHEL6 policy.
> I get this error when try to turn off dontaudit rules:
>
> $ semodule -DB
>
>
> libsemanage.semanage_link_sandbox: Could not access sandbox base file
/etc/selinux/targeted/modules/bmp/base.pp. (No such file or directory)
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
