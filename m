Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j28HwaDo018751
	for <selinux@tycho.nsa.gov>; Tue, 8 Mar 2005 12:58:37 -0500 (EST)
Received: from e2.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j28HrqUj014296
	for <selinux@tycho.nsa.gov>; Tue, 8 Mar 2005 17:53:52 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j28HrtUI004269
	for <selinux@tycho.nsa.gov>; Tue, 8 Mar 2005 12:53:55 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j28HrtBR204978
	for <selinux@tycho.nsa.gov>; Tue, 8 Mar 2005 12:53:55 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j28HrsPK008533
	for <selinux@tycho.nsa.gov>; Tue, 8 Mar 2005 12:53:54 -0500
Received: from d01ml605.pok.ibm.com (d01ml605.pok.ibm.com [9.56.227.91])
	by d01av01.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j28Hrslj008519
	for <selinux@tycho.nsa.gov>; Tue, 8 Mar 2005 12:53:54 -0500
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Subject: Fw: Question regarding SELinux and IPsec
From: Trent Jaeger <jaegert@us.ibm.com>
Message-ID: <OF851CFBBC.CB72CD25-ON85256FBE.0061FB11-85256FBE.00625117@us.ibm.com>
Date: Tue, 8 Mar 2005 12:53:52 -0500
Content-Type: multipart/alternative; boundary="=_alternative 0062505285256FBE_="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multipart message in MIME format.
--=_alternative 0062505285256FBE_=
Content-Type: text/plain; charset="US-ASCII"

Here is the correct answer to Paul Moore's question regarding a standard 
for extending IKE payloads with security contexts. 

We are *not* using a draft design, but are simply adding the context 
string to the negotiation. 

Apologies for the confusion.

Regards,
Trent.
------------------------------------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
19 Skyline Drive, Hawthorne, NY 10532
(914) 784-7225, FAX (914) 784-7225
----- Forwarded by Trent Jaeger/Watson/IBM on 03/08/2005 12:50 PM -----


Serge E Hallyn
03/08/2005 11:35 AM

        To:     Trent Jaeger/Watson/IBM
        cc:     Joy Latten/Austin/IBM, Paul Moore <paul.moore@hp.com>
        Subject:        Re: Fw: Question regarding SELinux and IPsec

Our original sec_ctx in our first prototype implemented the Sensitivity 
Extension (SADB_SENS) in the pfkey rfc (RFC2367 at 
http://www.faqs.org/rfcs/rfc2367.html).

We dropped that when we followed James' or Stephen's suggestion about 
sending the plaintext context instead.  So we no longer explicitly follow 
any draft.  Perhaps we should be looking into amending the draft, but if I 
understand correctly other Linux-specific extensions have also not been 
fed back.

-serge

--=_alternative 0062505285256FBE_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Here is the correct answer to Paul Moore's
question regarding a standard for extending IKE payloads with security
contexts. &nbsp;</font>
<br>
<br><font size=2 face="sans-serif">We are *not* using a draft design, but
are simply adding the context string to the negotiation. &nbsp; </font>
<br>
<br><font size=2 face="sans-serif">Apologies for the confusion.</font>
<br>
<br><font size=2 face="sans-serif">Regards,</font>
<br><font size=2 face="sans-serif">Trent.</font>
<br><font size=2 face="sans-serif">------------------------------------------------------------<br>
Trent Jaeger<br>
IBM T.J. Watson Research Center<br>
19 Skyline Drive, Hawthorne, NY 10532<br>
(914) 784-7225, FAX (914) 784-7225</font>
<br><font size=1 color=#800080 face="sans-serif">----- Forwarded by Trent
Jaeger/Watson/IBM on 03/08/2005 12:50 PM -----</font>
<br>
<table width=100%>
<tr valign=top>
<td>
<td><font size=1 face="sans-serif"><b>Serge E Hallyn</b></font>
<p><font size=1 face="sans-serif">03/08/2005 11:35 AM</font>
<td>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; To:
&nbsp; &nbsp; &nbsp; &nbsp;Trent Jaeger/Watson/IBM</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cc:
&nbsp; &nbsp; &nbsp; &nbsp;Joy Latten/Austin/IBM, Paul Moore &lt;paul.moore@hp.com&gt;</font>
<br><font size=1 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Subject:
&nbsp; &nbsp; &nbsp; &nbsp;Re: Fw: Question regarding SELinux and
IPsec</font><a href=Notes:///852563A300413419/BD053B46B119C67A8525643000742B16/57307C3D0FEF769D85256FBE0057CB97>Link</a></table>
<br>
<br><font size=2 face="sans-serif">Our original sec_ctx in our first prototype
implemented the Sensitivity Extension (SADB_SENS) in the pfkey rfc (RFC2367
at http://www.faqs.org/rfcs/rfc2367.html).</font>
<br>
<br><font size=2 face="sans-serif">We dropped that when we followed James'
or Stephen's suggestion about sending the plaintext context instead. &nbsp;So
we no longer explicitly follow any draft. &nbsp;Perhaps we should be looking
into amending the draft, but if I understand correctly other Linux-specific
extensions have also not been fed back.</font>
<br>
<br><font size=2 face="sans-serif">-serge</font>
<br>
--=_alternative 0062505285256FBE_=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
