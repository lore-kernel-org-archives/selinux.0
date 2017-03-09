Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v299guJv018061
 for <selinux@tycho.nsa.gov>; Thu, 9 Mar 2017 04:42:56 -0500
Received: by mail-ua0-f179.google.com with SMTP id f54so68476444uaa.1
 for <selinux@tycho.nsa.gov>; Thu, 09 Mar 2017 01:42:28 -0800 (PST)
MIME-Version: 1.0
From: Kashif ali <kashif.ali.9498@gmail.com>
Date: Thu, 9 Mar 2017 14:42:26 +0500
Message-ID: <CAFC8oae8pRwr3B320jPszPpWy0QysuaQ3=UYEzKWhowrP6gEvw@mail.gmail.com>
Subject: Custom Process Label (SElinux)
To: Daniel J Walsh <dwalsh@redhat.com>,
 Sebastiaan van Stijn <sebastiaan.vanstijn@docker.com>,
 SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a114f4e2e17fea0054a4910e0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114f4e2e17fea0054a4910e0
Content-Type: text/plain; charset=UTF-8

Hi,
  i have created a module for my custom service with seplogen command it
has generated the policy module for my custom service and context for its
/usr/bin/mycustomeservicedaemon which is custom_service_exec_t when i run
my service it doesn't get the label of  custom_service_t where as it has
the label of init_t so thats mean that the proper domain transition is not
available or there is something which is i'm missing.
Kindly reply me as soon i'm stuck in it.

Thanks
Regards
Kashif Ali

--001a114f4e2e17fea0054a4910e0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,=C2=A0<br>=C2=A0 i have created a module for my custom =
service with seplogen command it has generated the policy module for my cus=
tom service and context for its /usr/bin/mycustomeservicedaemon which is cu=
stom_service_exec_t when i run my service it doesn&#39;t get the label of =
=C2=A0custom_service_t where as it has the label of init_t so thats mean th=
at the proper domain transition is not available or there is something whic=
h is i&#39;m missing.<br>Kindly reply me as soon i&#39;m stuck in it.<br><b=
r>Thanks=C2=A0<br>Regards=C2=A0<br>Kashif Ali</div>

--001a114f4e2e17fea0054a4910e0--
