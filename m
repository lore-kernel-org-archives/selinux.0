MIME-Version: 1.0
From: Elena Reshetova <elena.reshetova@gmail.com>
Date: Mon, 26 Oct 2015 11:20:44 +0000
Message-ID: <CALrft9-5ZFbJgiLZnXoeroAgqhZ+rmzCENXSgdqtyC5+_6pZ-w@mail.gmail.com>
Subject: setoolsv4: tracking origin of a policy element
To: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Cc: "filippo.bonazzi@aalto.fi" <filippo.bonazzi@aalto.fi>,
 William Roberts <bill.c.roberts@gmail.com>
Content-Type: multipart/alternative; boundary=001a11c3483089c37b0523002708
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c3483089c37b0523002708
Content-Type: text/plain; charset=UTF-8

Hi,

While looking into the policy parser from setools v4, we noticed one thing
that is missing: origin of a policy element. For example, given a certain
rule or attribute, it would be great to know in what source file it was
defined.

In Android you can find this information by looking at produced policy.conf
and its comment lines that indicate source file. However I don't know if it
is the same for desktop selinux policy.

Would it be acceptable to have this information as part of python class
representing the parsed policy? It would be really useful for tools like
policy linter, because it would be very much needed to point to the exact
file where some improvements might be desirable.

Best Regards,
Elena.

--001a11c3483089c37b0523002708
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Hi,<br><br></div>While looking in=
to the policy parser from setools v4, we noticed one thing that is missing:=
 origin of a policy element. For example, given a certain rule or attribute=
, it would be great to know in what source file it was defined. <br><br></d=
iv>In Android you can find this information by looking at produced policy.c=
onf and its comment lines that indicate source file. However I don&#39;t kn=
ow if it is the same for desktop selinux policy. <br><br></div>Would it be =
acceptable to have this information as part of python class representing th=
e parsed policy? It would be really useful for tools like policy linter, be=
cause it would be very much needed to point to the exact file where some im=
provements might be desirable. <br><br></div>Best Regards,<br></div>Elena.<=
br></div>

--001a11c3483089c37b0523002708--
