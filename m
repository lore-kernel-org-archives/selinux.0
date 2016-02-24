Subject: Re: getpidcon with pid == 0 (Was: Re: [PATCH 2/2] libselinux:
 procattr: return einval for <= 0 pid args.)
To: Stephen Smalley <sds@tycho.nsa.gov>, Nick Kralevich <nnk@google.com>
References: <1456259040-13721-1-git-send-email-dcashman@android.com>
 <1456259040-13721-2-git-send-email-dcashman@android.com>
 <1456259040-13721-3-git-send-email-dcashman@android.com>
 <56CDC2EC.5050502@tycho.nsa.gov>
 <CAFJ0LnHvFe6PkGp2BGKj-cQ-e11kFo9DacB_MbP9xFmi5S=DNA@mail.gmail.com>
 <56CDCCFD.9020009@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <56CDDE94.9040505@redhat.com>
Date: Wed, 24 Feb 2016 17:47:16 +0100
MIME-Version: 1.0
In-Reply-To: <56CDCCFD.9020009@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cTmcA9N00UFdFuGnR6ejb1G9tET0AFM3L"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cTmcA9N00UFdFuGnR6ejb1G9tET0AFM3L
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 02/24/2016 04:32 PM, Stephen Smalley wrote:
> On 02/24/2016 10:25 AM, Nick Kralevich wrote:
>> A quick Google search for "getpidcon(0" shows only the Android bug.
>>
>> https://www.google.com/webhp#q=3D%22getpidcon(0%22
>>
>> -- Nick
>=20
> Yes, I looked through searchcode.com results for getpidcon (not just
> with a hardcoded 0 but also looking for any cases where they assume tha=
t
> setting a variable pid =3D=3D 0 degenerates to getcon behavior), and di=
dn't
> see anything.
>=20
> I've also asked the Fedora SELinux maintainers if they know of anything=

> that would break.

Thanks for heads up.

I haven't found such case as well. Nevertheless I resent it to the
Fedora development mailing list to make the change more visible.

Thanks,

Petr


>=20
>>
>> On Wed, Feb 24, 2016 at 6:49 AM, Stephen Smalley <sds@tycho.nsa.gov
>> <mailto:sds@tycho.nsa.gov>> wrote:
>>
>>     On 02/23/2016 03:24 PM, Daniel Cashman wrote:
>>
>>         From: dcashman <dcashman@android.com
>> <mailto:dcashman@android.com>>
>>
>>         getpidcon documentation does not specify that a pid of 0 refer=
s
>>         to the
>>         current process, and getcon exists specifically to provide thi=
s
>>         functionality, and getpidcon(getpid()) would provide it as wel=
l.
>>         Disallow pid values <=3D 0 that may lead to unintended behavio=
r in
>>         userspace object managers.
>>
>>
>>     I'll try to see if there are any legitimate users of getpidcon wit=
h
>>     pid =3D=3D 0.  If anyone on the list knows of one, please speak up=
=2E
>>
>>
>>         Signed-off-by: Daniel Cashman <dcashman@android.com
>>         <mailto:dcashman@android.com>>
>>         ---
>>            libselinux/src/procattr.c | 14 ++++++++++++--
>>            1 file changed, 12 insertions(+), 2 deletions(-)
>>
>>         diff --git a/libselinux/src/procattr.c
>> b/libselinux/src/procattr.c
>>         index c20f003..eee4612 100644
>>         --- a/libselinux/src/procattr.c
>>         +++ b/libselinux/src/procattr.c
>>         @@ -306,11 +306,21 @@ static int setprocattrcon(const char *
>>         context,
>>            #define getpidattr_def(fn, attr) \
>>                  int get##fn##_raw(pid_t pid, char **c)  \
>>                  { \
>>         -               return getprocattrcon_raw(c, pid, #attr); \
>>         +               if (pid <=3D 0) { \
>>         +                       errno =3D EINVAL; \
>>         +                       return -1; \
>>         +               } else { \
>>         +                       return getprocattrcon_raw(c, pid,
>> #attr); \
>>         +               } \
>>                  } \
>>                  int get##fn(pid_t pid, char **c)        \
>>                  { \
>>         -               return getprocattrcon(c, pid, #attr); \
>>         +               if (pid <=3D 0) { \
>>         +                       errno =3D EINVAL; \
>>         +                       return -1; \
>>         +               } else { \
>>         +                       return getprocattrcon(c, pid, #attr); =
\
>>         +               } \
>>                  }
>>
>>            all_selfattr_def(con, current)
>>
>>
>>
>>
>>
>> --=20
>> Nick Kralevich | Android Security | nnk@google.com
>> <mailto:nnk@google.com> | 650.214.4037
>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.





--cTmcA9N00UFdFuGnR6ejb1G9tET0AFM3L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWzd6UAAoJEGOorUuYLENz/NgQAJHD6S8hxrCvU/IiRuQD7klF
d72AUHVpz2WM6OI6qfZkHy44PK+LKI9osfO+YJAVrQwS4nKcn4cvf0u3BCfO31Ti
ebuV7rEdtcf2LNaXXfHjcxAfBejM3OXXPpbRqqf71RnG5EDgX0nQJ9MlNYY+ECYm
SGltl/NgzMehZ2ElGOq28M+IGmzqt1P0jYOrn215Axz/Uk76c/lCPT7FDGr2ssyC
wTBE/R48CVIhXvE4k3LeWBq8kzXes3PGdPidXSapzfTEfu6ovdqsec6mWhFMKhBg
kxyIlexJLwqlsNc+6MTsLGUiDrhztg2aTRkNd8f32RpR7tLE+vOUIHXXPMi2umfo
ocPYxRhJqwp7DWQQYiyWuGSLBJk/VdJ3zwonfxfqJUoVUK14Hv5IW48RDzKq73Zr
bNe4U2oY7jjfQUwU712BysQ26Z11fuTZ3e1loo8nGu/iqJNJ5Er+4sFj74EqrjBQ
hdcTGn0ad7/jK/+w7/SI0cxPuY1sk8mKtRwbKWR1Hu9A/zm1G0HeOq4RWcvPmHb1
AyEic1g7PqrkQjO9A/zxWNw6PpsjaR345nv/k4E4S/AOP1fJ//czZZulazD8EbIN
BjwM9Puh87l107mVfxMDhr8TiKeRphtTfZaJvzRzYhrtLwsbh8E5/pdbomO0t4d+
hQaEqC86QhIvf2qxqVpS
=YRkH
-----END PGP SIGNATURE-----

--cTmcA9N00UFdFuGnR6ejb1G9tET0AFM3L--
