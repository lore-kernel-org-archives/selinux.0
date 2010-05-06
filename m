Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o466PHh7011505
	for <selinux@tycho.nsa.gov>; Thu, 6 May 2010 02:25:17 -0400
Received: from mail-qy0-f194.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o466OfTx022954
	for <selinux@tycho.nsa.gov>; Thu, 6 May 2010 06:24:41 GMT
Received: by qyk32 with SMTP id 32so9278202qyk.0
        for <selinux@tycho.nsa.gov>; Wed, 05 May 2010 23:25:16 -0700 (PDT)
MIME-Version: 1.0
From: waqar afridi <afridi.waqar@gmail.com>
Date: Thu, 6 May 2010 11:24:55 +0500
Message-ID: <y2n78aaeffc1005052324g38e6173pc71674e3a523e670@mail.gmail.com>
Subject: Broken pipe Error
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0016364eee107524c70485e7012e
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016364eee107524c70485e7012e
Content-Type: text/plain; charset=ISO-8859-1

Hello All

I am trying to Cross compile *checkmodules* for arm architecture but
whenever I do, I get the Following Error

#make checkmodule

bison -y -d policy_parse.y
make: *** [y.tab.c] Broken pipe

btw I have also tried yacc but results were the Same, Any Idea?

Thanx in Advance...

-- 
Waqar Afridi

--0016364eee107524c70485e7012e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello All<br><br>I am trying to Cross compile <b>checkmodu=
les</b> for arm architecture but whenever I do, I get the Following Error<b=
r><br>#make checkmodule<br><br>bison -y -d policy_parse.y<br>make: *** [y.t=
ab.c] Broken pipe<br>

=A0<br clear=3D"all">btw I have also tried yacc but results were the Same, =
Any Idea?<br><br>Thanx in Advance...<br><br>-- <br>Waqar Afridi<br><br></di=
v>

--0016364eee107524c70485e7012e--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
