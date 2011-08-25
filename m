Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7PFAV82012339
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 11:10:31 -0400
Received: from mr1.symcor.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7PFAUPm012662
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 15:10:30 GMT
Content-Type: multipart/mixed; boundary="===============2115581390=="
MIME-Version: 1.0
In-Reply-To: <CACLa4psLVs8Unj3RdjFkycWVS5y_KTeMYuriNwCP=+OrkPxC0w@mail.gmail.com>
References: <OF18D472F9.0451EEBF-ON852578F4.00654DC8-852578F4.006779B2@symcor.com> <CACLa4psLVs8Unj3RdjFkycWVS5y_KTeMYuriNwCP=+OrkPxC0w@mail.gmail.com>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Subject: Re: SELinux+IPTables+Non SELINUX Aware Network Daemon
Message-ID: <OF49BFB479.51BA8C3A-ON852578F7.00533F8E-852578F7.00534F1A@symcor.com>
From: GProcunier@symcor.com
Date: Thu, 25 Aug 2011 11:10:28 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--===============2115581390==
MIME-Version: 1.0
Content-Type: multipart/related; boundary="=_related 00534F11852578F7_="

--=_related 00534F11852578F7_=
Content-Type: multipart/alternative; boundary="=_alternative 00534F19852578F7_="


--=_alternative 00534F19852578F7_=
Content-Type: text/plain; charset="US-ASCII"

Thank you that was very helpful.

--

Greg Procunier
UNIX Administrator III - Enterprise Servers and Storage
1 Robert Speck Parkway, Suite 400, Mississauga, Ontario L4Z 4E7
Office: 416-673-3320 
Mobile: 647-895-2977
Email: gprocunier@symcor.com

owner-selinux@tycho.nsa.gov wrote on 08/23/2011 03:35:28 PM:

> From: Eric Paris <eparis@parisplace.org>
> To: GProcunier@symcor.com
> Cc: selinux@tycho.nsa.gov
> Date: 08/23/2011 03:41 PM
> Subject: Re: SELinux+IPTables+Non SELINUX Aware Network Daemon
> Sent by: owner-selinux@tycho.nsa.gov
> 
> Nobody jumped in so I'll answer you.  The answer is that no, you 
> cannot do this with what you have today as you describe it.  SELinux
> can be used to control what IP addresses tgtd is allowed to talk to.
>  It can also control what block devices tgtd is allowed to talk to. 
>  But SELinux does not have a way to tie an IP address to a block 
> device.  That information cannot be magically transferred through 
> the tgtd daemon.  Lets say we have
> 
> Hosts: 1, 2, and 3
> Block devices: hda, hdb, and hdc
> 
> If I understand your situation correctly a similar example might be 
> summed up as follows.  You want Host 1 to ONLY be allowed to use 
> block device hda.  You want host 2 to ONLY be allowed to use block 
> device hdb.  You do not want tgtd to talk to host3.  You do not want
> anything to use hdc.
> 
> We can write iptables labeling rules and policy which only grants 
> tgtd the ability to talk to host1 and host2.  We can write policy 
> rules which would only give tgtd access to hda and hdb.  What we 
> cannot do is control if host1 tries to mount and use hdb.  We don't 
> have a way to get that information through the tgtd program.  Think 
> of tgtd as a black box.  SELinux can control what comes in and out 
> of the box, but once inside it can't do anything about it.
> 
>               ----------
> host 1 <---> |          | <---> hda
> host 2 <---> |   TGTD   | <---> hdb
> host 3 <---X |          | X---> hdc
>               ----------
> 
> We can control the that boundary between host 3 and tgtd or between 
> tgtd and hdc.  But if we let both hda and hdb talk to tgtd and we 
> let both host1 and host2 talk to tgtd we cannot control if tgtd 
> allows host1 to get information from hdb.  We can't control what 
> happens INSIDE the black box.  Now, if you can come up with a way to
> run 2 copies of tgtd, so you have 2 black boxes, that could be made 
> to work.  Otherwise you are going to have to change tgtd to 
> implement the controls you seek....
> 
> Make sense?
> 
> 2011/8/22 <GProcunier@symcor.com>
> Greetings, 
> 
> I was recently reading this article about leveraging iptables with 
SELinux : 
> 
> https://www.linux.com/learn/tutorials/421152-using-selinux-and-
> iptables-together 
> 
> I was wondering if a similar union could allow for the following 
> situation to be accomplished: 
> 
> I have a Red Hat Enterprise Linux 6.1 server sharing several storage
> LUNs as iSCSI targets via the native iSCSI target implementation in 
> that distribution.  For technical reasons several of the LUNs must 
> be exported without CHAP authentication however I was wondering if I
> could leverage iptables secmark in conjunction with SELinux to 
> accomplish the following: 
> 
> 1) Client IP connects to the iSCSI target service.  Connection is 
> tracked and secmark'd. 
> 2) Client IP discovers available LUNs on the iSCSI server 
> 3) Client IP logs into a LUN which has an source address access rule
> preventing access. 
> 4) When the iSCSI target service tries to access the LUN to which 
> the Client IP has no access, IPtables severs the connection via TCP 
> reset / reject. 
> 
> As far as I can tell "tgtd" (the iSCSI target daemon) neither 
> supports IP acl's or is SELinux aware, however I was hoping there 
> might be a way to create an association between connecting ip / 
> process ID on the server and file/block device access such that I 
> could use IPtables to terminate the unauthorized connection. 
> 
> If anyone has any thoughts on if this would be possible in one way 
> or another I would love to hear about it. 
> 
> Cheers, 
> 


--=_alternative 00534F19852578F7_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Thank you that was very helpful.</font>
<br>
<br><font size=2 face="sans-serif">--</font>
<br><img src=cid:_2_0306EAA80306E79C00534F11852578F7>
<br><font size=2 face="sans-serif"><b>Greg Procunier</b></font>
<br><font size=2 face="sans-serif"><i>UNIX Administrator III - Enterprise
Servers and Storage</i></font>
<br><font size=1 face="sans-serif">1 Robert Speck Parkway, Suite 400, Mississauga,
Ontario L4Z 4E7</font>
<br><font size=1 face="sans-serif">Office: 416-673-3320 </font>
<br><font size=1 face="sans-serif">Mobile: 647-895-2977</font>
<br><font size=1 face="sans-serif">Email: gprocunier@symcor.com</font>
<br>
<br><tt><font size=2>owner-selinux@tycho.nsa.gov wrote on 08/23/2011 03:35:28
PM:<br>
<br>
&gt; From: Eric Paris &lt;eparis@parisplace.org&gt;</font></tt>
<br><tt><font size=2>&gt; To: GProcunier@symcor.com</font></tt>
<br><tt><font size=2>&gt; Cc: selinux@tycho.nsa.gov</font></tt>
<br><tt><font size=2>&gt; Date: 08/23/2011 03:41 PM</font></tt>
<br><tt><font size=2>&gt; Subject: Re: SELinux+IPTables+Non SELINUX Aware
Network Daemon</font></tt>
<br><tt><font size=2>&gt; Sent by: owner-selinux@tycho.nsa.gov</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; Nobody jumped in so I'll answer you. &nbsp;The answer is that no,
you <br>
&gt; cannot do this with what you have today as you describe it. &nbsp;SELinux<br>
&gt; can be used to control what IP addresses tgtd is allowed to talk to.<br>
&gt; &nbsp;It can also control what block devices tgtd is allowed to talk
to. <br>
&gt; &nbsp;But SELinux does not have a way to tie an IP address to a block
<br>
&gt; device. &nbsp;That information cannot be magically transferred through
<br>
&gt; the tgtd daemon. &nbsp;Lets say we have</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; Hosts: 1, 2, and 3</font></tt>
<br><tt><font size=2>&gt; Block devices: hda, hdb, and hdc</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; If I understand your situation correctly a similar example might be
<br>
&gt; summed up as follows. &nbsp;You want Host 1 to ONLY be allowed to
use <br>
&gt; block device hda. &nbsp;You want host 2 to ONLY be allowed to use
block <br>
&gt; device hdb. &nbsp;You do not want tgtd to talk to host3. &nbsp;You
do not want<br>
&gt; anything to use hdc.</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; We can write iptables labeling rules and policy which only grants
<br>
&gt; tgtd the ability to talk to host1 and host2. &nbsp;We can write policy
<br>
&gt; rules which would only give tgtd access to hda and hdb. &nbsp;What
we <br>
&gt; cannot do is control if host1 tries to mount and use hdb. &nbsp;We
don't <br>
&gt; have a way to get that information through the tgtd program. &nbsp;Think
<br>
&gt; of tgtd as a black box. &nbsp;SELinux can control what comes in and
out <br>
&gt; of the box, but once inside it can't do anything about it.</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ----------</font></tt>
<br><tt><font size=2>&gt; host 1 &lt;---&gt; | &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;| &lt;---&gt; hda</font></tt>
<br><tt><font size=2>&gt; host 2 &lt;---&gt; | &nbsp; TGTD &nbsp; | &lt;---&gt;
hdb</font></tt>
<br><tt><font size=2>&gt; host 3 &lt;---X | &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;| X---&gt; hdc</font></tt>
<br><tt><font size=2>&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
----------</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; We can control the that boundary between host 3 and tgtd or between
<br>
&gt; tgtd and hdc. &nbsp;But if we let both hda and hdb talk to tgtd and
we <br>
&gt; let both host1 and host2 talk to tgtd we cannot control if tgtd <br>
&gt; allows host1 to get information from hdb. &nbsp;We can't control what
<br>
&gt; happens INSIDE the black box. &nbsp;Now, if you can come up with a
way to<br>
&gt; run 2 copies of tgtd, so you have 2 black boxes, that could be made
<br>
&gt; to work. &nbsp;Otherwise you are going to have to change tgtd to <br>
&gt; implement the controls you seek....</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; Make sense?</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; 2011/8/22 &lt;GProcunier@symcor.com&gt;</font></tt>
<br><tt><font size=2>&gt; Greetings, <br>
&gt; <br>
&gt; I was recently reading this article about leveraging iptables with
SELinux : <br>
&gt; <br>
&gt; </font></tt><a href="https://www.linux.com/learn/tutorials/421152-using-selinux-and-"><tt><font size=2>https://www.linux.com/learn/tutorials/421152-using-selinux-and-</font></tt></a><tt><font size=2><br>
&gt; iptables-together <br>
&gt; <br>
&gt; I was wondering if a similar union could allow for the following <br>
&gt; situation to be accomplished: <br>
&gt; <br>
&gt; I have a Red Hat Enterprise Linux 6.1 server sharing several storage<br>
&gt; LUNs as iSCSI targets via the native iSCSI target implementation in
<br>
&gt; that distribution. &nbsp;For technical reasons several of the LUNs
must <br>
&gt; be exported without CHAP authentication however I was wondering if
I<br>
&gt; could leverage iptables secmark in conjunction with SELinux to <br>
&gt; accomplish the following: <br>
&gt; <br>
&gt; 1) Client IP connects to the iSCSI target service. &nbsp;Connection
is <br>
&gt; tracked and secmark'd. <br>
&gt; 2) Client IP discovers available LUNs on the iSCSI server <br>
&gt; 3) Client IP logs into a LUN which has an source address access rule<br>
&gt; preventing access. <br>
&gt; 4) When the iSCSI target service tries to access the LUN to which
<br>
&gt; the Client IP has no access, IPtables severs the connection via TCP
<br>
&gt; reset / reject. <br>
&gt; <br>
&gt; As far as I can tell &quot;tgtd&quot; (the iSCSI target daemon) neither
<br>
&gt; supports IP acl's or is SELinux aware, however I was hoping there
<br>
&gt; might be a way to create an association between connecting ip / <br>
&gt; process ID on the server and file/block device access such that I
<br>
&gt; could use IPtables to terminate the unauthorized connection. <br>
&gt; <br>
&gt; If anyone has any thoughts on if this would be possible in one way
<br>
&gt; or another I would love to hear about it. <br>
&gt; <br>
&gt; Cheers, <br>
&gt; <br>
<br>
</font></tt>
--=_alternative 00534F19852578F7_=--

--=_related 00534F11852578F7_=
Content-Type: image/jpeg
Content-ID: <_2_0306EAA80306E79C00534F11852578F7>
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
--=_related 00534F11852578F7_=--

--===============2115581390==
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

--===============2115581390==--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
