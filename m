Message-ID: <5550B899.7060603@redhat.com>
Date: Mon, 11 May 2015 16:11:37 +0200
From: Petr Lautrbach <plautrba@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: is_selinux_enabled(): drop no-policy-loaded
 test.
References: <1429278141-7728-1-git-send-email-sds@tycho.nsa.gov>
 <5550B134.6050606@redhat.com> <5550B1FE.5040304@tycho.nsa.gov>
 <5550B368.5020600@redhat.com> <5550B663.1070000@tycho.nsa.gov>
 <5550B6D4.4070002@tycho.nsa.gov>
In-Reply-To: <5550B6D4.4070002@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6quLD35tck7KQKRNerrDLbjGF5kTDdbV8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6quLD35tck7KQKRNerrDLbjGF5kTDdbV8
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05/11/2015 04:04 PM, Stephen Smalley wrote:
> On 05/11/2015 10:02 AM, Stephen Smalley wrote:
>> On 05/11/2015 09:49 AM, Petr Lautrbach wrote:
>>> On 05/11/2015 03:43 PM, Stephen Smalley wrote:
>>>> On 05/11/2015 09:40 AM, Petr Lautrbach wrote:
>>>>> On 04/17/2015 03:42 PM, Stephen Smalley wrote:
>>>>>> SELinux can be disabled via the selinux=3D0 kernel parameter or vi=
a
>>>>>> /sys/fs/selinux/disable (triggered by setting SELINUX=3Ddisabled i=
n
>>>>>> /etc/selinux/config).  In either case, selinuxfs will be unmounted=

>>>>>> and unregistered and therefore it is sufficient to check for the
>>>>>> selinuxfs mount.  We do not need to check for no-policy-loaded and=

>>>>>> treat that as SELinux-disabled anymore; that is a relic of Fedora =
Core 2
>>>>>> days.  Drop the no-policy-loaded test, which was a bit of a hack a=
nyway
>>>>>> (checking whether getcon_raw() returned "kernel" as that can only =
happen
>>>>>> if no policy is yet loaded and therefore security_sid_to_context()=
 only
>>>>>> has the initial SID name available to return as the context).
>>>>>>
>>>>>> May possibly fix https://bugzilla.redhat.com/show_bug.cgi?id=3D119=
5074
>>>>>> by virtue of removing the call to getcon_raw() and therefore avoid=
ing
>>>>>> use of tls on is_selinux_enabled() calls.  Regardless, it will mak=
e
>>>>>> is_selinux_enabled() faster and simpler.
>>>>>>
>>>>>
>>>>> This patch breaks system with SELinux enabled kernel and without
>>>>> loaded/installed an SELinux policy, see [1].
>>>>>
>>>>> Would it be feasible to have is_selinux_enabled() connected to exis=
tence
>>>>> of SELINUX variable in /etc/selinux/config file for the cases when
>>>>> there's no specific kernel command line option used in running syst=
em?
>>>>> Or would it break something else?
>>>>>
>>>>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1219045
>>>>
>>>> Sorry, does this occur even if they have SELINUX=3Ddisabled in
>>>> /etc/selinux/config?
>>>
>>> It works with SELINUX=3Ddisabled. It's only related to systems withou=
t
>>> /etc/selinux/config and without selinux=3D0 on kernel command line.
>>
>> I see.  So I can see that it is a regression for such systems, but suc=
h
>> systems are definitely running suboptimally by NOT disabling SELinux i=
f
>> they are not going to even load a policy.  They are just wasting all o=
f
>> the SELinux hook call overhead in the kernel.

I agree.

>>
>> In any event, one of the benefits of the change that caused this
>> regression is that it makes is_selinux_enabled() very fast and avoids
>> any need to open any extra files on calls to it, thereby improving
>> performance on both SELinux-enabled and SELinux-disabled systems.
>>
>> I don't think we need or want to actually have it read
>> /etc/selinux/config and look for a SELINUX=3D variable.  Isn't it
>> sufficient to test for the existence of an /etc/selinux/config file,
>> e.g. access("/etc/selinux/config", F_OK)?

I'm fine with that.

>>
>> We'll have to wrap that test with #ifndef ANDROID as Android does not
>> use /etc/selinux/config.
>=20
> Oh, and let's do it once in init_selinuxmnt() and cache the result so w=
e
> aren't calling access() on each is_selinux_enabled() call.

Do you want me to prepare and send a patch?

Thanks,

Petr
--=20
Petr Lautrbach



--6quLD35tck7KQKRNerrDLbjGF5kTDdbV8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVULiZAAoJEGOorUuYLENzX38P/A/ugCnU5J3LgM9i5UdGclDN
F9eSem7X/BeavEi0VUszwTlEK47e8RBHD2ftOhPvnE3gU/VeXL01kDBBp1nMiOr5
G/U1G98y6/Nq9HgSnr0S0PDFmXWwUHHba+s6i3FltfcNmlfmPiv1wpEmxDYdfnV5
O/rGD881ukdBlxhgQ9ULoN/bcFzHW1pJykRrkkGhtMR2m5lIieVJK/z8doNYW8L/
1F3XzLz2Ti7JJbRwQeHXQxpaHHSPu+4cKJ8kGtoY85AuPCZZjemJuuL3K4LFX3Wr
+svFQEAYLni42kfPZfoV1cxeF3mj3yA/p11R+46hjcefbLMFoMbp79TsGe00orS4
4scgMiYcxRfH5WTqlkXzjC8AmDCGgct2BA8tAcjKoW9YZe1z69x/OpvIOhCKjuDc
v1crM3iXlgMrgklA3psfVZk0S/q18a/4fl1m29OAONyxyhcSg1zPbFkrxB05aWCb
heGDdwnWcyT7wweDrF53MIjqTE0i5TLXynZQpAkK45XfwFhQ36ZV0H6BLDpZ6uJ9
EmnSB2hKQ8KIVjBt8+h+tE02prVQOgyw2qxuFFtmvrzx5iDbU8aiEmsNR+FkfT8X
44OH0z5jOPF1iwWO3AQqyNrrHuzkulzHscbFTuVcVG0sRU8e+WClbc6KRD5rvWNX
7VcU0bg5zd8Stnq5SnzU
=8/AC
-----END PGP SIGNATURE-----

--6quLD35tck7KQKRNerrDLbjGF5kTDdbV8--
