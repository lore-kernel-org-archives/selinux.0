Subject: Re: Suggestion on fixing a old libselinux problem.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4F4E8EDF.1030405@redhat.com>
References: <4F4E8EDF.1030405@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Feb 2012 16:22:53 -0500
Message-ID: <1330550573.20078.24.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-02-29 at 15:47 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> One of the oldest bugs/wacki things about SELinux is what happens when
> a login program can not calculate a login context.
> 
> Right now we have an open bug on confined users.  Basically if you
> setup a confined user guest_u and attempt to login to that user via
> xdm_t, you get a context of guest_u:guest_r:oddjob_mkhomedir_t:s0
> 
> selinuxdefcon pwalsh system_u:system_r:xdm_t:s0
> guest_u:guest_r:oddjob_mkhomedir_t:s0
> 
> Yech.
> 
> This could be considered a security hole, but it is definitely broken.
>  I have been looking at the libselinux code but this is actually
> expected behavior, and I am not eager to fix it, since it might break
> peoples expectations.
> 
> Eric suggested that we might want to move the problem out of
> libselinux and make this a login program problem.  Make the login
> programs pam_selinux a userspace manager.
> 
> After libselinux returns a context to pam_selinux it would check for
> the following allow rule.
> 
> allow logindomain userdomain:login entrypoint;
> 
> Then pam_namespace would check if xdm_t is allowed a login entry point
> into oddjob_mkhomedir_t, if no, blow up the login.
> 
> Comments?

Last time we discussed this, I thought we agreed to migrate away from
the current usage of security_compute_user (/selinux/user) altogether
within libselinux, and replace it with a simpler userspace configuration
and logic for determining user roles and levels.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
