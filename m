Subject: Re: strange pam_selinux behavior
To: Daniel J Walsh <dwalsh@redhat.com>, Miroslav Grepl <mgrepl@redhat.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <56F2D938.8030909@gmail.com> <56F2E136.6090304@gmail.com>
 <56F2E276.9070702@gmail.com> <56F2E999.1070904@tycho.nsa.gov>
 <56F2E9F0.7040905@gmail.com> <56F2F163.5060309@gmail.com>
 <56F3E833.4090504@redhat.com> <56F3EA88.1020703@gmail.com>
 <56F3EBEF.7050808@redhat.com> <56F3FA39.6080003@gmail.com>
 <56F4512A.8080507@redhat.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <56F56129.3080509@gmail.com>
Date: Fri, 25 Mar 2016 17:02:49 +0100
MIME-Version: 1.0
In-Reply-To: <56F4512A.8080507@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 03/24/2016 09:42 PM, Daniel J Walsh wrote:
> 
> 
> On 03/24/2016 10:31 AM, Dominick Grift wrote: On 03/24/2016 02:30
> PM, Miroslav Grepl wrote:
>>>> On 03/24/2016 02:24 PM, Dominick Grift wrote:
>>>>> On 03/24/2016 02:14 PM, Miroslav Grepl wrote:
>>>>> 
>>>>> <snip>
>>>>> 
>>>>>>> added the access vector back in but that seems to not
>>>>>>> make any differenc e.
>>>>>> So you are still getting the same error message, right?
>>>>> 
>>>>> not quite right:
>>>>> 
>>>>> It now longer shows this: "Failed to translate security
>>>>> class context"
>>>>> 
>>>>> So that part seems to have been fixed by adding the access 
>>>>> vector
>>>>> 
>>>>> however this error is still the same:
>>>>> 
>>>>>> pam_selinux(sshd:session): Security context 
>>>>>> wheel.id:wheel.role:wheel.subj:s0-s0:c0.c1023 is not
>>>>>> allowed for wheel.id:wheel.role:wheel.s
>>>>>> ubj:s0-s0:c0.c1023 Mar 24 13:43:03 void sshd[14723]:
>>>>>> pam_selinux(sshd:session): Unable to get valid context
>>>>>> for kcinimod
>>>>> So looking at the code:
>>>>> 
>>>>>> src_context = context_new (src); dst_context =
>>>>>> context_new (dst); context_range_set(dst_context, 
>>>>>> context_range_get(src_context)); if (debug)
>>>>>> pam_syslog(pamh, LOG_NOTICE, "Checking if %s mls range
>>>>>> valid for  %s", dst, context_str(dst_context)); retval =
>>>>>> security_compute_av(context_str(dst_context), dst, class,
>>>>>> bit, &avd); context_free(src_context); 
>>>>>> context_free(dst_context); if (retval || ((bit &
>>>>>> avd.allowed) != bit)) return 0; return 1;
>>>>> it appears that security_compute_av returns bad. But i
>>>>> can't figure out how to reproduce that with "compute_av":
>>>>> 
>>>>> # compute_av wheel.id:wheel.role:wheel.subj:s0-s0:c0.c1023 
>>>>> wheel.id:wheel.role:wheel.subj:s0-s0:c0.c1023 process
>>>>> 
>>>>> allowed = { fork sigchld sigkill signull signal getsched 
>>>>> setsched setpgid getattr setfscreate }
>>>>> 
>>>>> This works fine with stock fedora policy BTW. this seems to
>>>>> be a DSSP specific issue. I am wondering if my policy has a
>>>>> bug somewhere...
>>>> That's my point. If it is a bug in your policy or there is a
>>>> bug related to CIL. I can try to install your DSSP policy and
>>>> check it.
>>>> 
>>>>> 
>>>>> 
> This:
> 
>>>> $ compute_av sys.id:sys.role:sshd.sshd.subj:s0 
>>>> wheel.id:wheel.role:wheel.subj:s0-s0:c0.c1023 process
>>>> allowed= { transition signal dyntransition } auditdeny { fork
>>>> sigchld sigkill sigstop signull signal ptrace getsched
>>>> setsched getsession getpgid setpgid getcap setcap share
>>>> getattr setexec setfscreate setrlimit setcurrent execmem
>>>> execstack execheap setkeycreate setsockcreate 0xc0000000 }
> what is "0xc0000000"? am i missing av perms for process? They seem
> to be complete above
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
>> 
>> 
> I think this check is checking contains.
> 
> class context { translate contains }
> 
> 
> 
> The idea was you could run a system that only went up to Secret
> level, then if a user attempted to login as TopSecret he would be
> blocked.  I think that is what this check is all about.
> 
> 
> 

I set out to try mcstransd again today. After doing to searching i
found a clue about the requirement to add accesscheck=1 to
setrans.conf to at least enable checking of the translate av perm.

So i added a few auditallow rules that should catch at least some
checks however: nothing shows up in the logs.

Either i am overlooking something or the mcstransd object manager is
broken
- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJW9WEkAAoJECV0jlU3+UdpOuwL/3G0e9fnBRI+u0L/VEa0G1nA
5NgixnksqoZcE396/2AusUCSsSMC2TdxlDBAWQ6wi35nE9tGITcOaUDOQlQqlDJ5
5HE8oZpCLCwpUnfYqI4/+7aGNGUoLuU4ZDzvow/H0o9OQbCwgzVkcFCZDb8tOxpO
T2xd7LdbcqaUY9CP4LoPJIGkXoXrzpzBd/EjI/NydtsLKYK4ylQ7STwWSoVEeoYY
UG1aPcQ47QYIXjiAl8X/f0RUHn9CT4aPKQhvYrevnESHT+MA2s3uiXILPqB278FA
P64iGlAWdiETTblXHYsQFFR6ozqa0k9JbnvYLAnGHSGTu51Ncmcr6xr24HSH8UYI
qq0JZAOjKtzdovsel96hDJTcDPSHBF6J04ZCW74MyYYQTPsl+dPyWzjn30Ypsx0b
wRVww65gkY7LDPbcUXla9ljY3DSQG90audj+MLu76VwkJv7yvhSTE/uhmErqLxQS
IsDH2NaAMNFycgLM1raaVyAZ0ioNmQCkNmn6tYJfcw==
=JhRW
-----END PGP SIGNATURE-----
