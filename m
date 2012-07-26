MIME-Version: 1.0
Date: Thu, 26 Jul 2012 14:25:39 -0700
Message-ID: <CAO-4OdGJhr3H7Q8uJz0JWgEekHqo=K8gS3aU_si__f4y5dzPxQ@mail.gmail.com>
Subject: Could we set them as "mlstrustedsubject"?
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        William Roberts <bill.c.roberts@gmail.com>
Content-Type: multipart/alternative; boundary=f46d0401730bb4cf0204c5c23cdd
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d0401730bb4cf0204c5c23cdd
Content-Type: text/plain; charset=ISO-8859-1

Hi, all

Currently I am testing Android CTS in SEAndroid. I find several denials are
related to MLS constraints. The key-signed apps, like "platform_app",
"release_app",
"browser_app", "shared_app" and "media_app", need to open app_data_file.
But because of MLS, they cannot do that. So, could we sign them as
mlstrusted?
Currently only daemons are set "mlstrustedsubject". Do you have any ideas?
Or the better solutions to solve the denials?

Thanks,

-- 
-----------------------------------
Haiqing Jiang, PH.D student

Computer Science Department, North Carolina State University

--f46d0401730bb4cf0204c5c23cdd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, all<div><br></div><div>Currently I am testing Android CTS in SEAndroid.=
 I find several denials are related to MLS constraints. The key-signed apps=
, like &quot;platform_app&quot;, &quot;release_app&quot;,</div><div>&quot;b=
rowser_app&quot;, &quot;shared_app&quot; and &quot;media_app&quot;, need to=
 open app_data_file. But because of MLS, they cannot do that. So, could we =
sign them as mlstrusted?=A0</div>
<div>Currently only daemons are set &quot;mlstrustedsubject&quot;. Do you h=
ave any ideas? Or the better solutions to solve the denials?=A0</div><div><=
br></div><div>Thanks,<br clear=3D"all"><div><br></div>-- <br><div>---------=
--------------------------</div>
Haiqing Jiang, PH.D student<div><br></div><div>Computer Science Department,=
 North Carolina State University<br><div><br></div></div><br>
</div>

--f46d0401730bb4cf0204c5c23cdd--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
