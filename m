Message-ID: <4E32CD7F.9000902@redhat.com>
Date: Fri, 29 Jul 2011 11:10:55 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <selinux@tycho.nsa.gov>, Karel Srot <ksrot@redhat.com>,
        Steve Lawrence <slawrence@tresys.com>
Subject: Re: Fwd: How to extract file context patterns from selinux module
References: <1311941001.7994.4.camel@dhcp-30-102.brq.redhat.com>  <4E32A24A.4000503@redhat.com> <1311946147.12720.26.camel@moss-pluto>
In-Reply-To: <1311946147.12720.26.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/29/2011 09:29 AM, Stephen Smalley wrote:
> On Fri, 2011-07-29 at 08:06 -0400, Daniel J Walsh wrote:
>> Hi, could you please help me with following problem? I would like
>> to extract context patterns from a selinux module. I know there are
>> placed at the end of the module but I don't know (and didn't find)
>> the module structure. Therefore I don't know how to parse them (if
>> there are any in the module).
>> 
>> Thank you in advance Karel Srot
>> 
>> $ tail abrt.pp var/cache/abrt-di(/.*)?
>> system_u:object_r:abrt_var_cache_t:s0 /var/log/abrt-logger		--
>> system_u:object_r:abrt_var_log_t:s0 /var/run/abrt\.pid			--
>> system_u:object_r:abrt_var_run_t:s0 /var/run/abrtd?\.lock		--
>> system_u:object_r:abrt_var_run_t:s0 /var/run/abrtd?\.socket		-s
>> system_u:object_r:abrt_var_run_t:s0 /var/run/abrt(/.*)?
>> system_u:object_r:abrt_var_run_t:s0 ...
> 
> I created this program a while ago to support unpacking the .mod
> file from the .pp file, and just extended it to optionally unpack the
> .fc file as well.  If people find it useful, we could perhaps add it
> to policycoreutils.
> 
> $ gcc -lsepol -o semodule_unpackage semodule_unpackage.c $ bunzip2 -c
> /usr/share/selinux/targeted/apache.pp.bz2 > apache.pp $
> semodule_unpackage apache.pp apache.mod apache.fc $ cat apache.fc
> 


The real goal should be to get back to te file?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4yzX8ACgkQrlYvE4MpobNxrQCgvYNFSjBXq/RL2ZS+je1O6QR6
WDgAni1bKNAOm/2YeThXOWyPw+UXYuAK
=MwWQ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
