Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8BCmY2X007617
	for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2009 08:48:34 -0400
Received: from mail-ew0-f206.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8BClr4H000968
	for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2009 12:47:54 GMT
Received: by ewy2 with SMTP id 2so1055889ewy.41
        for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2009 05:48:32 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 11 Sep 2009 14:41:18 +0200
Message-ID: <51af93b70909110541w1bef874h22931a6421388028@mail.gmail.com>
Subject: Policy file and Selinux Policy question
From: Elia Pinto <andronicus.spiros@gmail.com>
To: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
Content-Type: multipart/alternative; boundary=0016e6d6455cec754304734ca1dc
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016e6d6455cec754304734ca1dc
Content-Type: text/plain; charset=ISO-8859-1

In creating an selinux policy i can define the type of policy (strict,
targeted, MLS and a custom : e,g make NAME=selinuxvariant -f
/usr/share/selinux/devel/Makefile) to which the policy file has to be
applied.

But given  a policy file (policy.pp) as it is possible to understand via
some API interface at which policies the policy file relate ? In other
words, it is redundant to have the information elsewhere on the type of
policy to which the policy file you referring to? Also the information that
the policy file is a base or loadable policy is in policy file ? If yes, how
to inquiry via selinux API ?

Thanks a lot  in advance

--0016e6d6455cec754304734ca1dc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

In=A0creating an selinux policy=A0i can define the type of policy (strict, =
targeted, MLS and a custom : e,g make NAME=3Dselinuxvariant -f /usr/share/s=
elinux/devel/Makefile) to which the policy file has to be applied. <br><br>=
But given=A0 a policy file (policy.pp) as it is possible to understand via =
some API interface=A0at which=A0policies=A0the policy file relate ? In othe=
r words, it is redundant to have the information elsewhere on the type of p=
olicy to which the policy file you referring to? Also the information that =
the policy file is a base or loadable policy is in policy file ? If yes, ho=
w to inquiry via selinux API ?<br>
<br>Thanks a lot =A0in advance=20

--0016e6d6455cec754304734ca1dc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
