Date: Fri, 9 Mar 2018 08:59:26 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Daniel Walsh <dwalsh@redhat.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, Zvonko Kosic <zkosic@redhat.com>,
 selinux@tycho.nsa.gov
In-Reply-To: <b1e332be-ace1-0d11-8541-53549d0e4499@redhat.com>
Message-ID: <alpine.LRH.2.21.1803090856030.20664@namei.org>
References: <CAFrfeQ5LmB6bCTT7rP8Afbmvfy8M0MpZwzunfixWA0t_wW4oBQ@mail.gmail.com>
 <35c8119b-046b-ce96-10cc-c7e17ce7d943@tycho.nsa.gov>
 <b1e332be-ace1-0d11-8541-53549d0e4499@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="1665246916-1963130981-1520546367=:20664"
Subject: Re: SELinux Namespace on bind mounted files
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1963130981-1520546367=:20664
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Mar 2018, Daniel Walsh wrote:

> I am not a big fan of Namespaced SELinux.=C2=A0 I think it complicates =
things and
> will confuse people.=C2=A0 I would think a better solution would be to =
run your
> container with a different type so that you could allow access t othese=
 file
> types.
>=20
> It would be a lot easier to create a type based on container-selinux po=
licy
> and just run your container with it.
>=20
>=20
> podman run -ti --security-opt label=3Dtype:mycontianer_t -v /SRC:/DEST =
IMAGE
>=20
> Or if=C2=A0 you must
>=20
> docker run -ti --security-opt label=3Dtype:mycontianer_t -v /SRC:/DEST =
IMAGE

I think it depends on your use-case.  If you want an OS-like privileged=20
container, then the current solution of having SELinux appear disabled in=
=20
the container is inadequate for many users.  It is also trivially possibl=
e=20
to access and modify global SELinux state from there.



--=20
James Morris
<jmorris@namei.org>

--1665246916-1963130981-1520546367=:20664--
