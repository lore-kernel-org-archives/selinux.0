Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2VDB0GL001651
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2008 09:11:00 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m2VDAmIb025544
	for <selinux@tycho.nsa.gov>; Mon, 31 Mar 2008 13:10:57 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: RBAC in RHEL5
Date: Mon, 31 Mar 2008 08:56:17 -0400
Message-ID: <1206968178.16113.328.camel@gorn>
In-Reply-To: <0bec01c89287$3b352cc0$016a010a@mail2world.com>
References: <0bec01c89287$3b352cc0$016a010a@mail2world.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Takesi satoh" <t_mail@mail2Airport.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2008-03-30 at 09:58 -0700, Takesi satoh wrote:
> I wonder that I can use RBAC in RHEL5 or not.
> Here is my problem.
>  
> I created new user, and new roles. Let me say john_u: john_r:john_t.
> After I made loadable module, loaded it, and I added some entry to
> default_context and default_type,
> john_u:john_r:john_t was assigned to linux user "john" when john
> logined from GNOME.
>  
> Next, since I wanted to try the case of "john logins from console", 
> I added new entry "system_r:local_login_t  john_r:john_t
> system_r:unconfined_t" to default_context
> and jonh logins from console(tty), then system_r:unconfined_t was
> assigned to john.
>  
> I thought the reason why it happened was the below policy
> "type_transition local_login_t shell_exec_t:process transition",
> so I downloaded RHEL's selinux-policy-targeted.src.rpm, replaced from
> above type_transition sentence to  "allow local_login_t
> userdomain:process transition;" in local_login.te, and rebuilded rpm.
>  
> Then, john logined from console again, and john was assigned to
> "local_login_t"
> Any domain transition did not happen here.
> I wondered " What if I use strict policy? ", so I tried strict policy.
> But the result is same, john was assined to local_login_t.

How did you create your user role?  Did you just declare the types and
roles, or did you use the policy templates?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
