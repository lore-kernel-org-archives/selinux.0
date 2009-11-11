Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nABCFvMO010881
	for <selinux@tycho.nsa.gov>; Wed, 11 Nov 2009 07:15:57 -0500
Received: from ey-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nABCHuEj009408
	for <selinux@tycho.nsa.gov>; Wed, 11 Nov 2009 12:17:57 GMT
Received: by ey-out-1920.google.com with SMTP id 3so235265eyh.32
        for <selinux@tycho.nsa.gov>; Wed, 11 Nov 2009 04:15:54 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 11 Nov 2009 15:45:53 +0330
Message-ID: <bb74313d0911110415xf7e6ec7hb0986bf827aa837d@mail.gmail.com>
Subject: get security_class_t for objects
From: michel m <michel.mcgregor@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=00163602611062c3b204781763ab
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00163602611062c3b204781763ab
Content-Type: text/plain; charset=ISO-8859-1

Hi,
as an userspace object manager which uses libselinux, I am trying to use
avc_has_perm(3) for determining access decisions. when I open a file, I can
get its security context and change it to SID by using fgetfilecon(3) and
avc_context_to_sid(3), respectively. but when I want to have access decision
by calling avc_has_perm(3), I am not sure what to pass as the third
argument,that is security_class_t. I would like to know if there is any API
by which I can determine an already opened file`s class. may some one direct
me to a sample code please

Best regards.

--00163602611062c3b204781763ab
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br>as an userspace object manager which uses libselinux, I am trying to=
 use avc_has_perm(3) for determining access decisions. when I open a file, =
I can get its security context and change it to SID by using fgetfilecon(3)=
 and avc_context_to_sid(3), respectively. but when I want to have access de=
cision by calling avc_has_perm(3), I am not sure what to pass as the third =
argument,that is security_class_t. I would like to know if there is any API=
 by which I can determine an already opened file`s class. may some one dire=
ct me to a sample code please<br>
<br>Best regards.<br>

--00163602611062c3b204781763ab--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
