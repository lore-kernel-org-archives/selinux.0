Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7NJZV4u018247
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 15:35:31 -0400
Received: from mail-yw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7NJZUwo017433
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 19:35:30 GMT
Received: by ywb5 with SMTP id 5so455931ywb.12
        for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 12:35:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OF18D472F9.0451EEBF-ON852578F4.00654DC8-852578F4.006779B2@symcor.com>
References: <OF18D472F9.0451EEBF-ON852578F4.00654DC8-852578F4.006779B2@symcor.com>
Date: Tue, 23 Aug 2011 15:35:28 -0400
Message-ID: <CACLa4psLVs8Unj3RdjFkycWVS5y_KTeMYuriNwCP=+OrkPxC0w@mail.gmail.com>
Subject: Re: SELinux+IPTables+Non SELINUX Aware Network Daemon
From: Eric Paris <eparis@parisplace.org>
To: GProcunier@symcor.com
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=20cf301d420a46919f04ab314ced
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf301d420a46919f04ab314ced
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Nobody jumped in so I'll answer you.  The answer is that no, you cannot do
this with what you have today as you describe it.  SELinux can be used to
control what IP addresses tgtd is allowed to talk to.  It can also control
what block devices tgtd is allowed to talk to.  But SELinux does not have a
way to tie an IP address to a block device.  That information cannot be
magically transferred through the tgtd daemon.  Lets say we have

Hosts: 1, 2, and 3
Block devices: hda, hdb, and hdc

If I understand your situation correctly a similar example might be summed
up as follows.  You want Host 1 to ONLY be allowed to use block device hda.
 You want host 2 to ONLY be allowed to use block device hdb.  You do not
want tgtd to talk to host3.  You do not want anything to use hdc.

We can write iptables labeling rules and policy which only grants tgtd the
ability to talk to host1 and host2.  We can write policy rules which would
only give tgtd access to hda and hdb.  What we cannot do is control if host=
1
tries to mount and use hdb.  We don't have a way to get that information
through the tgtd program.  Think of tgtd as a black box.  SELinux can
control what comes in and out of the box, but once inside it can't do
anything about it.

              ----------
host 1 <---> |          | <---> hda
host 2 <---> |   TGTD   | <---> hdb
host 3 <---X |          | X---> hdc
              ----------

We can control the that boundary between host 3 and tgtd or between tgtd an=
d
hdc.  But if we let both hda and hdb talk to tgtd and we let both host1 and
host2 talk to tgtd we cannot control if tgtd allows host1 to get informatio=
n
from hdb.  We can't control what happens INSIDE the black box.  Now, if you
can come up with a way to run 2 copies of tgtd, so you have 2 black boxes,
that could be made to work.  Otherwise you are going to have to change tgtd
to implement the controls you seek....

Make sense?

2011/8/22 <GProcunier@symcor.com>

> Greetings,
>
> I was recently reading this article about leveraging iptables with SELinu=
x
> :
>
>
> https://www.linux.com/learn/tutorials/421152-using-selinux-and-iptables-t=
ogether
>
> I was wondering if a similar union could allow for the following situatio=
n
> to be accomplished:
>
> I have a Red Hat Enterprise Linux 6.1 server sharing several storage LUNs
> as iSCSI targets via the native iSCSI target implementation in that
> distribution.  For technical reasons several of the LUNs must be exported
> without CHAP authentication however I was wondering if I could leverage
> iptables secmark in conjunction with SELinux to accomplish the following:
>
> 1) Client IP connects to the iSCSI target service.  Connection is tracked
> and secmark'd.
> 2) Client IP discovers available LUNs on the iSCSI server
> 3) Client IP logs into a LUN which has an source address access rule
> preventing access.
> 4) When the iSCSI target service tries to access the LUN to which the
> Client IP has no access, IPtables severs the connection via TCP reset /
> reject.
>
> As far as I can tell "tgtd" (the iSCSI target daemon) neither supports IP
> acl's or is SELinux aware, however I was hoping there might be a way to
> create an association between connecting ip / process ID on the server an=
d
> file/block device access such that I could use IPtables to terminate the
> unauthorized connection.
>
> If anyone has any thoughts on if this would be possible in one way or
> another I would love to hear about it.
>
> Cheers,
>
> --
>
> *Greg Procunier*
> *UNIX Administrator III - Enterprise Servers and Storage*
> 1 Robert Speck Parkway, Suite 400, Mississauga, Ontario L4Z 4E7
> Office: 416-673-3320
> Mobile: 647-895-2977
> Email: gprocunier@symcor.com
>
>
> CONFIDENTIALITY WARNING
> This communication, including any attachments, is for the exclusive use o=
f
> addressee and may contain proprietary and/or confidential information. If
> you are not the intended recipient, any use, copying, disclosure,
> dissemination or distribution is strictly prohibited. If you are not the
> intended recipient, please notify the sender immediately by return e-mail=
,
> delete this communication and destroy all copies.
>
> AVERTISSEMENT RELATIF =C0 LA CONFIDENTIALIT=C9
> Ce message, ainsi que les pi=E8ces qui y sont jointes, est destin=E9 =E0 =
l=92usage
> exclusif de la personne =E0 laquelle il s=92adresse et peut contenir de
> l=92information personnelle ou confidentielle. Si le lecteur de ce messag=
e
> n=92en est pas le destinataire, nous l=92avisons par la pr=E9sente que to=
ute
> diffusion, distribution, reproduction ou utilisation de son contenu est
> strictement interdite. Veuillez avertir sur-le-champ l=92exp=E9diteur par=
 retour
> de courrier =E9lectronique et supprimez ce message ainsi que toutes les p=
i=E8ces
> jointes.
>
>

--20cf301d420a46919f04ab314ced
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Nobody jumped in so I&#39;ll answer you. =A0The answer is that no, you cann=
ot do this with what you have today as you describe it. =A0SELinux can be u=
sed to control what IP addresses tgtd is allowed to talk to. =A0It can also=
 control what block devices tgtd is allowed to talk to. =A0But SELinux does=
 not have a way to tie an IP address to a block device. =A0That information=
 cannot be magically transferred through the tgtd daemon. =A0Lets say we ha=
ve<div>
<br></div><div>Hosts: 1, 2, and 3</div><div>Block devices: hda, hdb, and hd=
c</div><div><br></div><div>If I understand your situation correctly a simil=
ar example might be summed up as follows. =A0You want Host 1 to ONLY be all=
owed to use block device hda. =A0You want host 2 to ONLY be allowed to use =
block device hdb. =A0You do not want tgtd to talk to host3. =A0You do not w=
ant anything to use hdc.</div>
<div><br></div><div>We can write iptables labeling rules and policy which o=
nly grants tgtd the ability to talk to host1 and host2. =A0We can write pol=
icy rules which would only give tgtd access to hda and hdb. =A0What we cann=
ot do is control if host1 tries to mount and use hdb. =A0We don&#39;t have =
a way to get that information through the tgtd program. =A0Think of tgtd as=
 a black box. =A0SELinux can control what comes in and out of the box, but =
once inside it can&#39;t do anything about it.</div>
<div><br></div><div><div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 ----------</div><=
div>host 1 &lt;---&gt; | =A0 =A0 =A0 =A0 =A0| &lt;---&gt; hda</div><div>hos=
t 2 &lt;---&gt; | =A0 TGTD =A0 | &lt;---&gt; hdb</div><div>host 3 &lt;---X =
| =A0 =A0 =A0 =A0 =A0| X---&gt; hdc</div>
<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 ----------</div><div><br></div><div>We can=
 control the that boundary between host 3 and tgtd or between tgtd and hdc.=
 =A0But if we let both hda and hdb talk to tgtd and we let both host1 and h=
ost2 talk to tgtd we cannot control if tgtd allows host1 to get information=
 from hdb. =A0We can&#39;t control what happens INSIDE the black box. =A0No=
w, if you can come up with a way to run 2 copies of tgtd, so you have 2 bla=
ck boxes, that could be made to work. =A0Otherwise you are going to have to=
 change tgtd to implement the controls you seek....</div>
<div><br></div><div>Make sense?</div><div><br></div><div class=3D"gmail_quo=
te">2011/8/22  <span dir=3D"ltr">&lt;<a href=3D"mailto:GProcunier@symcor.co=
m">GProcunier@symcor.com</a>&gt;</span><br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<font size=3D"2" face=3D"sans-serif">Greetings,</font>
<br>
<br><font size=3D"2" face=3D"sans-serif">I was recently reading this articl=
e
about leveraging iptables with SELinux : </font>
<br>
<br><a href=3D"https://www.linux.com/learn/tutorials/421152-using-selinux-a=
nd-iptables-together" target=3D"_blank"><font size=3D"2" face=3D"sans-serif=
">https://www.linux.com/learn/tutorials/421152-using-selinux-and-iptables-t=
ogether</font></a>
<br>
<br><font size=3D"2" face=3D"sans-serif">I was wondering if a similar union=
 could
allow for the following situation to be accomplished:</font>
<br>
<br><font size=3D"2" face=3D"sans-serif">I have a Red Hat Enterprise Linux =
6.1
server sharing several storage LUNs as iSCSI targets via the native iSCSI
target implementation in that distribution. =A0For technical reasons
several of the LUNs must be exported without CHAP authentication however
I was wondering if I could leverage iptables secmark in conjunction with
SELinux to accomplish the following:</font>
<br>
<br><font size=3D"2" face=3D"sans-serif">1) Client IP connects to the iSCSI=
 target
service. =A0Connection is tracked and secmark&#39;d.</font>
<br><font size=3D"2" face=3D"sans-serif">2) Client IP discovers available L=
UNs
on the iSCSI server</font>
<br><font size=3D"2" face=3D"sans-serif">3) Client IP logs into a LUN which=
 has
an source address access rule preventing access.</font>
<br><font size=3D"2" face=3D"sans-serif">4) When the iSCSI target service t=
ries
to access the LUN to which the Client IP has no access, IPtables severs
the connection via TCP reset / reject. </font>
<br>
<br><font size=3D"2" face=3D"sans-serif">As far as I can tell &quot;tgtd&qu=
ot;
(the iSCSI target daemon) neither supports IP acl&#39;s or is SELinux aware=
,
however I was hoping there might be a way to create an association between
connecting ip / process ID on the server and file/block device access such
that I could use IPtables to terminate the unauthorized connection.</font>
<br>
<br><font size=3D"2" face=3D"sans-serif">If anyone has any thoughts on if t=
his
would be possible in one way or another I would love to hear about it.</fon=
t>
<br>
<br><font size=3D"2" face=3D"sans-serif">Cheers,</font>
<br><font color=3D"#888888">
<br><font size=3D"2" face=3D"sans-serif">--</font>
<br><img>
<br><font size=3D"2" face=3D"sans-serif"><b>Greg Procunier</b></font>
<br><font size=3D"2" face=3D"sans-serif"><i>UNIX Administrator III - Enterp=
rise
Servers and Storage</i></font>
<br><font size=3D"1" face=3D"sans-serif">1 Robert Speck Parkway, Suite 400,=
 Mississauga,
Ontario L4Z 4E7</font>
<br><font size=3D"1" face=3D"sans-serif">Office: <a href=3D"tel:416-673-332=
0" value=3D"+14166733320" target=3D"_blank">416-673-3320</a> </font>
<br><font size=3D"1" face=3D"sans-serif">Mobile: <a href=3D"tel:647-895-297=
7" value=3D"+16478952977" target=3D"_blank">647-895-2977</a></font>
<br><font size=3D"1" face=3D"sans-serif">Email: <a href=3D"mailto:gprocunie=
r@symcor.com" target=3D"_blank">gprocunier@symcor.com</a></font></font><br>=
<br>
<br>
CONFIDENTIALITY WARNING<br>
This communication, including any attachments, is for the exclusive use of =
addressee and may contain proprietary and/or confidential information. If y=
ou are not the intended recipient, any use, copying, disclosure, disseminat=
ion or distribution is strictly prohibited. If you are not the intended rec=
ipient, please notify the sender immediately by return e-mail, delete this =
communication and destroy all copies.<br>

<br>
AVERTISSEMENT RELATIF =C0 LA CONFIDENTIALIT=C9<br>
Ce message, ainsi que les pi=E8ces qui y sont jointes, est destin=E9 =E0 l=
=92usage exclusif de la personne =E0 laquelle il s=92adresse et peut conten=
ir de l=92information personnelle ou confidentielle. Si le lecteur de ce me=
ssage n=92en est pas le destinataire, nous l=92avisons par la pr=E9sente qu=
e toute diffusion, distribution, reproduction ou utilisation de son contenu=
 est strictement interdite. Veuillez avertir sur-le-champ l=92exp=E9diteur =
par retour de courrier =E9lectronique et supprimez ce message ainsi que tou=
tes les pi=E8ces jointes.<br>

<br></blockquote></div><br></div></div>

--20cf301d420a46919f04ab314ced--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
