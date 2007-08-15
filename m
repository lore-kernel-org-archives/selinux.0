Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7FE62qm009159
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 10:06:02 -0400
Received: from mu-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7FE619K016331
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 14:06:01 GMT
Received: by mu-out-0910.google.com with SMTP id i10so3047614mue
        for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 07:06:00 -0700 (PDT)
Message-ID: <f71a82820708150706x77f4102csdc67a24251f32f28@mail.gmail.com>
Date: Wed, 15 Aug 2007 23:06:00 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: patch certwatch.if
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_47083_23092370.1187186760062"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_47083_23092370.1187186760062
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I think, interface certwatach_run should be fixed,
in 20070629 refpolicy.
It should be certwatch_run and not certwatach_run.
Thank you.

------=_Part_47083_23092370.1187186760062
Content-Type: text/x-patch; name=certwatch.if.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f5dwd06e
Content-Disposition: attachment; filename="certwatch.if.patch"

NDdjNDcKPCBpbnRlcmZhY2UoYGNlcnR3YXRhY2hfcnVuJyxgCi0tLQo+IGludGVyZmFjZShgY2Vy
dHdhdGNoX3J1bicsYAo=
------=_Part_47083_23092370.1187186760062--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
