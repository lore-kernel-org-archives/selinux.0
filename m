To: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>,
 Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 "Schaufler, Casey" <casey.schaufler@intel.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <alpine.LRH.2.21.1809130727310.19741@namei.org>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <d2ad1caf-4e81-f33d-f764-6f90f9d101c4@digikod.net>
Date: Tue, 18 Sep 2018 09:44:47 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1809130727310.19741@namei.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6t2AHDVawcfDyXz43It5ZPOAYstQl28sP"
Subject: Re: [PATCH v2 00/10] LSM: Module stacking in support of
 S.A.R.A and Landlock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6t2AHDVawcfDyXz43It5ZPOAYstQl28sP
Content-Type: multipart/mixed; boundary="wlIgseE8uGy21t8rLeoSLitsACGY9OGDi";
 protected-headers="v1"
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To: James Morris <jmorris@namei.org>, Casey Schaufler
 <casey@schaufler-ca.com>, Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 "Schaufler, Casey" <casey.schaufler@intel.com>
Message-ID: <d2ad1caf-4e81-f33d-f764-6f90f9d101c4@digikod.net>
Subject: Re: [PATCH v2 00/10] LSM: Module stacking in support of S.A.R.A and
 Landlock
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <alpine.LRH.2.21.1809130727310.19741@namei.org>
In-Reply-To: <alpine.LRH.2.21.1809130727310.19741@namei.org>

--wlIgseE8uGy21t8rLeoSLitsACGY9OGDi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


On 9/12/18 23:29, James Morris wrote:
> Adding the SARA and LandLock authors for review & comment.
>=20
> Salvatore & Micka=C3=ABl: does this patchset meet your needs for mergin=
g to=20
> mainline?

It almost does! For now, I need the task_struct, cred, inode and file
security blobs. Only the task_struct one is missing.

FYI, the capitalization of Landlock is not consistent in all commit
messages. :)

Thanks,
 Micka=C3=ABl

>=20
>=20
>=20
> On Tue, 11 Sep 2018, Casey Schaufler wrote:
>=20
>> LSM: Module stacking in support of S.A.R.A and Landlock
>>
>> v2: Reduce the patchset to what is required to support
>>     the proposed S.A.R.A. and LandLock security modules
>>
>> The S.A.R.A. security module is intended to be used
>> in conjunction with other security modules. It requires
>> state to be maintained for the credential, which
>> in turn requires a mechanism for sharing the credential
>> security blob. The module also requires mechanism for
>> user space manipulation of the credential information,
>> hence an additional subdirectory in /proc/.../attr.
>>
>> The LandLock security module provides user configurable
>> policy in the secmark mechanism. It requires data in
>> the credential, file and inode security blobs. For this
>> to be used along side the existing "major" security
>> modules mechanism for sharing these blobs is provided.
>>
>> A side effect of providing sharing of the crendential
>> security blob is that the TOMOYO module can be used at
>> the same time as the other "major" modules.
>>
>> The mechanism for configuring which security modules are
>> enabled has to change when stacking in enabled. Any
>> module that uses just the security blobs that are shared
>> can be selected. Additionally, one other "major" module
>> can be selected.
>>
>> The security module stacking issues around networking and
>> IPC are not addressed here as they are beyond what is
>> required for TOMOYO, S.A.R.A and LandLock.
>>
>> git://github.com/cschaufler/lsm-stacking.git#stacking-4.19-rc2-saraloc=
k
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  Documentation/admin-guide/LSM/index.rst |  23 ++-
>>  fs/proc/base.c                          |  64 ++++++-
>>  fs/proc/internal.h                      |   1 +
>>  include/linux/lsm_hooks.h               |  20 ++-
>>  include/linux/security.h                |  15 +-
>>  kernel/cred.c                           |  13 --
>>  security/Kconfig                        |  92 ++++++++++
>>  security/apparmor/domain.c              |   2 +-
>>  security/apparmor/include/cred.h        |  24 ++-
>>  security/apparmor/include/file.h        |   9 +-
>>  security/apparmor/include/lib.h         |   4 +
>>  security/apparmor/lsm.c                 |  53 ++++--
>>  security/apparmor/task.c                |   6 +-
>>  security/security.c                     | 293 +++++++++++++++++++++++=
+++++++--
>>  security/selinux/hooks.c                | 215 ++++++++---------------=

>>  security/selinux/include/objsec.h       |  37 +++-
>>  security/selinux/selinuxfs.c            |   5 +-
>>  security/selinux/xfrm.c                 |   4 +-
>>  security/smack/smack.h                  |  42 ++++-
>>  security/smack/smack_access.c           |   4 +-
>>  security/smack/smack_lsm.c              | 283 +++++++++++------------=
-------
>>  security/smack/smackfs.c                |  18 +-
>>  security/tomoyo/common.h                |  31 +++-
>>  security/tomoyo/domain.c                |   4 +-
>>  security/tomoyo/securityfs_if.c         |  15 +-
>>  security/tomoyo/tomoyo.c                |  57 +++++--
>>  26 files changed, 899 insertions(+), 435 deletions(-)
>>
>=20


--wlIgseE8uGy21t8rLeoSLitsACGY9OGDi--

--6t2AHDVawcfDyXz43It5ZPOAYstQl28sP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUysCyY8er9Axt7hqIt7+33O9apUFAlugrO8ACgkQIt7+33O9
apUf5Af+JJNP6M6qsRzVbsUmXo2eiDaxhGn8mU5ndWw/x6DMHAOtG4D6ug7P59lb
uXx9yG2T5+6haVYEtifoPEiVadVCOoC/y3Po93WUIbQSJhOvb9RYb1ILRR13TYrw
q2MUMA39HiDhva4tkyxAJYBBOum9MFiRYjZudqJIneMnhDE2v7W5SoUlUiO75kYL
yhnoDB0WbkdnNjbdAek8JtRbTqYWKH81+pXMXwNwBc3IP2/stVAW3AAz0P4YAjSE
/Jj5EkrVAEy6A+sQOQm2kHmET0mFI2py5kSKMqYHZ8eWVG7FsSo3e9jqxyE+LRQl
oy7gkpId6zo9HtFD6Ktuwry9YZf8Ag==
=ILf6
-----END PGP SIGNATURE-----

--6t2AHDVawcfDyXz43It5ZPOAYstQl28sP--
