To: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>
Cc: Jordan Glover <Golden_Miller83@protonmail.ch>,
 Sargun Dhillon <sargun@sargun.me>,
 LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>,
 "Schaufler, Casey" <casey.schaufler@intel.com>,
 Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
 <CAMp4zn94SzqK_Q=de2E+Fpv5yeAhYv62XW-KU3=ghRma9d7Jvw@mail.gmail.com>
 <a287800e-bd4d-2b99-8c4c-bd61ba87fab1@schaufler-ca.com>
 <kubjHWMWfFDu8Rk19x79iMDKVbewTUMWwSjOA7vFGIbYsWYcGb50jb-Z-PSXxmcby3ZFMZWi0HCeuFgo3F8BRskxo_JUdSHFhdIsIlBxHyQ=@protonmail.ch>
 <8e2bdc10-3142-9e8d-ff05-70fa4d862dd5@schaufler-ca.com>
 <CAGXu5jJ6Ngv8A=3TV5z5+x5kCkkXwjYtDfSQjUQgscP4hv_xYg@mail.gmail.com>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <de387727-680e-7563-ff5b-17c3ea742e62@digikod.net>
Date: Thu, 16 Aug 2018 21:45:27 +0200
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJ6Ngv8A=3TV5z5+x5kCkkXwjYtDfSQjUQgscP4hv_xYg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Ax7RabQ5kPE8FeEKHjzLSbDTH0To8Nlsq"
Subject: Re: [PATCH v1 00/22] LSM: Full security module stacking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ax7RabQ5kPE8FeEKHjzLSbDTH0To8Nlsq
Content-Type: multipart/mixed; boundary="m9V04fH7EEq5PnM5u0FQxw3mBDguziMHu";
 protected-headers="v1"
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To: Kees Cook <keescook@chromium.org>,
 Casey Schaufler <casey@schaufler-ca.com>
Cc: Jordan Glover <Golden_Miller83@protonmail.ch>,
 Sargun Dhillon <sargun@sargun.me>,
 LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>,
 "Schaufler, Casey" <casey.schaufler@intel.com>,
 Salvatore Mesoraca <s.mesoraca16@gmail.com>
Message-ID: <de387727-680e-7563-ff5b-17c3ea742e62@digikod.net>
Subject: Re: [PATCH v1 00/22] LSM: Full security module stacking
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
 <CAMp4zn94SzqK_Q=de2E+Fpv5yeAhYv62XW-KU3=ghRma9d7Jvw@mail.gmail.com>
 <a287800e-bd4d-2b99-8c4c-bd61ba87fab1@schaufler-ca.com>
 <kubjHWMWfFDu8Rk19x79iMDKVbewTUMWwSjOA7vFGIbYsWYcGb50jb-Z-PSXxmcby3ZFMZWi0HCeuFgo3F8BRskxo_JUdSHFhdIsIlBxHyQ=@protonmail.ch>
 <8e2bdc10-3142-9e8d-ff05-70fa4d862dd5@schaufler-ca.com>
 <CAGXu5jJ6Ngv8A=3TV5z5+x5kCkkXwjYtDfSQjUQgscP4hv_xYg@mail.gmail.com>
In-Reply-To: <CAGXu5jJ6Ngv8A=3TV5z5+x5kCkkXwjYtDfSQjUQgscP4hv_xYg@mail.gmail.com>

--m9V04fH7EEq5PnM5u0FQxw3mBDguziMHu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


On 08/15/2018 07:19 AM, Kees Cook wrote:
> On Tue, Aug 14, 2018 at 4:50 PM, Casey Schaufler <casey@schaufler-ca.co=
m> wrote:
>> On 8/14/2018 4:22 PM, Jordan Glover wrote:
>>> On August 14, 2018 8:28 PM, Casey Schaufler <casey@schaufler-ca.com> =
wrote:
>>>
>>>>
>>>>>> The blob management part (through "LSM: Sharing of security blobs"=
)
>>>>>> is ready for prime-time. These changes move the management of
>>>>>> security blobs out of the security modules and into the security
>>>>>> module infrastructure. With this change the proposed S.A.R.A,
>>>>>> LandLock and PTAGS security modules could co-exist with any of
>>>>>> the existing "major" security modules. The changes reduce some
>>>>>> code duplication.
>>>>>> Beyond the blob management there's a bit of clean-up.
>>>>>> Mounting filesystems had to be changed so that options
>>>>>> a security module doesn't recognize won't be considered
>>>>>> a fatal error. The mount infrastructure is somewhat
>>>>>> more complex than one might assume.
>>>>> Casey,
>>>>> Do you think you can break out 1 into its own patch? It seems like
>>>>> that'd be valuable to everyone.
>>>> Yes, I think that is a good idea. Landlock, S.A.R.A. and a couple
>>>> other security modules could be added upstream if this part of the
>>>> work was available. It would not provide everything needed to stack
>>>> all the existing modules. I believe there is concern that if this
>>>> much went upstream the work on finishing what's required to make
>>>> everything work might be abandoned.
>>>>
>>> On the other hand there is concern that those security modules might
>>> be abandoned if they have to wait until everything is finished :)
>>
>> There is some truth to that. If we can get commitment from the develop=
ers
>> of those security module to push for getting upstream, a statement of
>> intent to support additional modules (e.g. Landlock, S.A.R.A.) from a

I'm the developer of Landlock. I'm working on it on my free time but my
employer is also interested and I have some dedicated time for Landlock
at work too. I've been quite busy these past months but I'll get back on
Landlock soon.

As Salvatore said, my goal is also to get Landlock upstream. The current
code is quite mature compared to the first version but there is still
some work to do before the next patch series. BTW, code reviews are much
appreciated!

The LSM stacking patch series may not be a blocker for upstreaming
Landlock but this series is needed to enable Landlock on common distro
(which won't disable their current major LSM). It would be easier to
have the LSM stacking upstream as soon as possible though.

>> significant distribution (e.g. Fedora, Ubuntu, SuSE) and ACKs from the=

>> maintainers of the existing modules we should be able to breeze right =
in.
>>
>> Yeah, I think that's about all it would take.
>=20
> I would strongly recommend Landlock and SARA for every distro. They're
> opt-in, and provide much-needed missing userspace defenses (and attack
> surface reduction).
>=20
> -Kees
>=20

Thanks Kees! And great work Casey!

 Micka=C3=ABl


--m9V04fH7EEq5PnM5u0FQxw3mBDguziMHu--

--Ax7RabQ5kPE8FeEKHjzLSbDTH0To8Nlsq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUysCyY8er9Axt7hqIt7+33O9apUFAlt11FcACgkQIt7+33O9
apUJlwf+I4XLIzJkMdNT+cZ863oGTUVOUFlu2g+jf1WszqyA/CMUb9Oi7Vp1yQKj
rNJ80mLfDkCH5U65WY+Nq6CpymHu9XQRU8MuaxQzlZAwMr28+ne2fc4n+uNy4zRN
S2sXrTCLgE1YJBIH9cL25zEe79xbzJIFr0ws4METB4PvvhK5m8mtWWtfvALOPd2J
1er/qDM7jL0Y3jLRIJ9XRUaWcEm5aFBY7qBYh5seZL6rQerrHUNMf1Ik+smxH1PK
odwTVHrb1pzCb51yDtvrTFvHtRCYygj9VaI3ajBU/jipurltMjHe/5KEKlXXLari
VO1Z5TvUMVOOoAYwoNULSAs3o5WVeQ==
=OhzK
-----END PGP SIGNATURE-----

--Ax7RabQ5kPE8FeEKHjzLSbDTH0To8Nlsq--
