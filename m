Message-ID: <5550B368.5020600@redhat.com>
Date: Mon, 11 May 2015 15:49:28 +0200
From: Petr Lautrbach <plautrba@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: is_selinux_enabled(): drop no-policy-loaded
 test.
References: <1429278141-7728-1-git-send-email-sds@tycho.nsa.gov>
 <5550B134.6050606@redhat.com> <5550B1FE.5040304@tycho.nsa.gov>
In-Reply-To: <5550B1FE.5040304@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="knsWdac3ApcI0uxTGCbWjQNtrM8hF2f3e"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--knsWdac3ApcI0uxTGCbWjQNtrM8hF2f3e
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05/11/2015 03:43 PM, Stephen Smalley wrote:
> On 05/11/2015 09:40 AM, Petr Lautrbach wrote:
>> On 04/17/2015 03:42 PM, Stephen Smalley wrote:
>>> SELinux can be disabled via the selinux=3D0 kernel parameter or via
>>> /sys/fs/selinux/disable (triggered by setting SELINUX=3Ddisabled in
>>> /etc/selinux/config).  In either case, selinuxfs will be unmounted
>>> and unregistered and therefore it is sufficient to check for the
>>> selinuxfs mount.  We do not need to check for no-policy-loaded and
>>> treat that as SELinux-disabled anymore; that is a relic of Fedora Cor=
e 2
>>> days.  Drop the no-policy-loaded test, which was a bit of a hack anyw=
ay
>>> (checking whether getcon_raw() returned "kernel" as that can only hap=
pen
>>> if no policy is yet loaded and therefore security_sid_to_context() on=
ly
>>> has the initial SID name available to return as the context).
>>>
>>> May possibly fix https://bugzilla.redhat.com/show_bug.cgi?id=3D119507=
4
>>> by virtue of removing the call to getcon_raw() and therefore avoiding=

>>> use of tls on is_selinux_enabled() calls.  Regardless, it will make
>>> is_selinux_enabled() faster and simpler.
>>>
>>
>> This patch breaks system with SELinux enabled kernel and without
>> loaded/installed an SELinux policy, see [1].
>>
>> Would it be feasible to have is_selinux_enabled() connected to existen=
ce
>> of SELINUX variable in /etc/selinux/config file for the cases when
>> there's no specific kernel command line option used in running system?=

>> Or would it break something else?
>>
>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1219045
>=20
> Sorry, does this occur even if they have SELINUX=3Ddisabled in
> /etc/selinux/config?

It works with SELINUX=3Ddisabled. It's only related to systems without
/etc/selinux/config and without selinux=3D0 on kernel command line.


Petr
--=20
Petr Lautrbach



--knsWdac3ApcI0uxTGCbWjQNtrM8hF2f3e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVULNoAAoJEGOorUuYLENzrf8P/AiFrWW3W4cyIFpOWwAAMqFL
njfnMQVFMPqVFjTJu3fCNxyQoUosfdzmKG8eO6/Fy92DqkHFitA40OAnZSATe4AT
vKFWy5/e/4KkeR/az24BEx2w6GVQKuMLAgJPNBROZC3UB0peZqXekxfwyZRSUQuH
1xcOoFG3+yO4ke388Qi+cdi1kLwoIRZTwJ0w/gp2SDHqQo1ud/i3HXLL8cOxjhwO
HlUvlxTdxVfAU0XFatifG/gX0vHhqAHmXdLyOZmWdQwiuhJoig4+iBcY02hl5sYa
Xq/e6eu+dE6StpIR2QnUo296pclADIsZfbQlfykg25RB2aHFlciGs0Nq6eMEasre
XKUdTMUG3E2xFybhrFGiykxj2jEwBbTZgGnJrzAOvZTXsCrd2J5uGX07Z+hIkp4J
P2QfMRq4pGhc1Zm3QBHH1JCSujZTrglkWphSufEyO5VTgYw2YvRVzr3pF7icwda+
Qxrlpvhruu16cFima8TidmChdTlWIJVWEV85y71M8fusmJP6OyGorX0Zd2Y1Is/f
PboC4yk/M5Nk6sg93wT8SX8gwJkN76Vzp2DC9/r7mM2XnPkVG/F64gq+YnZzD6rt
ID4T+vIyCQm0qHqEUszdvnDxNdHpM3HLJGZbJbCQ22zqBU4qVtr4mFzS+2fNlAsU
TtM1sCIXInjEGcMZc9ys
=kwdF
-----END PGP SIGNATURE-----

--knsWdac3ApcI0uxTGCbWjQNtrM8hF2f3e--
