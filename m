Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBLLsNRb019407
	for <selinux@tycho.nsa.gov>; Sun, 21 Dec 2003 16:54:23 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBLLsLpn019432
	for <selinux@tycho.nsa.gov>; Sun, 21 Dec 2003 21:54:22 GMT
Received: from zaphod.crypt.gen.nz (218-101-46-111.paradise.net.nz [218.101.46.111])
        by jazzband.ncsc.mil  with ESMTP id hBLLsKab019429 for <selinux@tycho.nsa.gov>; Sun, 21 Dec 2003 21:54:21 GMT
Message-ID: <2407.202.27.185.71.1072043647.squirrel@www.crypt.gen.nz>
In-Reply-To: <20031219195045.4425635f.ynakam@ori.hitachi-sk.co.jp>
References: 
    <20031215190237.4f459090.ynakam@ori.hitachi-sk.co.jp><1071503117.28044.76.camel@moss-spartans.epoch.ncsc.mil><20031216133940.568e9795.ynakam@ori.hitachi-sk.co.jp><1071688353.1403.137.camel@moss-spartans.epoch.ncsc.mil>
    <20031219195045.4425635f.ynakam@ori.hitachi-sk.co.jp>
Date: Mon, 22 Dec 2003 10:54:07 +1300 (NZDT)
Subject: Re: Apache on FedoraCore1(Was Re: log_domain macro)
From: "Kerry Thompson" <kerry@crypt.gen.nz>
To: "Yuichi Nakamura" <ynakam@ori.hitachi-sk.co.jp>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yuichi Nakamura said:

> (3)
> I defined new type krb5_conf_t for /etc/krb5.conf
> because write access to /etc/krb5.conf was denied.
> However, Apache worked when access to /etc/krb5.conf is denied.
> So,"allow httpd_t krb5_conf_t:file rw_file_perms;" is commented out now.
>

PAM ( and others ) make calls to the kerberos library which will always
open /etc/krb5.conf in r/w mode, even though no apps should be writing to
it. I suggest allowing read from all, and dontaudit for write.

Kerry


-- 
Kerry Thompson, CCNA CISSP
Information Systems Security Consultant
http://www.crypt.gen.nz  kerry@crypt.gen.nz

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
