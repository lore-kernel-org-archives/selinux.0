Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9DBUaSo016415
	for <selinux@tycho.nsa.gov>; Tue, 13 Oct 2009 07:30:36 -0400
Received: from mail-ew0-f228.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9DBTisD028420
	for <selinux@tycho.nsa.gov>; Tue, 13 Oct 2009 11:29:44 GMT
Received: by ewy28 with SMTP id 28so3574780ewy.18
        for <selinux@tycho.nsa.gov>; Tue, 13 Oct 2009 04:30:34 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 13 Oct 2009 15:00:33 +0330
Message-ID: <bb74313d0910130430l3f9ff448p42efbcfba5c90d4e@mail.gmail.com>
Subject: what is http authenticated user?
From: michel m <michel.mcgregor@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=000e0cdf7632df75940475cf5f17
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000e0cdf7632df75940475cf5f17
Content-Type: text/plain; charset=ISO-8859-1

Hi,

in my last mail, I had asked how to get context for incoming requests.
meanwhile studying replies, I got familiar with apache/selinux plus which
labels threads based on identity of user. but I can not understand how users
are authenticated from http requests. who does this authentication ( is it a
service special to apache/httpd that analyzes http requests) ? I think, an
http request in normal form does not contain any information by which remote
user can be authenticated.

may some one explain me more or redirect me to some resources that clarify
things more?

Best regards.

--000e0cdf7632df75940475cf5f17
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>in my last mail, I had asked how to get context for incoming req=
uests. meanwhile studying replies, I got familiar with apache/selinux plus =
which labels threads based on identity of user. but I can not understand ho=
w users are authenticated from http requests. who does this authentication =
( is it a service special to apache/httpd that analyzes http requests) ? I =
think, an http request in normal form does not contain any information by w=
hich remote user can be authenticated.<br>
<br>may some one explain me more or redirect me to some resources that clar=
ify things more?<br><br>Best regards.<br>

--000e0cdf7632df75940475cf5f17--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
