Date: Thu, 13 Dec 2001 08:35:16 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Shaun Savage <savages@pcez.com>
cc: Secure Linux Mailing List <SELinux@tycho.nsa.gov>
Subject: Re: Admin help, Please
In-Reply-To: <3C17DC1D.6090507@pcez.com>
Message-ID: <Pine.GSO.4.33.0112130827340.28057-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 12 Dec 2001, Shaun Savage wrote:

> I can't get musterman to enter sysadm_r role.
> I try "newrole" but I get error musterman,sysadm_r,sysadm_t  not valid
>
> Where/ how do I check what user has what roles and how do I change the
> user roles?
> Is there a user role managment system?

The authorized roles for each user are specified in the policy/users file.
So if musterman has sysadm_r listed in his authorized roles in the
policy/users file (and if you installed and booted with that policy, or
reloaded it dynamically via 'make load'), he should be able to enter that
role using newrole.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
