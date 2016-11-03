MIME-Version: 1.0
From: Naina Emmanuel <nemmanuel1992@gmail.com>
Date: Thu, 3 Nov 2016 05:50:59 -0700
Message-ID: <CAN=9EoTd3w=FVCAYSGRujAZyeosP5GtieSC=YOP-SpfSQOb5=g@mail.gmail.com>
Subject: selinux user to linux mapping
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 Daniel J Walsh <dwalsh@redhat.com>, Vit Mojzis <vmojzis@redhat.com>
Cc: Anas Tariq <anas.tariq1995@gmail.com>, masoom alam <masoom.alam@gmail.com>
Content-Type: multipart/alternative; boundary=001a114331886fb1d60540650203
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114331886fb1d60540650203
Content-Type: text/plain; charset=UTF-8

Good Evening,
I am assigning roles to customized users,roles have been created fine, I am
facing problem in assigning this role to Linux account.
using the command for assigning mailadm(role) to SELinux user
*root #semanage user -a -R "mailadm_r system_r *

But when I map this SELinux user to Linux user through
*root #semanage login -a -s mailadm_u user1234*
Getting error:

libsemanage.dbase_llist_query: could not query record value

ValueError: Could not query user for mailadm_u


Help in this regard

thanks

*Engr. Naina Emmanuel*
*Cryptography Certified*
*Linux Essential Certified (LEPDC)*
*Cisco Certified Network Associate (CCNA)*

*Computer Engineering Department, UET Taxila*

*Information Security, CS Department, CIIT Islamabad*

--001a114331886fb1d60540650203
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div class=3D"gmail_signature"><div dir=3D"ltr"><div =
dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"=
ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div><font size=3D"=
4">Good Evening,</font></div><div>I am assigning roles to customized users,=
roles have been created fine, I am facing problem in assigning=C2=A0this ro=
le to Linux account.</div><div>using the command for assigning=C2=A0mailadm=
(role) to SELinux user</div><div><b>root #semanage user -a -R &quot;mailadm=
_r system_r=C2=A0</b></div><div><b><br></b></div><div>But when I map this S=
ELinux=C2=A0user to Linux user through</div><b>root #semanage login -a -s m=
ailadm_u user1234</b></div><div>Getting error:</div><div><pre class=3D"gmai=
l-bz_comment_text gmail-bz_wrap_comment_text" style=3D"white-space:pre-wrap=
;word-wrap:break-word;width:50em;color:rgb(0,0,0)">libsemanage.dbase_llist_=
query: could not query record value</pre><pre class=3D"gmail-bz_comment_tex=
t gmail-bz_wrap_comment_text" style=3D"white-space:pre-wrap;word-wrap:break=
-word;width:50em;color:rgb(0,0,0)">ValueError: Could not query user for mai=
ladm_u</pre><pre class=3D"gmail-bz_comment_text gmail-bz_wrap_comment_text"=
 style=3D"white-space:pre-wrap;word-wrap:break-word;width:50em;color:rgb(0,=
0,0)"><br></pre><pre class=3D"gmail-bz_comment_text gmail-bz_wrap_comment_t=
ext" style=3D"white-space:pre-wrap;word-wrap:break-word;width:50em;color:rg=
b(0,0,0)"><font face=3D"arial, helvetica, sans-serif">Help in this regard</=
font></pre><pre class=3D"gmail-bz_comment_text gmail-bz_wrap_comment_text" =
style=3D"white-space:pre-wrap;word-wrap:break-word;width:50em;color:rgb(0,0=
,0)"><font face=3D"arial, helvetica, sans-serif">thanks</font></pre></div><=
div dir=3D"ltr"><font size=3D"4"><font color=3D"#666666" style=3D"font-weig=
ht:bold"><i>Engr. Naina Emmanuel</i></font></font></div><div dir=3D"ltr"><d=
iv><b style=3D"color:rgb(102,102,102);font-size:small">Cryptography Certifi=
ed</b></div><div><b style=3D"color:rgb(102,102,102);font-size:small">Linux =
Essential Certified (LEPDC)</b><font color=3D"#666666" size=3D"2"><b><br></=
b></font></div><div><font color=3D"#666666" size=3D"2"><b>Cisco Certified N=
etwork Associate (CCNA)</b></font></div><div><b style=3D"color:rgb(102,102,=
102);font-size:small">Computer Engineering Department, UET Taxila<br></b></=
div><div><b style=3D"color:rgb(102,102,102);font-size:small">Information Se=
curity, CS Department, CIIT Islamabad<br></b></div></div></div></div></div>=
</div></div></div></div></div></div></div>
</div>

--001a114331886fb1d60540650203--
