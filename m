Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i94MBkrT022184
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 18:11:47 -0400 (EDT)
Received: from e6.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i94MBjs6000643
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 22:11:46 GMT
Received: from northrelay04.pok.ibm.com (northrelay04.pok.ibm.com [9.56.224.206])
	by e6.ny.us.ibm.com (8.12.10/8.12.9) with ESMTP id i94MBkSD056420
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 18:11:46 -0400
Received: from d01ml605.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by northrelay04.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id i94MD0Kt099696
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 18:13:00 -0400
To: <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Subject: Add a new class
From: Trent Jaeger <jaegert@us.ibm.com>
Message-ID: <OF459C4AF8.918C9B11-ON85256F23.00798D88-85256F23.0079ECBE@us.ibm.com>
Date: Mon, 4 Oct 2004 18:11:43 -0400
Content-Type: multipart/alternative; boundary="=_alternative 0079EB6585256F23_="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multipart message in MIME format.
--=_alternative 0079EB6585256F23_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

I think this is something I could find in the docs or code, but I don't 
see it. 

How do I add a new class?  There are a variety of files in 
security/selinux/include, such as av_permissions.h, that are 
"automatically generated", but they are already in the distribution, so it 
is not clear how they are generated.  If I add a class, operations, etc., 
these files have to be modified and I would rather do it the proper way.

BTW -- this is for adding IPSec security associations for classes, so we 
can label network connections.  Prototype code should be available soon.

Regards,
Trent.
------------------------------------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
19 Skyline Drive, Hawthorne, NY 10532
(914) 784-7225, FAX (914) 784-7225
--=_alternative 0079EB6585256F23_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">I think this is something I could find
in the docs or code, but I don't see it. &nbsp;</font>
<br>
<br><font size=2 face="sans-serif">How do I add a new class? &nbsp;There
are a variety of files in security/selinux/include, such as av_permissions.h,
that are &quot;automatically generated&quot;, but they are already in the
distribution, so it is not clear how they are generated. &nbsp;If I add
a class, operations, etc., these files have to be modified and I would
rather do it the proper way.</font>
<br>
<br><font size=2 face="sans-serif">BTW -- this is for adding IPSec security
associations for classes, so we can label network connections. &nbsp;Prototype
code should be available soon.</font>
<br>
<br><font size=2 face="sans-serif">Regards,</font>
<br><font size=2 face="sans-serif">Trent.</font>
<br><font size=2 face="sans-serif">------------------------------------------------------------<br>
Trent Jaeger<br>
IBM T.J. Watson Research Center<br>
19 Skyline Drive, Hawthorne, NY 10532<br>
(914) 784-7225, FAX (914) 784-7225</font>
--=_alternative 0079EB6585256F23_=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
