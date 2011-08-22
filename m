Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7MIokmK012251
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2011 14:50:46 -0400
Received: from mr2.symcor.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7MIokkC005271
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2011 18:50:46 GMT
Content-Type: multipart/mixed; boundary="===============0589774995=="
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Subject: SELinux+IPTables+Non SELINUX Aware Network Daemon
Message-ID: <OF18D472F9.0451EEBF-ON852578F4.00654DC8-852578F4.006779B2@symcor.com>
From: GProcunier@symcor.com
Date: Mon, 22 Aug 2011 14:50:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--===============0589774995==
MIME-Version: 1.0
Content-Type: multipart/related; boundary="=_related 006779B0852578F4_="

--=_related 006779B0852578F4_=
Content-Type: multipart/alternative; boundary="=_alternative 006779B0852578F4_="


--=_alternative 006779B0852578F4_=
Content-Type: text/plain; charset="US-ASCII"

Greetings,

I was recently reading this article about leveraging iptables with SELinux 
: 

https://www.linux.com/learn/tutorials/421152-using-selinux-and-iptables-together

I was wondering if a similar union could allow for the following situation 
to be accomplished:

I have a Red Hat Enterprise Linux 6.1 server sharing several storage LUNs 
as iSCSI targets via the native iSCSI target implementation in that 
distribution.  For technical reasons several of the LUNs must be exported 
without CHAP authentication however I was wondering if I could leverage 
iptables secmark in conjunction with SELinux to accomplish the following:

1) Client IP connects to the iSCSI target service.  Connection is tracked 
and secmark'd.
2) Client IP discovers available LUNs on the iSCSI server
3) Client IP logs into a LUN which has an source address access rule 
preventing access.
4) When the iSCSI target service tries to access the LUN to which the 
Client IP has no access, IPtables severs the connection via TCP reset / 
reject. 

As far as I can tell "tgtd" (the iSCSI target daemon) neither supports IP 
acl's or is SELinux aware, however I was hoping there might be a way to 
create an association between connecting ip / process ID on the server and 
file/block device access such that I could use IPtables to terminate the 
unauthorized connection.

If anyone has any thoughts on if this would be possible in one way or 
another I would love to hear about it.

Cheers,

--

Greg Procunier
UNIX Administrator III - Enterprise Servers and Storage
1 Robert Speck Parkway, Suite 400, Mississauga, Ontario L4Z 4E7
Office: 416-673-3320 
Mobile: 647-895-2977
Email: gprocunier@symcor.com
--=_alternative 006779B0852578F4_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Greetings,</font>
<br>
<br><font size=2 face="sans-serif">I was recently reading this article
about leveraging iptables with SELinux : </font>
<br>
<br><a href="https://www.linux.com/learn/tutorials/421152-using-selinux-and-iptables-together"><font size=2 face="sans-serif">https://www.linux.com/learn/tutorials/421152-using-selinux-and-iptables-together</font></a>
<br>
<br><font size=2 face="sans-serif">I was wondering if a similar union could
allow for the following situation to be accomplished:</font>
<br>
<br><font size=2 face="sans-serif">I have a Red Hat Enterprise Linux 6.1
server sharing several storage LUNs as iSCSI targets via the native iSCSI
target implementation in that distribution. &nbsp;For technical reasons
several of the LUNs must be exported without CHAP authentication however
I was wondering if I could leverage iptables secmark in conjunction with
SELinux to accomplish the following:</font>
<br>
<br><font size=2 face="sans-serif">1) Client IP connects to the iSCSI target
service. &nbsp;Connection is tracked and secmark'd.</font>
<br><font size=2 face="sans-serif">2) Client IP discovers available LUNs
on the iSCSI server</font>
<br><font size=2 face="sans-serif">3) Client IP logs into a LUN which has
an source address access rule preventing access.</font>
<br><font size=2 face="sans-serif">4) When the iSCSI target service tries
to access the LUN to which the Client IP has no access, IPtables severs
the connection via TCP reset / reject. </font>
<br>
<br><font size=2 face="sans-serif">As far as I can tell &quot;tgtd&quot;
(the iSCSI target daemon) neither supports IP acl's or is SELinux aware,
however I was hoping there might be a way to create an association between
connecting ip / process ID on the server and file/block device access such
that I could use IPtables to terminate the unauthorized connection.</font>
<br>
<br><font size=2 face="sans-serif">If anyone has any thoughts on if this
would be possible in one way or another I would love to hear about it.</font>
<br>
<br><font size=2 face="sans-serif">Cheers,</font>
<br>
<br><font size=2 face="sans-serif">--</font>
<br><img src=cid:_2_09B28A9009B28850006779B0852578F4>
<br><font size=2 face="sans-serif"><b>Greg Procunier</b></font>
<br><font size=2 face="sans-serif"><i>UNIX Administrator III - Enterprise
Servers and Storage</i></font>
<br><font size=1 face="sans-serif">1 Robert Speck Parkway, Suite 400, Mississauga,
Ontario L4Z 4E7</font>
<br><font size=1 face="sans-serif">Office: 416-673-3320 </font>
<br><font size=1 face="sans-serif">Mobile: 647-895-2977</font>
<br><font size=1 face="sans-serif">Email: gprocunier@symcor.com</font>
--=_alternative 006779B0852578F4_=--

--=_related 006779B0852578F4_=
Content-Type: image/jpeg
Content-ID: <_2_09B28A9009B28850006779B0852578F4>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0a
HBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIy
MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAA+AbwDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD3+iii
gDF0HxboXiZ7hNG1BLtrbb5wVGGzdnGcgf3T+VcJ8Y/iGfD2nf2BpU5GrXqfvJIz81vEeMj0dug7
jk8HGXeGbWXwVH4tez09rrVL/WpU0+zj48xdoZMnoqL5hLMcAD3IB1fB/wANYdI1GTxD4hnTVfEl
w5lkuGH7uFj2jB9OgY84AACjir0TuQ7tWHfCeDxXbeEkh8TpsCYFmspP2hY8dJB2xxjPOODXeUUV
Ld3cpKyCiiikMKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoooo
AKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooArX9qb2xltg+
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
r7cvvF7TyP/Z
--=_related 006779B0852578F4_=--

--===============0589774995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



CONFIDENTIALITY WARNING =

This communication, including any attachments, is for the exclusive use of =
addressee and may contain proprietary and/or confidential information. If y=
ou are not the intended recipient, any use, copying, disclosure, disseminat=
ion or distribution is strictly prohibited. If you are not the intended rec=
ipient, please notify the sender immediately by return e-mail, delete this =
communication and destroy all copies.

AVERTISSEMENT RELATIF =C3=80 LA CONFIDENTIALIT=C3=89 =

Ce message, ainsi que les pi=C3=A8ces qui y sont jointes, est destin=C3=A9 =
=C3=A0 l=E2=80=99usage exclusif de la personne =C3=A0 laquelle il s=E2=80=
=99adresse et peut contenir de l=E2=80=99information personnelle ou confide=
ntielle. Si le lecteur de ce message n=E2=80=99en est pas le destinataire, =
nous l=E2=80=99avisons par la pr=C3=A9sente que toute diffusion, distributi=
on, reproduction ou utilisation de son contenu est strictement interdite. V=
euillez avertir sur-le-champ l=E2=80=99exp=C3=A9diteur par retour de courri=
er =C3=A9lectronique et supprimez ce message ainsi que toutes les pi=C3=A8c=
es jointes.

--===============0589774995==--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
