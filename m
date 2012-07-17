Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6HNhJ9n030921
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2012 19:43:19 -0400
Received: by ggnv5 with SMTP id v5so1081400ggn.12
        for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2012 16:43:18 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 17 Jul 2012 16:43:17 -0700
Message-ID: <CAFftDdrefoeyaFQsr-OXQdAXU9CRgvqbMg+gZ+WUEuRnb2dfEQ@mail.gmail.com>
Subject: Change-Id: I61d34a9fd6975f23023f70f205a510e3357d843c
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: rpcraig <rpcraig@tycho.ncsc.mil>
Content-Type: multipart/alternative; boundary=f46d042fddc65d807f04c50f1c2d
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d042fddc65d807f04c50f1c2d
Content-Type: text/plain; charset=ISO-8859-1

I think we need to discuss this change id further.
Commit sha b263780156624c38b23d638be6a2d8bdd17511f8 on master
selinuxproject/master.

It really provides two functions:

1. x.509 cert to seinfo string mapping for seapp_contexts so the zygote
spawns it in the right domain...
2. install time permission checking

I think these should be submitted as two different patch sets to AOSP
respective of their functionality. I think the x.509 cert checks will get
pulled in and I am not sure on the install time permission checking.

I am also wondering if we really need mac_permisions.xml to be in in it's
own repo. I think it should be in sepolicy since it is part of the policy
of the device, like seapp_contexts.

What are the communities opinions on these comments?

-- 
Respectfully,

William C Roberts

--f46d042fddc65d807f04c50f1c2d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I think we need to discuss this change id further.<div>Commit sha b26378015=
6624c38b23d638be6a2d8bdd17511f8 on master selinuxproject/master.<div><br></=
div><div>It really provides two functions:<div><br></div><div>1. x.509 cert=
 to seinfo string mapping for seapp_contexts so the zygote spawns it in the=
 right domain...</div>
<div>2. install time permission checking</div><div><br></div><div>I think t=
hese should be submitted as two different patch sets to AOSP respective of =
their functionality. I think the x.509 cert checks will get pulled in and I=
 am not sure on the install time permission checking.</div>
<div><br></div><div>I am also wondering if we really need mac_permisions.xm=
l to be in in it&#39;s own repo. I think it should be in sepolicy since it =
is part of the policy of the device, like seapp_contexts.</div><div><br>
</div><div>What are the communities opinions on these comments?</div><div><=
div><br></div>-- <br>Respectfully,<br><br>William C Roberts<br><br><br>
</div></div></div>

--f46d042fddc65d807f04c50f1c2d--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
