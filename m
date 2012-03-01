Message-ID: <4F4F8AE8.5080703@redhat.com>
Date: Thu, 01 Mar 2012 09:42:48 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Suggestion on fixing a old libselinux problem.
References: <4F4E8EDF.1030405@redhat.com>  <1330550573.20078.24.camel@moss-pluto> <1330551258.20078.28.camel@moss-pluto>
In-Reply-To: <1330551258.20078.28.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/29/2012 04:34 PM, Stephen Smalley wrote:
> On Wed, 2012-02-29 at 16:22 -0500, Stephen Smalley wrote:
>> On Wed, 2012-02-29 at 15:47 -0500, Daniel J Walsh wrote:
>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>> 
>>> One of the oldest bugs/wacki things about SELinux is what
>>> happens when a login program can not calculate a login
>>> context.
>>> 
>>> Right now we have an open bug on confined users.  Basically if
>>> you setup a confined user guest_u and attempt to login to that
>>> user via xdm_t, you get a context of
>>> guest_u:guest_r:oddjob_mkhomedir_t:s0
>>> 
>>> selinuxdefcon pwalsh system_u:system_r:xdm_t:s0 
>>> guest_u:guest_r:oddjob_mkhomedir_t:s0
>>> 
>>> Yech.
>>> 
>>> This could be considered a security hole, but it is definitely
>>> broken. I have been looking at the libselinux code but this is
>>> actually expected behavior, and I am not eager to fix it, since
>>> it might break peoples expectations.
>>> 
>>> Eric suggested that we might want to move the problem out of 
>>> libselinux and make this a login program problem.  Make the
>>> login programs pam_selinux a userspace manager.
>>> 
>>> After libselinux returns a context to pam_selinux it would
>>> check for the following allow rule.
>>> 
>>> allow logindomain userdomain:login entrypoint;
>>> 
>>> Then pam_namespace would check if xdm_t is allowed a login
>>> entry point into oddjob_mkhomedir_t, if no, blow up the login.
>>> 
>>> Comments?
>> 
>> Last time we discussed this, I thought we agreed to migrate away
>> from the current usage of security_compute_user (/selinux/user)
>> altogether within libselinux, and replace it with a simpler
>> userspace configuration and logic for determining user roles and
>> levels.
> 
> I don't think we want to introduce greater complexity and more
> possible failures causes into the mix for determining user
> contexts.  Simplest option would be to change
> get_ordered_context_list() to return the empty list / fail in that
> case rather than return the full reachable list from 
> security_compute_user.  But I'd like to get rid of / replace 
> security_compute_user with a solution that is mostly userspace, at
> most getting the user's authorized roles and default level
> information from selinuxfs but not asking the kernel to compute
> reachability.
> 


Meaning we should read the contents of
/etc/selinux/TYPE/contexts/users/SELINUXUSER and get the types from
there that match the type of the login program.
If that file does not exist, then fall back to
/etc/selinux/TYPE/contexts/default_context and get the type from there.

Then just check with the kernel if LOGINTYPE_T can transition to
USERTYPE_T and choose that context. Else go to the next context.  If
no context is available to transition return failure.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9PiugACgkQrlYvE4MpobP2CQCePPk7/VDAYemrbiajTY1O5FRa
XPIAoJS1JhIQAKF+cfDI/TiUt60m5+Nc
=Oejr
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
