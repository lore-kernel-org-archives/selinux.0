Date: Wed, 16 Jan 2002 15:09:31 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Shaun Savage <savages@pcez.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: more info
In-Reply-To: <3C45D723.7090308@pcez.com>
Message-ID: <Pine.GSO.4.33.0201161507420.7787-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 16 Jan 2002, Shaun Savage wrote:

> During the load process I get
>
> ss: loading .....
> security: 5 users, 6roles, 391 types
> security: 29 classes, 74171 rules
> security: context root:sysadm_r:ipchains_t is invalid

This error is because you didn't authorize the ipchains_t domain for the
sysadm_r role, due to your typo (sysadm_t instead of sysadm_r).  From the
perspective of the security server, you just defined a new role named
sysadm_t that is authorized for ipchains_t.  Roles and types exist in
separate namespaces, so this doesn't show up as a policy compiler error.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
