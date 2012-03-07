Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q27FvBSQ003670
	for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2012 10:57:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 07 Mar 2012 10:57:09 -0500
From: David Quigley <selinux@davequigley.com>
To: Yao <yffbrave@163.com>
Cc: <selinux@tycho.nsa.gov>
Subject: Re: A few questions
In-Reply-To: <14357406.17003.135edba7f47.Coremail.yffbrave@163.com>
References: <14357406.17003.135edba7f47.Coremail.yffbrave@163.com>
Message-ID: <c7e5c731607a1975c4e24583bdf36d98@countercultured.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/07/2012 10:15, Yao wrote:
> Hi,
> Lately I'm studying SELinux and got some questions which I want to be
> clear.
>
> (1)I know SELinux is based on Flask architecture and I know where the
> SS is, but I'm not sure
> where the OM locates, I guess the variable "security_ops" which
> belongs to LSM represents the OM, am I right?
>
> (2)the struct "selinux_ops" in file hooks.c is declared as "static",
> why not add "const" qualifier so that
> the it will be put in read-only data section in the kernel?
>
> (3)Is there any way to hack the SELinux, I mean, to disable it on the
> fly? For example, replace the policy db with a
> blank file so that any permission is allowed. Is it feasible?
>
> Regards,
> Yao

So In order.

I asked (1) when I first started as well and the answer I got was the 
kernel itself is the object manager. You'll notice a bunch of security_ 
calles through the kernel. These are the enforcement points which query 
the security server through the selinux specific hooks behind the LSM 
interface.

(2) I'm not sure if there is a reason not to. I don't know how this 
would effect runtime disabling since we unhook those functions if we are 
disabled.

(3) So if you're in the kernel there are techniques to disable SELinux 
and make it appear like it is still running. Replacing the policy db 
with an empty one would be the opposite of the effect you want. Since 
SELinux is deny by default it would give you a system with no access not 
all access. The MDP program in the kernel tree makes a policy with one 
type that has access to everything but that would be obvious and not 
useful. Especially when all of the domains you're programs are currently 
running in suddenly disappear.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
