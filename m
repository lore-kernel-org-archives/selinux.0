Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0QCLKjT003609
	for <selinux@tycho.nsa.gov>; Tue, 26 Jan 2010 07:21:20 -0500
Received: from mail-ew0-f214.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o0QCLJsx016747
	for <selinux@tycho.nsa.gov>; Tue, 26 Jan 2010 12:21:19 GMT
Received: by ewy6 with SMTP id 6so3577820ewy.34
        for <selinux@tycho.nsa.gov>; Tue, 26 Jan 2010 04:21:15 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 26 Jan 2010 15:51:14 +0330
Message-ID: <bb74313d1001260421o160fec25qc7bc45ff6f6bda7c@mail.gmail.com>
Subject: incoming packets` context
From: michel m <michel.mcgregor@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=000e0ce0d602768841047e1052d9
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0ce0d602768841047e1052d9
Content-Type: text/plain; charset=ISO-8859-1

Hi,
as I noticed, getpeercon() API allows me to have domain of the peer
connection, but packets received have their own security context which are
set by iptable rules on the peer side. how can I get arriving packets`
context using libselinux?

--000e0ce0d602768841047e1052d9
Content-Type: text/html; charset=ISO-8859-1

Hi,<br>as I noticed, getpeercon() API allows me to have domain of the peer connection, but packets received have their own security context which are set by iptable rules on the peer side. how can I get arriving packets` context using libselinux?<br>
<br>

--000e0ce0d602768841047e1052d9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
