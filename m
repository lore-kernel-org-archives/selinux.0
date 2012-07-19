MIME-Version: 1.0
Date: Wed, 18 Jul 2012 18:28:02 -0700
Message-ID: <CAFftDdoGP=DTE7Z+y3haF=7FtKZ6iopDBxMctUZ2-NzzSRBB_A@mail.gmail.com>
Subject: seapp_contexts boolean support
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=f46d042fddc6d0a9fa04c524b08b
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d042fddc6d0a9fa04c524b08b
Content-Type: text/plain; charset=ISO-8859-1

I was thinking of adding support to enable seboolean control over
seapp_contexts. We have had to make a weird change to seapp_contexts for
CTS and it would be nice if that only got pulled in and used when the CTS
boolean is enabled.

I was thinking is could work like this:

seapp_contexts would have an additional option, sebool, you could set this
to the name of the seboolean, such as CTS.

When the code that parses the seapp_contexts file
(selinux_android_setcontext) could check the sebool flag first, and if it
matches, apply the existing rules to it, else, throw it away as a possible
match.

Would anyone find this useful, and if so I can code it up tomorrow after I
submit the Settings app patches to Garrett.

-- 
Respectfully,

William C Roberts

--f46d042fddc6d0a9fa04c524b08b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I was thinking of adding support to enable seboolean control over seapp_con=
texts. We have had to make a weird change to seapp_contexts for CTS and it =
would be nice if that only got pulled in and used when the CTS boolean is e=
nabled.<div>
<br></div><div>I was thinking is could work like this:</div><div><br></div>=
<div>seapp_contexts would have an additional option, sebool, you could set =
this to the name of the seboolean, such as CTS.</div><div><br></div><div>
When the code that parses the seapp_contexts file (selinux_android_setconte=
xt) could check the sebool flag first, and if it matches, apply the existin=
g rules to it, else, throw it away as a possible match.</div><div><br></div=
>
<div>Would anyone find this useful, and if so I can code it up=A0tomorrow=
=A0after I submit the Settings app patches to Garrett.<br clear=3D"all"><di=
v><br></div>-- <br>Respectfully,<br><br>William C Roberts<br><br><br>
</div>

--f46d042fddc6d0a9fa04c524b08b--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
