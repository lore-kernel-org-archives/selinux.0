Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0QLKl2L009253
	for <selinux@tycho.nsa.gov>; Tue, 26 Jan 2010 16:20:47 -0500
Received: from ey-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o0QLKjfI008867
	for <selinux@tycho.nsa.gov>; Tue, 26 Jan 2010 21:20:46 GMT
Received: by ey-out-1920.google.com with SMTP id 3so795924eyh.2
        for <selinux@tycho.nsa.gov>; Tue, 26 Jan 2010 13:20:44 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 27 Jan 2010 00:50:44 +0330
Message-ID: <bb74313d1001261320n8694abel857f6eba1066c560@mail.gmail.com>
Subject: access decision API
From: michel m <michel.mcgregor@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=00c09ffb4f5ed8213d047e17db8c
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00c09ffb4f5ed8213d047e17db8c
Content-Type: text/plain; charset=ISO-8859-1

Hi,
I have some data in userspace that I am keeping its security context.but as
I want to write this data on some file in OS, I need to consult with
security server if such data is allowed to be written on the file.
I would like to know if there is any API that let me do such a scenario,
that is input source and destination security context (both of them security
context,not a domain context) and returns access decision. I am familiar
with avc_has_perm(3), but seems to be not correct solution because it gets
domain context as the first argument.

Best regards.

--00c09ffb4f5ed8213d047e17db8c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br>I have some data in userspace that I am keeping its security context=
.but as I want to write this data on some file in OS, I need to consult wit=
h security server if such data is allowed to be written on the file.<br>
I would like to know if there is any API that let me do such a scenario, th=
at is input source and destination security context (both of them security =
context,not a domain context) and returns access decision. I am familiar wi=
th avc_has_perm(3), but seems to be not correct solution because it gets do=
main context as the first argument.<br>
<br>Best regards.<br>

--00c09ffb4f5ed8213d047e17db8c--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
