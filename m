Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1OHdU8J021064
 for <selinux@tycho.nsa.gov>; Fri, 24 Feb 2017 12:39:30 -0500
Received: by mail-yw0-f181.google.com with SMTP id p77so13005344ywg.1
 for <selinux@tycho.nsa.gov>; Fri, 24 Feb 2017 09:39:26 -0800 (PST)
MIME-Version: 1.0
From: Alex Klyubin <klyubin@google.com>
Date: Fri, 24 Feb 2017 17:39:12 +0000
Message-ID: <CALCgPKuwzCk5gfxxYsACyYZs_8X1rELNfXkaY5KfsFJ4VtO9oQ@mail.gmail.com>
Subject: Support for multiple types in typeattribute
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=94eb2c033afaf6003105494a35ec
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c033afaf6003105494a35ec
Content-Type: text/plain; charset=UTF-8

Hi,

typeattribute currently accepts only a single type as its first argument.
It associates the provided type with the attribute provided as the second
argument. Is there a reason why typeattribute doesn't support multiple
types specified as the first argument? The idea being that it would
associate each of those types with the attribute.

For example, the first argument to typeattribute could use the same syntax
as used for the first argument of allow and neverallow. typeattribute could
then expand this set of types, attributes, and exclusions into the set of
matching types and then associate each of the types with the provided
attribute.

The reason I'm asking is because in Android SELinux policy we're bumping
against the need to associate attribute A with the set of types which are
grouped using attribute G. We could add a typeattribute for each type
associated with G, but that (1) duplicates the grouping which is already
expressed via G, and (2) makes it very cumbersome/brittle to keep both A
and G associated with exactly the same set of types. In particular, because
Android SELinux policy source tree is distributed between a large number of
Android devices and organizations, requiring that any time you associate a
type with G you must also associate it with A is suboptimal, not to mention
that making such a change in the existing policies requires to change each
policy.

To make life more interesting, there's also a need to associate A with a
subset of G, for example, G minus some type or two.

Kind Regards,
Alex

--94eb2c033afaf6003105494a35ec
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>typeattribute currently accepts onl=
y a single type as its first argument. It associates the provided type with=
 the attribute provided as the second argument. Is there a reason why typea=
ttribute doesn&#39;t support multiple types specified as the first argument=
? The idea being that it would associate each of those types with the attri=
bute.</div><div><br></div><div>For example, the first argument to typeattri=
bute could use the same syntax as used for the first argument of allow and =
neverallow. typeattribute could then expand this set of types, attributes, =
and exclusions into the set of matching types and then associate each of th=
e types with the provided attribute.</div><div><br></div><div>The reason I&=
#39;m asking is because in Android SELinux policy we&#39;re bumping against=
 the need to associate attribute A with the set of types which are grouped =
using attribute G. We could add a typeattribute for each type associated wi=
th G, but that (1) duplicates the grouping which is already expressed via G=
, and (2) makes it very cumbersome/brittle to keep both A and G associated =
with exactly the same set of types. In particular, because Android SELinux =
policy source tree is distributed between a large number of Android devices=
 and organizations, requiring that any time you associate a type with G you=
 must also associate it with A is suboptimal, not to mention that making su=
ch a change in the existing policies requires to change each policy.</div><=
div><br></div><div>To make life more interesting, there&#39;s also a need t=
o associate A with a subset of G, for example, G minus some type or two.</d=
iv><div><br></div><div>Kind Regards,</div><div>Alex</div></div>

--94eb2c033afaf6003105494a35ec--
