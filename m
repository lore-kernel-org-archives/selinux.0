Subject: Re: Default Policy question?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Tom <tom@lemuria.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux@tycho.nsa.gov
In-Reply-To: <20030602230314.C3637@lemuria.org>
References: <3EDB7585.8050308@redhat.com>
	 <1054574512.1053.178.camel@moss-huskers.epoch.ncsc.mil>
	 <20030602230314.C3637@lemuria.org>
Content-Type: text/plain
Message-Id: <1054642843.1053.276.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 03 Jun 2003 08:20:44 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-06-02 at 17:03, Tom wrote:
> But if the secadm_r controls the policy, he should have enough power at
> his hands to prevent subversion. Things he would have to protect:
> 
> * his home directory (environment)
> * policy and policy tools
> * kernel and kernel modules

secadm_r has far more dependencies than that short list.  What happens
if you let sysadm_r set other user's passwords?  What happens if
sysadm_r has any form of raw access to the disk or memory?  What happens
if sysadm_r can upgrade any of the authentication programs (e.g.
/bin/login, /usr/bin/sshd) or any of their dependencies (pam modules,
libc)?  What happens if sysadm_r can upgrade secadm_r's shell?  His
editor?  You get the idea.

> Other than that, all other tools are limited by the policy, aren't
> they? The sysadm_r can replace ls with a trojaned binary, but he can't
> make it do anything that the normal ls isn't allowed to do.

I think you have this backwards. Make secadm_r's initial domain
(secadm_t) unprivileged except for the ability to run authorized policy
management tools in a domain that can modify the policy, and make sure
that all such tools re-authenticate like newrole does in order to ensure
that they are invoked at the request of the user.  Then, it doesn't
matter whether ls runs in secadm_t.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
