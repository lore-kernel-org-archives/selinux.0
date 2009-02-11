Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1BAoxaf014858
	for <selinux@tycho.nsa.gov>; Wed, 11 Feb 2009 05:50:59 -0500
Received: from mail-fx0-f16.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1BAlhW6001182
	for <selinux@tycho.nsa.gov>; Wed, 11 Feb 2009 10:47:44 GMT
Received: by fxm9 with SMTP id 9so346520fxm.18
        for <selinux@tycho.nsa.gov>; Wed, 11 Feb 2009 02:50:57 -0800 (PST)
Subject: Re: Question about su
From: Dominick Grift <domg472@gmail.com>
To: Dennis Wronka <linuxweb@gmx.net>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200902111650.39754.linuxweb@gmx.net>
References: <200902111650.39754.linuxweb@gmx.net>
Content-Type: text/plain
Date: Wed, 11 Feb 2009 11:46:36 +0100
Message-Id: <1234349196.13112.16.camel@notebook1.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-02-11 at 16:50 +0800, Dennis Wronka wrote:
> What use is su if a normal user after running su is still user_u:user_r:user_t 
> and thus has no permissions to do stuff?

user_t is an unprivileged user domain.

> Sure, he's root, but as because of SELinux that alone isn't worth much, as 
> being user_u still limits the user's options pretty much.

user_t should not use root. user_t is confined to this domain. It is not
designed to "user" domain transition.

> Is there anything I misunderstand here? I don't think there should be an 
> automtic transition from user_r to sysadm_r, and newrole-ing this doesn't work 
> as user_u doesn't have the sysadmin-role.

staff_t is the domain that can use root by first running newrole -r
sysadm_r and then su.

> So, what the heck is the use of su on a SELinux-system?

It works but just not for user_t. Map users that should be able to
"user" domain transition to privileged roles to the staff_u SELinux user
group.

hth ,Dominick

> Thanks and best regards,
> Dennis


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
