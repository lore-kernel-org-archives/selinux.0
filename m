Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i090HiRb027244
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 19:17:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i090Gexr020073
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 00:16:40 GMT
Received: from georgia.yamato.ibm.com (georgia.yamato.ibm.com [203.141.89.181])
	by jazzswing.ncsc.mil  with ESMTP id i090GcYc020055
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 00:16:39 GMT
Received: from e19f2n15.jp.ibm.com (d19relay01.sagamino.japan.ibm.com [9.189.5.43])
	by georgia.yamato.ibm.com (8.11.6p2-20030922/8.11.1) with ESMTP id i090HF9470510
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 09:17:15 +0900
Received: from D19ML114.sagamino.japan.ibm.com (d19av02.sagamino.japan.ibm.com [9.189.5.91])
	by e19f2n15.jp.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id i090HETX275696
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 09:17:14 +0900
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Subject: load_policy atomicity
Message-ID: <OF9293072A.D07D7FEF-ON49256E16.00015505-49256E16.000193AF@jp.ibm.com>
From: Tim Ebringer <EB17151@jp.ibm.com>
Date: Fri, 9 Jan 2004 09:17:11 +0900
Content-Type: multipart/alternative; boundary="=_alternative 000193AB49256E16_="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multipart message in MIME format.
--=_alternative 000193AB49256E16_=
Content-Type: text/plain; charset="US-ASCII"

Assuming there are no logical problems with a new policy, can a reload 
generate any nasty side effects within the policy enforcement module (race 
conditions, deadlocks, etc.)? In other words, is a policy reload atomic 
such that it will not try and load a new policy halfway through an access 
control or relabelling decision?

Cheers,

=============================================================
Tim Ebringer
Security Machinations                 Don't suspect a friend...
Tokyo Research Labs                          ...report him
IBM Japan
=============================================================
--=_alternative 000193AB49256E16_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Assuming there are no logical problems
with a new policy, can a reload generate any nasty side effects within
the policy enforcement module (race conditions, deadlocks, etc.)? In other
words, is a policy reload atomic such that it will not try and load a new
policy halfway through an access control or relabelling decision?</font>
<br>
<br><font size=2 face="sans-serif">Cheers,</font>
<br><font size=2 face="sans-serif"><br>
=============================================================<br>
Tim Ebringer<br>
Security Machinations &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; Don't suspect a friend...<br>
Tokyo Research Labs &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;...report him<br>
IBM Japan<br>
=============================================================</font>
--=_alternative 000193AB49256E16_=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
