Message-ID: <47D065E2.3000702@redhat.com>
Date: Thu, 06 Mar 2008 16:45:06 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: jwcart2@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] refpolicy: Do not want to transition to sysadm_t
 when upstart runs a shell
References: <1204837907.13547.36.camel@moss-lions.epoch.ncsc.mil> <1204838797.1397.378.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1204838797.1397.378.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Thu, 2008-03-06 at 16:11 -0500, James Carter wrote:
>> Upstart spawns a shell during boot and, without this patch, it will
>> transition to the sysadm_t domain, but remain in the system_r role.
>> Services started by that shell will fail to start, even in permissive
>> mode, if system_u:system_r:sysadm_someservice_t is an invalid context.
>> We really don't want to be starting services from the sysadm_t domain
>> during boot.
> 
So it should probably transition to initrc_t, so apps started this way
would have a chance of transitioning properly.
> So what happens if one does a single user boot under upstart?
> That's the motivation for the original transition there.
> 
> Also, I guess we need to distinguish Fedora 9 and later from older
> distros here.
> 
>> Index: policy/modules/system/init.te
>> ===================================================================
>> --- policy/modules/system/init.te	(revision 2631)
>> +++ policy/modules/system/init.te	(working copy)
>> @@ -164,10 +164,12 @@
>>  ')
>>  
>>  ifndef(`distro_ubuntu',`
>> +ifndef(`distro_redhat',`
>>  	# Run the shell in the sysadm role for single-user mode.
>>  	# causes problems with upstart
>>  	userdom_shell_domtrans_sysadm(init_t)
>>  ')
>> +')
>>  
>>  optional_policy(`
>>  	auth_rw_login_records(init_t)
>>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfQZd0ACgkQrlYvE4MpobM98ACeMb7nBCkEgkE7o3Ecdvogd9HN
/psAoNvtz6DVIJL7NRlEm8t986iDRrMa
=qHme
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
