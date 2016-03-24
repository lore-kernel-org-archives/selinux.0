Subject: Re: strange pam_selinux behavior
To: Miroslav Grepl <mgrepl@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov
References: <56F2D938.8030909@gmail.com> <56F2E136.6090304@gmail.com>
 <56F2E276.9070702@gmail.com> <56F2E999.1070904@tycho.nsa.gov>
 <56F2E9F0.7040905@gmail.com> <56F2F163.5060309@gmail.com>
 <56F3E833.4090504@redhat.com> <56F3EA88.1020703@gmail.com>
 <56F3EBEF.7050808@redhat.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <56F3F324.6030108@gmail.com>
Date: Thu, 24 Mar 2016 15:01:08 +0100
MIME-Version: 1.0
In-Reply-To: <56F3EBEF.7050808@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 03/24/2016 02:30 PM, Miroslav Grepl wrote:
> On 03/24/2016 02:24 PM, Dominick Grift wrote:
>> On 03/24/2016 02:14 PM, Miroslav Grepl wrote:
>> 
>> <snip>
>> 
>>>> 
>>>> added the access vector back in but that seems to not make
>>>> any differenc e.
>> 
>>> So you are still getting the same error message, right?
>> 
>> 
>> not quite right:
>> 
>> It now longer shows this: "Failed to translate security class
>> context"
>> 
>> So that part seems to have been fixed by adding the access
>> vector
>> 
>> however this error is still the same:
>> 
>>> pam_selinux(sshd:session): Security context 
>>> wheel.id:wheel.role:wheel.subj:s0-s0:c0.c1023 is not allowed
>>> for wheel.id:wheel.role:wheel.s ubj:s0-s0:c0.c1023 Mar 24
>>> 13:43:03 void sshd[14723]: pam_selinux(sshd:session): Unable to
>>> get valid context for kcinimod
>> 
>> So looking at the code:
>> 
>>> src_context = context_new (src); dst_context = context_new
>>> (dst); context_range_set(dst_context,
>>> context_range_get(src_context)); if (debug) pam_syslog(pamh,
>>> LOG_NOTICE, "Checking if %s mls range valid for  %s", dst,
>>> context_str(dst_context));
>> 
>>> retval = security_compute_av(context_str(dst_context), dst,
>>> class, bit, &avd); context_free(src_context);
>>> context_free(dst_context); if (retval || ((bit & avd.allowed)
>>> != bit)) return 0;
>> 
>>> return 1;
>> 
>> it appears that security_compute_av returns bad. But i can't
>> figure out how to reproduce that with "compute_av":
>> 
>> # compute_av wheel.id:wheel.role:wheel.subj:s0-s0:c0.c1023 
>> wheel.id:wheel.role:wheel.subj:s0-s0:c0.c1023 process
>> 
>> allowed = { fork sigchld sigkill signull signal getsched
>> setsched setpgid getattr setfscreate }
>> 
>> This works fine with stock fedora policy BTW. this seems to be a
>> DSSP specific issue. I am wondering if my policy has a bug
>> somewhere...
> 
> That's my point. If it is a bug in your policy or there is a bug
> related to CIL. I can try to install your DSSP policy and check
> it.
> 
>> 
>> 
>> 
> 

Heres a brief screencast that attempts to explain the issue

https://www.youtube.com/watch?v=kx0zEreMjTA


- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJW8/MfAAoJECV0jlU3+UdpUi0L/0Tppj4qTkief2gYenLz9FI/
1fyrXJXmyzphLU7texSu4N6u9YsYqcBql7fkFoV6lB6IwPSyp/gN6d7yI5bdIPbJ
ouKXX8+3j4hwazomWxbuvy7N7/+Mnk87PWe4W8Q4VK5RxDETHfqGzQtGI4dVbfJB
eCYHGGhcRxlCYdJ4GOLetxWk7qcPhVtn7FH/SqmC985iBYAK4SZilb6Xequ2kqGc
OrNG/zBXdGhGgcqOh99hP1HoVirk7QEu8sTmUoaIl/3dTQnGSBDBoQr0w4G38M3l
FDWGjyoT5kmxOD3V74ecUDBEe7rIcmOiDSsQoUFirnR7ysj00vI/IAU05XNKbpUd
7/1f4kKis7VpNZN5YHqXxTImtOG4yBARY9jtWlFuCe5IsdN1Ltg/tmYXMUCZ+FhZ
JpuwRfWw/RpXOqF3PLi1AX/6Zd0Kv5lXO3D3xxeUh9qxjOYGbcr/DbeoYZFRAdJ+
ZGDIKX03QBHgEW1TWIrpVeg7pTgyZDnnyqbTkGMVlQ==
=/Kur
-----END PGP SIGNATURE-----
