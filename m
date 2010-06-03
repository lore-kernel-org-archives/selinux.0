Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o53GSWYo020996
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2010 12:28:32 -0400
Received: from n28.bullet.mail.ukl.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id o53GTtZ1006808
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2010 16:29:56 GMT
Message-ID: <289557.20002.qm@web87003.mail.ird.yahoo.com>
Date: Thu, 3 Jun 2010 09:28:28 -0700 (PDT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Non-Computing Abstractions & An Issue Thereof
To: Joshua Kramer <josh@globalherald.net>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2003194508-1275582508=:20002"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-2003194508-1275582508=:20002
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

I've modified your module to compile and added a few notes - HOWEVER it doe=
s get a bit complicated as you need to add your new object classes and perm=
issions to the base policy (as explained in the various emails).=20

I've attached a tarball with sample files and a README. If you want, try th=
ese but of course you will not be able to enforce any policy but at least
it compiles.

Both examples in the README use information from the SELinux Notebook at:
http://www.freetechbooks.com/the-selinux-notebook-the-foundations-t785.html

One is based on a simple policy and the other on the Fedora 12 targeted ref=
erence policy.

Richard

--- On Sat, 29/5/10, Joshua Kramer <josh@globalherald.net> wrote:

> From: Joshua Kramer <josh@globalherald.net>
> Subject: Non-Computing Abstractions & An Issue Thereof
> To: "SE Linux" <selinux@tycho.nsa.gov>
> Date: Saturday, 29 May, 2010, 22:40
> Hello,
>=20
> I am trying to wrap my head around using SELinux to secure
> data objects in userspace.=A0 My learning style suggests
> that for a topic like this, I abstract the theory away from
> how it's actually implemented in software.=A0 To those
> ends, I have created the type enforcement file attached to
> this email, that loosely models the behavior of teams of
> sled dogs using SELinux.
>=20
> When I try to install the policy using these commands:
>=20
> checkmodule -M -m -o seSledDogs.mod seSledDogs.te
> semodule_package -o seSledDogs.pp -m seSledDogs.mod
> semodule -i ./seSledDogs.pp
>=20
> ...I get this error from semodule:
>=20
> libsepol.print_missing_requirements: seSledDogs's global
> requirements were not met: role dog_owner_r (No such file or
> directory).
> libsemanage.semanage_link_sandbox: Link packages failed (No
> such file or directory).
> semodule:=A0 Failed!
>=20
> If I comment out the roles, I get a similar message about
> the types:
>=20
> libsepol.print_missing_requirements: seSledDogs's global
> requirements were not met: type/attribute medicine_t (No
> such file or directory).
> libsemanage.semanage_link_sandbox: Link packages failed (No
> such file or directory).
> semodule:=A0 Failed!
>=20
> Where do I need to be defining these roles and types?=A0
> I was under the impression that the te files were
> self-contained.
>=20
> Thanks!
> -Joshua Kramer
>=20
>=20
>
--0-2003194508-1275582508=:20002
Content-Type: application/x-gzip; name="SledDogs.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="SledDogs.tar.gz"

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
T9QhhosAoAAA

--0-2003194508-1275582508=:20002--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
