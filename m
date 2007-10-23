Message-ID: <471DFC97.6040303@redhat.com>
Date: Tue, 23 Oct 2007 09:52:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: trouble with ssh in today's rawhide + refpolicy
References: <471D1596.8070900@tycho.nsa.gov> <1193144985.9466.53.camel@gorn>	 <1193145799.2179.18.camel@moss-spartans.epoch.ncsc.mil> <1193146797.9466.64.camel@gorn>
In-Reply-To: <1193146797.9466.64.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher J. PeBenito wrote:
> On Tue, 2007-10-23 at 09:23 -0400, Stephen Smalley wrote:
>> On Tue, 2007-10-23 at 13:09 +0000, Christopher J. PeBenito wrote:
>>> On Mon, 2007-10-22 at 17:26 -0400, Eamon Walsh wrote:
>>>> On a rawhide box updated this afternoon, running refpolicy trunk in mcs 
>>>> mode, I get the following after rebooting the box and logging in over ssh:
>>>>
>>>> $ id -Z
>>>> sysadm_u:sysadm_r:system_chkpwd_t:s0
>>> Do you have ssh_sysadm_login on?  Also, it seems odd that this would
>>> happen, since this combination doesn't show up in default_contexts, and
>>> the only auto transition to system_chkpwd_t from sshd_t is via
>>> chkpwd_exec_t.
>> We've seen this kind of behavior before when the
>> get_ordered_context_list() logic fails to get any contexts from
>> security_compute_user() that correspond with any of the partial contexts
>> in default_contexts - it then falls back to just returning the entire
>> reachable list.
> 
> Ok.  For some reason I always thought it would just fail if nothing
> worked from default_contexts.
> 
I think that is what should happen, but it does not.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHHfyXrlYvE4MpobMRAvQNAKCR6fWOHP0X6JWnq6eDNcgrl4soxQCgwrRr
tO7ZGg5rSyioXl4LwdJD/9U=
=KTjm
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
