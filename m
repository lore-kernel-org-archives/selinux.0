In-Reply-To: <20041026150450.82663.qmail@web90108.mail.scd.yahoo.com>
To: Philip Leo <phlpleo@yahoo.com>
Cc: lkcl@lkcl.net, parklee_sel@yahoo.com, rusinskystanislas@yahoo.fr,
   sds@epoch.ncsc.mil, SELinux@tycho.nsa.gov
MIME-Version: 1.0
Subject: Re: SELinux with IPSec - something going on ?
From: Trent Jaeger <jaegert@us.ibm.com>
Message-ID: <OF4F4F7089.8A15DEF7-ON85256F39.00542F86-85256F39.0054856F@us.ibm.com>
Date: Tue, 26 Oct 2004 11:23:11 -0400
Content-Type: multipart/alternative; boundary="=_alternative 0054833185256F39_="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multipart message in MIME format.
--=_alternative 0054833185256F39_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Sure.

Linux 2.6 implements IPSec via a xfrm (pronounced 'transform') subsystem=20
(part of mainline kernel).

Basically, you can define 'protocols' that may transform packets upon=20
receipt or prior to send.  IPSec protocols for transform packets using ah=20
and esp are included in the kernel.=20

We hook into the xfrm subsystem and/or use the xfrm data structures to=20
leverage IPSec security associations.

Regards,
Trent.
------------------------------------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
19 Skyline Drive, Hawthorne, NY 10532
(914) 784-7225, FAX (914) 784-7225




Philip Leo <phlpleo@yahoo.com>
10/26/2004 11:04 AM
=20
        To:     Trent Jaeger/Watson/IBM@IBMUS
        cc:     SELinux@tycho.nsa.gov, sds@epoch.ncsc.mil, lkcl@lkcl.net,=20
rusinskystanislas@yahoo.fr, parklee=5Fsel@yahoo.com
        Subject:        Re: SELinux with IPSec - something going on ?



On Mon, 25 Oct 2004 at 10:59, Trent Jaeger wrote:
>Yes, we are working on integration of IPSec with SELinux.  Hope
>to have something for the community soon.=20
Could you please tell us what Linux IPsec implementation you are using? Is =

it FreeS/WAN?
Is Fedora Core itself include an IPsec implementation? or does it use a=20
third-party Linux IPsec implementation?


--
Best regards,
Philip Leo  <phlpleo@yahoo.com>=20


Do you Yahoo!?
Yahoo! Mail ? CNET Editors' Choice 2004.  Tell them what you think.=20

--=_alternative 0054833185256F39_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Sure.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Linux 2.6 implements IPSec via a xfrm
(pronounced 'transform') subsystem (part of mainline kernel).</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Basically, you can define 'protocols'
that may transform packets upon receipt or prior to send. &nbsp;IPSec proto=
cols
for transform packets using ah and esp are included in the kernel. &nbsp;</=
font>
<br>
<br><font size=3D2 face=3D"sans-serif">We hook into the xfrm subsystem and/=
or
use the xfrm data structures to leverage IPSec security associations.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Regards,</font>
<br><font size=3D2 face=3D"sans-serif">Trent.</font>
<br><font size=3D2 face=3D"sans-serif">------------------------------------=
------------------------<br>
Trent Jaeger<br>
IBM T.J. Watson Research Center<br>
19 Skyline Drive, Hawthorne, NY 10532<br>
(914) 784-7225, FAX (914) 784-7225</font>
<br>
<br>
<br>
<table width=3D100%>
<tr valign=3Dtop>
<td>
<td><font size=3D1 face=3D"sans-serif"><b>Philip Leo &lt;phlpleo@yahoo.com&=
gt;</b></font>
<p><font size=3D1 face=3D"sans-serif">10/26/2004 11:04 AM</font>
<td><font size=3D1 face=3D"Arial">&nbsp; &nbsp; &nbsp; &nbsp; </font>
<br><font size=3D1 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; To:
&nbsp; &nbsp; &nbsp; &nbsp;Trent Jaeger/Watson/IBM@IBMUS</font>
<br><font size=3D1 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cc:
&nbsp; &nbsp; &nbsp; &nbsp;SELinux@tycho.nsa.gov, sds@epoch.ncsc.mil,
lkcl@lkcl.net, rusinskystanislas@yahoo.fr, parklee=5Fsel@yahoo.com</font>
<br><font size=3D1 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Subject:
&nbsp; &nbsp; &nbsp; &nbsp;Re: SELinux with IPSec - something going
on ?</font></table>
<br>
<br>
<br>
<br><font size=3D3>On Mon, 25 Oct 2004 at 10:59, Trent Jaeger wrote:</font>
<br><font size=3D3>&gt;Yes, we are working on integration of IPSec with SEL=
inux.
&nbsp;Hope</font>
<br><font size=3D3>&gt;to have something for the community soon. </font>
<br><font size=3D3>Could you please tell us what Linux IPsec implementation
you are using? Is it FreeS/WAN?</font>
<br><font size=3D3>Is Fedora Core itself include an IPsec implementation?
or does it use a third-party Linux IPsec implementation?</font>
<br>
<br>
<br><font size=3D3>--</font>
<br><font size=3D3>Best regards,</font>
<br><font size=3D3>Philip Leo&nbsp; &lt;</font><a href=3Dmailto:phlpleo@yah=
oo.com><font size=3D3 color=3Dblue><u>phlpleo@yahoo.com</u></font></a><font=
 size=3D3>&gt;
</font>
<br>
<hr>
<br>
<br><font size=3D3>Do you Yahoo!?</font>
<br><font size=3D3>Yahoo! Mail &#8211; CNET Editors' Choice 2004. </font><a=
 href=3D"http://reviews.cnet.com/Yahoo=5FMail/4852-9236=5F7-30980704.html?p=
art=3Deditchoice"><font size=3D3 color=3Dblue><u>&nbsp;Tell
them what you think</u></font></a><font size=3D3>. </font>
<br>
--=_alternative 0054833185256F39_=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
