Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l16NN9ZF021132
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2007 18:23:09 -0500
Received: from elasmtp-curtail.atl.sa.earthlink.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l16NOGbD006400
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2007 23:24:16 GMT
Message-ID: <003401c74a45$eb837bd0$24c60c0a@EMAIL>
From: "Robert Adams" <whatifwe@ix.netcom.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: "SELinux Mail List\"" <selinux@tycho.nsa.gov>
References: <45C23E5F.5050503@mentalrootkit.com> <1170688132.12293.245.camel@moss-spartans.epoch.ncsc.mil> <45C8E749.4000606@mentalrootkit.com>
Subject: Re: [RFC] new libsepol policy representation
Date: Tue, 6 Feb 2007 15:24:15 -0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0031_01C74A02.DCA63AA0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0031_01C74A02.DCA63AA0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello:

I a new kid on the block; just subscribed today.

I am a consultant in Sun Valley, Ca.  with 40+ years experience. I =
specialize in the development and test of
"error-free" software and have developed some developed some open-source =
development and test tools
for this goal.  I invite you to visit my web-site, www.whatifwe.com, and =
download as appropriate.
Perhaps I can help in some small way.

Hope to Hear from you Soon

Thank You

Robert Adams


=20
----- Original Message -----=20
From: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "SELinux Mail List" <selinux@tycho.nsa.gov>
Sent: Tuesday, February 06, 2007 12:38 PM
Subject: Re: [RFC] new libsepol policy representation


> Stephen Smalley wrote:
>>=20
>> I'm not fundamentally opposed; we have in the past called for an
>> appropriate IR for policy as a common basis for tools and
>> infrastructure.
>>=20
>> In skimming through the patch set, I'm unclear as to which aspects =
are
>> intended to be part of the shared library interface vs. the static
>> library interface.  In the current libsepol, include/sepol/policydb/
>> contains private state that is only made available to shared library
>> users, while the top-level header files in include/sepol define the
>> shared library interface.
>=20
> I'm currently undecided about this, so I'm creating APIs that are=20
> appropriate for export and not planning on exporting them intially.
>=20
>   Of course, libsepol.map is the authoritative
>> definition of the shared library interface.  If you intend to export
>> things like hashtabs to shared library users, then we naturally need
>> proper encapsulation and namespacing of them.
>>=20
>> As a nit, there is a name collision between the existing sepol_node
>> struct (for node aka host records) and your new sepol_node struct for
>> the tree.=20
>>=20
>=20
> Good catch - thanks.
>=20
>> Similarly, you would need to reconcile your sepol_security_context*
>> functions with the existing sepol_context* record functions.  There =
may
>> be other points of duplication/overlap; I haven't yet looked =
thoroughly.
>>=20
>=20
> I'm planning to reconcile these at a future point - my plan is that =
the=20
> records and the new policy structures will be fully merged at the end =
of=20
> this.
>=20
> Karl
>=20
> --
> This message was distributed to subscribers of the selinux mailing =
list.
> If you no longer wish to subscribe, send mail to =
majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
------=_NextPart_000_0031_01C74A02.DCA63AA0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY>
<DIV><FONT face=3DArial></FONT><FONT face=3D"Arial Black" =
size=3D2>Hello:</FONT></DIV>
<DIV><FONT face=3D"Arial Black" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Arial Black" size=3D2>I a new kid on the block; just =
subscribed=20
today.</FONT></DIV>
<DIV><FONT face=3D"Arial Black" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Arial Black" size=3D2>I am a consultant in Sun =
Valley, Ca.&nbsp;=20
with 40+ years experience.&nbsp;I specialize in the development and test =

of</FONT></DIV>
<DIV><FONT face=3D"Arial Black" size=3D2>"error-free" software and =
</FONT><FONT=20
face=3D"Arial Black" size=3D2>have developed some developed some =
open-source=20
development and test tools</FONT></DIV>
<DIV><FONT face=3D"Arial Black" size=3D2>for this goal.&nbsp; I invite =
you=20
</FONT><FONT face=3D"Arial Black" size=3D2>to visit my =
web-site,&nbsp;</FONT><FONT=20
face=3D"Arial Black" size=3D2><A=20
href=3D"http://www.whatifwe.com">www.whatifwe.com</A>,&nbsp;and download =
as=20
appropriate.</FONT></DIV>
<DIV><FONT face=3D"Arial Black" size=3D2>Perhaps I can help in some =
small=20
way.</FONT></DIV>
<DIV><FONT face=3D"Arial Black" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Arial Black" size=3D2>Hope to Hear from you =
Soon</FONT></DIV>
<DIV><FONT face=3D"Arial Black" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Arial Black" size=3D2>Thank You</FONT></DIV>
<DIV><FONT face=3D"Arial Black" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Arial Black" size=3D2>Robert Adams</FONT></DIV>
<DIV><FONT face=3D"Arial Black" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Arial Black" size=3D2></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>----- Original Message ----- </FONT>
<DIV><FONT face=3DArial size=3D2>From: "Karl MacMillan" &lt;</FONT><A=20
href=3D"mailto:kmacmillan@mentalrootkit.com"><FONT face=3DArial=20
size=3D2>kmacmillan@mentalrootkit.com</FONT></A><FONT face=3DArial=20
size=3D2>&gt;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>To: "Stephen Smalley" &lt;</FONT><A=20
href=3D"mailto:sds@tycho.nsa.gov"><FONT face=3DArial=20
size=3D2>sds@tycho.nsa.gov</FONT></A><FONT face=3DArial =
size=3D2>&gt;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Cc: "SELinux Mail List" &lt;</FONT><A=20
href=3D"mailto:selinux@tycho.nsa.gov"><FONT face=3DArial=20
size=3D2>selinux@tycho.nsa.gov</FONT></A><FONT face=3DArial =
size=3D2>&gt;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Sent: Tuesday, February 06, 2007 12:38=20
PM</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Subject: Re: [RFC] new libsepol policy=20
representation</FONT></DIV></DIV>
<DIV><FONT face=3DArial><BR><FONT size=3D2></FONT></FONT></DIV><FONT =
face=3DArial=20
size=3D2>&gt; Stephen Smalley wrote:<BR>&gt;&gt; <BR>&gt;&gt; I'm not=20
fundamentally opposed; we have in the past called for an<BR>&gt;&gt; =
appropriate=20
IR for policy as a common basis for tools and<BR>&gt;&gt;=20
infrastructure.<BR>&gt;&gt; <BR>&gt;&gt; In skimming through the patch =
set, I'm=20
unclear as to which aspects are<BR>&gt;&gt; intended to be part of the =
shared=20
library interface vs. the static<BR>&gt;&gt; library interface.&nbsp; In =
the=20
current libsepol, include/sepol/policydb/<BR>&gt;&gt; contains private =
state=20
that is only made available to shared library<BR>&gt;&gt; users, while =
the=20
top-level header files in include/sepol define the<BR>&gt;&gt; shared =
library=20
interface.<BR>&gt; <BR>&gt; I'm currently undecided about this, so I'm =
creating=20
APIs that are <BR>&gt; appropriate for export and not planning on =
exporting them=20
intially.<BR>&gt; <BR>&gt;&nbsp;&nbsp; Of course, libsepol.map is the=20
authoritative<BR>&gt;&gt; definition of the shared library =
interface.&nbsp; If=20
you intend to export<BR>&gt;&gt; things like hashtabs to shared library =
users,=20
then we naturally need<BR>&gt;&gt; proper encapsulation and namespacing =
of=20
them.<BR>&gt;&gt; <BR>&gt;&gt; As a nit, there is a name collision =
between the=20
existing sepol_node<BR>&gt;&gt; struct (for node aka host records) and =
your new=20
sepol_node struct for<BR>&gt;&gt; the tree. <BR>&gt;&gt; <BR>&gt; =
<BR>&gt; Good=20
catch - thanks.<BR>&gt; <BR>&gt;&gt; Similarly, you would need to =
reconcile your=20
sepol_security_context*<BR>&gt;&gt; functions with the existing =
sepol_context*=20
record functions.&nbsp; There may<BR>&gt;&gt; be other points of=20
duplication/overlap; I haven't yet looked thoroughly.<BR>&gt;&gt; =
<BR>&gt;=20
<BR>&gt; I'm planning to reconcile these at a future point - my plan is =
that the=20
<BR>&gt; records and the new policy structures will be fully merged at =
the end=20
of <BR>&gt; this.<BR>&gt; <BR>&gt; Karl<BR>&gt; <BR>&gt; --<BR>&gt; This =
message=20
was distributed to subscribers of the selinux mailing list.<BR>&gt; If =
you no=20
longer wish to subscribe, send mail to </FONT><A=20
href=3D"mailto:majordomo@tycho.nsa.gov"><FONT face=3DArial=20
size=3D2>majordomo@tycho.nsa.gov</FONT></A><FONT face=3DArial size=3D2> =
with<BR>&gt;=20
the words "unsubscribe selinux" without quotes as the=20
message.<BR>&gt;</FONT></BODY></HTML>

------=_NextPart_000_0031_01C74A02.DCA63AA0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
