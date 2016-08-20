MIME-Version: 1.0
From: Kashif ali <kashif.ali.9498@gmail.com>
Date: Fri, 19 Aug 2016 17:54:42 -0700
Message-ID: <CAFC8oadn76ZLU2T0BAJyrceAzuVAtB+Yincvt7m7=29kbOrFNg@mail.gmail.com>
Subject: (How to ) Change the context of user
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=94eb2c1244b6a88ed1053a7642df
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c1244b6a88ed1053a7642df
Content-Type: text/plain; charset=UTF-8

Hi
  * I'm facing a problem while changing the context of root user in
selinux, Selinux is in enforced and targeted policy. By default Selinux
assign user =>"unconfined_u:unconfiend_r:unconfined_t:"
context for the user i have changed the selinux mapped root user
"unconifined_u" into "system_u" for root user with the help of command
=>"semanage login -a -s system_u root"
after executing this command the root user context is changed into
"system_u:unconfined_r:unconfined_t:".

* Now i have changed the root user role and domain type so i execute this
command
=>"newrole -r system_r -t initrc_t:"
and change the root user context into "system_u:system_r:initrc_t:" but
this change is temporary after rebooting the system the context of root
user is changed back to "system_u:unconfined_r:unconfined_t:"

* what i need is to change the root user context permanently into
"system_u:system_r:initrc_t:".

--94eb2c1244b6a88ed1053a7642df
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div>=C2=A0 * I&#39;m facing a problem while changing th=
e context of root user in selinux, Selinux is in enforced and targeted poli=
cy. By default Selinux assign user =3D&gt;&quot;unconfined_u:unconfiend_r:u=
nconfined_t:&quot;=C2=A0</div><div>context for the user i have changed the =
selinux mapped root user &quot;unconifined_u&quot; into &quot;system_u&quot=
; for root user with the help of command=C2=A0</div><div>=3D&gt;&quot;seman=
age login -a -s system_u root&quot;=C2=A0</div><div>after executing this co=
mmand the root user context is changed into &quot;system_u:unconfined_r:unc=
onfined_t:&quot;.</div><div><br></div><div>* Now i have changed the root us=
er role and domain type so i execute this command=C2=A0</div><div>=3D&gt;&q=
uot;newrole -r system_r -t initrc_t:&quot;=C2=A0</div><div>and change the r=
oot user context into &quot;system_u:system_r:initrc_t:&quot; but this chan=
ge is temporary after rebooting the system the context of root user is chan=
ged back to &quot;system_u:unconfined_r:unconfined_t:&quot;</div><div><br><=
/div><div>* what i need is to change the root user context permanently into=
 &quot;system_u:system_r:initrc_t:&quot;.</div><div><br></div></div>

--94eb2c1244b6a88ed1053a7642df--
