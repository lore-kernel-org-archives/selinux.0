Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8KMP141023322
	for <selinux@tycho.nsa.gov>; Sun, 20 Sep 2009 18:25:01 -0400
Received: from mail-ew0-f206.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8KMQRuq015026
	for <selinux@tycho.nsa.gov>; Sun, 20 Sep 2009 22:26:28 GMT
Received: by ewy2 with SMTP id 2so594150ewy.41
        for <selinux@tycho.nsa.gov>; Sun, 20 Sep 2009 15:24:59 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 21 Sep 2009 00:24:59 +0200
Message-ID: <51af93b70909201524j3993091ajaeaf42924d67ea6b@mail.gmail.com>
Subject: Naive question on ftp selinux policy
From: Elia Pinto <andronicus.spiros@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0016e6d99a21e6e609047409d50f
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016e6d99a21e6e609047409d50f
Content-Type: text/plain; charset=ISO-8859-1

A trivial question. There is some reason why the SELinux ref policy provides
only for ftp access to users' home or to a type accessible to other demons
confined? Why it is not possible to define a ftp_data_t also ? The
motivation is simple : whay i have to provide ftp access AND also permit
other daemon to access ? IMHO, it is not the best as Least privilege.

Thanks in advance

--0016e6d99a21e6e609047409d50f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>A trivial question. There is some reason why the SELinux ref policy pr=
ovides only for ftp access to users&#39; home or to a type accessible to ot=
her demons confined? Why it is not possible to define a ftp_data_t also ? T=
he motivation is simple : whay i have to provide ftp access AND also permit=
 other daemon to access ? IMHO, it is not=A0the best as Least privilege.</d=
iv>

<div>=A0</div>
<div>Thanks in advance</div>
<div>=A0</div>
<div>=A0</div>

--0016e6d99a21e6e609047409d50f--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
