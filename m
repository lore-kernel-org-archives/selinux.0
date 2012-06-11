Message-ID: <4FD62CAF.2000806@redhat.com>
Date: Mon, 11 Jun 2012 13:36:47 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Boolean change of names.
References: <4FD61901.1010806@redhat.com> <1339433473.8102.18.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1339433473.8102.18.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/11/2012 12:51 PM, Stephen Smalley wrote:
> On Mon, 2012-06-11 at 12:12 -0400, Daniel J Walsh wrote:
>> We have started pushing a boolean change into Fedora 18.
>> 
>> https://fedoraproject.org/wiki/Features/SELinuxBooleansRename
>> 
>> The problem we are seeing is that boolean names used within an interface
>> are causing the install to fail on rebuild of policy.
>> 
>> IE If I installed a custom policy with a boolean used in it, and the
>> boolean changed then the module will blow up the policy compile.
>> 
>> 
>> interface(`kerberos_manage_host_rcache',` gen_require(` type
>> krb5_host_rcache_t; ')
>> 
>> ...
>> 
>> tunable_policy(`allow_kerberos',` allow $1 self:process setfscreate; ... 
>> ')
>> 
>> ... ')
>> 
>> And change the allow_kerberos to kerberos_enabled.
>> 
>> One idea would be to pull the translations into the semanage, or would I
>> need to do this at a lower level.  Or are we stuck with these bad names
>> forever...
> 
> Adding boolean aliases to the policy language, including kernel support, 
> seems like the best route if you truly want to do this.
> 

I disagree, this is just a translation problem.  We can build it into the
toolchain and not dirty up the kernel.

I would prefer to go with the simpler root and not dirty up
/sys/fs/selinux/booleans.



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/WLK8ACgkQrlYvE4MpobN8AwCgvk9TPyuDdTyAqXnkKVtSAn1m
6sEAoOVm5f86/PFhbSeZXXRernQr/lxn
=BA5Z
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
