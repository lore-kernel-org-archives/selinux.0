Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u34JpSgQ005713
 for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2016 15:51:34 -0400
Received: by mail-lb0-f170.google.com with SMTP id qe11so176879191lbc.3
 for <selinux@tycho.nsa.gov>; Mon, 04 Apr 2016 12:51:32 -0700 (PDT)
Subject: Re: On Fedora 24 I am seeing something strange with CIL
To: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
References: <56FA96D5.4010806@redhat.com> <56FAC2BB.1070202@redhat.com>
 <5702BD5D.50104@gmail.com> <5702C4A7.4040602@redhat.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <5702C5C2.9050008@gmail.com>
Date: Mon, 4 Apr 2016 21:51:30 +0200
MIME-Version: 1.0
In-Reply-To: <5702C4A7.4040602@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 04/04/2016 09:46 PM, Daniel J Walsh wrote:
> 
> 
> On 04/04/2016 03:15 PM, Dominick Grift wrote: On 03/29/2016 08:00
> PM, Daniel J Walsh wrote:
>>>> I investigated this a little further.
>>>> 
> manage_chr_files_pattern(svirt_sandbox_domain,
> svirt_sandbox_file_t, svirt_sandbox_file_t)
> 
> define(`manage_chr_files_pattern',` allow $1 self:capability
> mknod; allow $1 $2:dir rw_dir_perms; allow $1 $3:chr_file
> manage_chr_file_perms; ')
> 
>> Ok Makes sense but why didn't this come up with the
>> svirt_sandbox_domain attribute as opposed to container_t?  Maybe
>> this is a change in cil.
> 
>> I guess I should not make this the default for
>> svirt_sandbox_domain, and only add it for specific domains.
> 
>> Thanks Dominick.

Yes that may indeed well be a CIL thing. CIL does optimization, and
this may make policy analysis a bit different. So yes, be careful when
using type attributes to query the policy. Because CIL may have "moved
rules around" for the sake of efficiency. Best to alway's, atleast
also check the rules associated with the type.



> 
> 
> 
>>>> If I write a policy file like
>>>> 
>>>> =============================================== 
>>>> policy_module(container, 1.0) gen_require(` attribute 
>>>> svirt_sandbox_domain; ')
>>>> 
>>>> type foobar_t; domain_type(foobar_t) typeattribute foobar_t 
>>>> svirt_sandbox_domain; 
>>>> ===============================================
>>>> 
>>>> I get
>>>> 
>>>> 
>>>> sesearch -A -s foobar_t  | grep capa allow foobar_t foobar_t
>>>> : capability mknod ;
>>>> 
>>>> If I remove the typeattribute line foobar_t no longer has
>>>> mknod.
>>>> 
>>>> I think this is a compiler problem.
>>>> 
>>>> On 03/29/2016 10:53 AM, Daniel J Walsh wrote:
>>>>> When I compile and install this policy
>>>>> 
>>>>> ---------------------------------------------------------------
>>>>> # cat /tmp/container.te policy_module(container, 1.0)
>>>>> 
>>>>> virt_sandbox_domain_template(container)
>>>>> 
>>>>> ----------------------------------------------------------------
>>>>>
>>>>> 
I end up with mknod capability.
>>>>> 
>>>>> sesearch -A -s container_t -t container_t  -c capability
>>>>> Found 1 semantic av rules: allow container_t container_t :
>>>>> capability mknod ;
>>>>> 
>>>>> But I didn't add mknod to the policy.
>>>>> 
>>>>> grep mknod tmp/container.tmp class capability { chown 
>>>>> dac_override dac_read_search fowner fsetid kill setgid
>>>>> setuid setpcap linux_immutable net_bind_service
>>>>> net_broadcast net_admin net_raw ipc_lock ipc_owner
>>>>> sys_module sys_rawio sys_chroot sys_ptrace sys_pacct
>>>>> sys_admin sys_boot sys_nice sys_resource sys_time
>>>>> sys_tty_config mknod lease audit_write audit_control 
>>>>> setfcap };
>>>>> 
>>>>> Any ideas?
>>>> _______________________________________________ Selinux
>>>> mailing list Selinux@tycho.nsa.gov To unsubscribe, send email
>>>> to Selinux-leave@tycho.nsa.gov. To get help, send an email
>>>> containing "help" to Selinux-request@tycho.nsa.gov.
> 
> -- Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B
> 6B02 
> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
>
> 
Dominick Grift
>> _______________________________________________ Selinux mailing
>> list Selinux@tycho.nsa.gov To unsubscribe, send email to
>> Selinux-leave@tycho.nsa.gov. To get help, send an email
>> containing "help" to Selinux-request@tycho.nsa.gov.
> 

- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXAsW9AAoJECV0jlU3+Udp+7MMAIsBvo/FLOkUY0/099TmY/bU
x/97Td+N+ebHciTa/r69j2A7823s9tIJ3HwSPkLfO4ujMfTaG+7+RjjGKH7Sof2U
ZTboko964kqfdJnXmrcpkpXwDdfTzpCQ3M0h3T7r23WuZr8LfWoExHnNFv6C+6aq
Z1ZavApkd7eS69+rhn9sP9jqf8cdILlTax0EyR9GIdh41uSjVUjuw2LlH42SPdGU
xx8KUWJrG0CnGYDFkRpubOTARPoo/kmMLet1bZZnIRIeYslGFhU0QR4PazNE7ffh
nfYm+tT4mQTMf3d29oIlYVC+EH4xNxyKhxyUCBUXMNo9HyHiz/oPwxYdxsC5+AUm
Iuzc03ic4P6SDPdedyKlLyGHe3k/xfotyDZFKw20SuAA+axkKRe5q+9ZJdT8zLj4
OxJu9+E92zk3T8ZVCSGfdUhnDIwYKn8goP/4MX19MDTco3TCQETbk2Zvdx0GLw1W
pRs72qC9/gtB3dBwIX51p32b+zg+HX1eyqHGYwK73g==
=B09e
-----END PGP SIGNATURE-----
