Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7G88QUg008907
 for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2016 04:08:28 -0400
Received: by mail-wm0-f43.google.com with SMTP id o80so149781506wme.1
 for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2016 01:08:25 -0700 (PDT)
Received: from [84.245.30.81] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id cw7sm25417937wjb.38.2016.08.16.01.08.22
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Aug 2016 01:08:23 -0700 (PDT)
Subject: Re: [Bug report] Semanage fcontext with incorrect regexp
To: selinux@tycho.nsa.gov
References: <e64bf30c-083c-d3ab-c2a2-864b65a2b445@redhat.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <06478ceb-2c70-6890-acfe-9f2425a038ec@gmail.com>
Date: Tue, 16 Aug 2016 10:08:12 +0200
MIME-Version: 1.0
In-Reply-To: <e64bf30c-083c-d3ab-c2a2-864b65a2b445@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PBaNgTxOMjaeFmIOGqj4bcxlc1Xfjdpin"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PBaNgTxOMjaeFmIOGqj4bcxlc1Xfjdpin
Content-Type: multipart/mixed; boundary="Suqj7rBtxek9Q9FiBwCJNwl0wN1Pdmgs8"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <06478ceb-2c70-6890-acfe-9f2425a038ec@gmail.com>
Subject: Re: [Bug report] Semanage fcontext with incorrect regexp
References: <e64bf30c-083c-d3ab-c2a2-864b65a2b445@redhat.com>
In-Reply-To: <e64bf30c-083c-d3ab-c2a2-864b65a2b445@redhat.com>

--Suqj7rBtxek9Q9FiBwCJNwl0wN1Pdmgs8
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/16/2016 09:32 AM, Vit Mojzis wrote:
> When given invalid regexp, semanage reports error, but adds the invalid=

> context to "/etc/selinux/targeted/contexts/files/file_contexts.local",
> which breaks the system (won't boot in enforcing mode). The new context=

> doesn't show up on "#semanage fcontext -l -C" and cannot be removed by
> "semanage fcontext --delete".
>=20

Slightly related to this. Now that we have this pretty nice priorities
feature and CIL in general. Can we not take advantage of that and
consider unifying the stuff in /var/lib/selinux where possible.

CIL should be perfect for things like this.

For example instead of maintaining these file_contexts.local files, just
make (lib)semanage load cil modules on some specified priority for these
type of customization's. That way the stuff is more uniform (its pretty
much all in cil modules and written in cil instead of these
{port_contexts,file_context}.local files etc. (there is then also
automatically a module to remove any invalid specs)

That will not deal with any regular expression validation, but if we
could make secilc smart enough to identify invalid regular expressions
then we have a solution for this in a central place as well.

I am pretty sure that I am overlooking things here but it seems like a
good idea to me.

> Investigation on Fedora version of libsemanage showed that
> "file_contexts.local" is not backed up before the new version is
> installed into the system and therefore cannot be restored after failur=
e.
> For more details see: https://bugzilla.redhat.com/show_bug.cgi?id=3D136=
2041
>=20
> # semanage fcontext -a -t httpd_exec_t "(/.*)?"
>         specfiles SHA1 digest: 980289cabd78157523679695fd2e4fd0a5b5ff05=

>         calculated using the following specfile(s):
> /etc/selinux/targeted/contexts/files/file_contexts.subs_dist
>         /etc/selinux/targeted/contexts/files/file_contexts.subs
>         /etc/selinux/targeted/contexts/files/file_contexts
> /etc/selinux/targeted/contexts/files/file_contexts.homedirs
>         /etc/selinux/targeted/contexts/files/file_contexts.local
>         libsemanage.semanage_exec_prog: Child process
> /sbin/sefcontext_compile did not exit cleanly. (No such file or directo=
ry).
>         libsemanage.sefcontext_compile: sefcontext_compile returned
> error code -1. Compiling
> /etc/selinux/targeted/contexts/files/file_contexts.local (No such file
> or directory).
>         specfiles SHA1 digest: 5097e1780892f53aedb6d30d5d61206a159a20e7=

>         calculated using the following specfile(s):
> /etc/selinux/targeted/contexts/files/file_contexts.subs_dist
>         /etc/selinux/targeted/contexts/files/file_contexts.subs
>         /etc/selinux/targeted/contexts/files/file_contexts.bin
> /etc/selinux/targeted/contexts/files/file_contexts.homedirs
>         /etc/selinux/targeted/contexts/files/file_contexts.local
>         libsemanage.semanage_exec_prog: Child process
> /sbin/sefcontext_compile did not exit cleanly. (No such file or directo=
ry).
>         libsemanage.sefcontext_compile: sefcontext_compile returned
> error code -1. Compiling
> /etc/selinux/targeted/contexts/files/file_contexts.local (No such file
> or directory).
>         FileNotFoundError: [Errno 2] No such file or directory
> # semanage fcontext -l -C
>     -
>=20
> # cat /etc/selinux/targeted/contexts/files/file_contexts.local
>         # This file is auto-generated by libsemanage
>         # Do not edit directly.
>=20
>         (/.*)?    system_u:object_r:httpd_exec_t:s0
>=20
> # semanage fcontext -d -t httpd_exec_t "(/.*)?"
>         ValueError: File context for (/.*)? is not defined
>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--Suqj7rBtxek9Q9FiBwCJNwl0wN1Pdmgs8--

--PBaNgTxOMjaeFmIOGqj4bcxlc1Xfjdpin
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXssnxAAoJECV0jlU3+Udp/ikMALDBtwLdGd6o9svoG6d3FMKs
b4CWAKXQLwa+Zy13ovd+hqMy/YLXRq1ET46RR7mthzL1sw+NHEOXb4iyx+s1jo4U
RWx6M7TLOp4hAtJ/La2IiTLCpSGbmXjiIa+0/3oP/yDbSnZ5awFbbgzXPHy40twJ
a8J9rPG/+G64JsSkcLiNyuw9Lh1HCdAIQD5JIDCKN4Q3XFCT4GlQOPW9on8TzDLF
vJpTQgX0WPLbSs0v15WUrcbRNPbW3NuZo+231TPp3Ed3Z5j4My3dMkrUgy2iyRDh
VdxFmFq+q0mLmUblIguFLhdKdbU758pmYADHsLeEQfRFd5M+pX5DlQH4fKRQGqJz
DoAoxUsfgcohUP6fblnNZoh+/Ys80/pEUDD+CZn48X2HXuRLMsDF3vgcZdKZQu3S
+kuYNq0lSHiY2cgmcnua+uRp0Tk9t+7jnxyEM5/pTqTh+8MGsY2ti/E1qqVrI61l
6/Y9F3uBEWw5awSWZqlZqtI2MYBbNJgdnIqaprJ0dg==
=DUQE
-----END PGP SIGNATURE-----

--PBaNgTxOMjaeFmIOGqj4bcxlc1Xfjdpin--
