Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h62Jcr73013838
	for <selinux@tycho.nsa.gov>; Wed, 2 Jul 2003 15:38:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h62Jc0nJ021965
	for <selinux@tycho.nsa.gov>; Wed, 2 Jul 2003 19:38:01 GMT
Received: from hermes.jf.intel.com (fmr05.intel.com [134.134.136.6])
	by jazzswing.ncsc.mil  with ESMTP id h62Jbwhr021961
	for <selinux@tycho.nsa.gov>; Wed, 2 Jul 2003 19:37:59 GMT
Received: from petasus.jf.intel.com (petasus.jf.intel.com [10.7.209.6])
	by hermes.jf.intel.com (8.11.6p2/8.11.6/d: outer.mc,v 1.66 2003/05/22 21:17:36 rfjohns1 Exp $) with ESMTP id h62Jajh21192
	for <selinux@tycho.nsa.gov>; Wed, 2 Jul 2003 19:36:45 GMT
Received: from orsmsxvs040.jf.intel.com (orsmsxvs040.jf.intel.com [192.168.65.206])
	by petasus.jf.intel.com (8.11.6p2/8.11.6/d: inner.mc,v 1.35 2003/05/22 21:18:01 rfjohns1 Exp $) with SMTP id h62JY6b14145
	for <selinux@tycho.nsa.gov>; Wed, 2 Jul 2003 19:34:07 GMT
Received: from orsmsx331.amr.corp.intel.com ([192.168.65.56])
 by orsmsxvs040.jf.intel.com (NAVGW 2.5.2.11) with SMTP id M2003070212495712753
 for <selinux@tycho.nsa.gov>; Wed, 02 Jul 2003 12:49:57 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C340CF.DF05CADB"
Subject: Kallsyms patch
Date: Wed, 2 Jul 2003 12:26:44 -0700
Message-ID: <75EC4D5486CAC247B84AAAA6F96AA558FB263E@orsmsx402.jf.intel.com>
From: "Scarlata, Vincent R" <vincent.r.scarlata@intel.com>
To: "SeLinux Mailing List" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C340CF.DF05CADB
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I tried to install the 2.4.20 kallsyms patch to the current SE Linux
build and it seems that the SE Linux patch makes some of the same
changes that the kallsyms patch does which is causing problems for me
trying to patch it.
=20
Has anyone successfully applied a kallsyms patch to a 2.4.20 SE Linux
system?
=20
-Vin Scarlata

------_=_NextPart_001_01C340CF.DF05CADB
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Message</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1141" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D690480418-02072003><FONT face=3DArial size=3D2>I =
tried to install=20
the 2.4.20 kallsyms patch to the current SE Linux build and it seems =
that the SE=20
Linux patch makes some of the same changes that the kallsyms patch does=20
which&nbsp;is causing&nbsp;problems for me trying to patch=20
it.</FONT></SPAN></DIV>
<DIV><SPAN class=3D690480418-02072003><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D690480418-02072003><FONT face=3DArial size=3D2>Has =
anyone=20
successfully applied a kallsyms patch to a 2.4.20 SE Linux=20
system?</FONT></SPAN></DIV>
<DIV><SPAN class=3D690480418-02072003><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D690480418-02072003><FONT face=3DArial size=3D2>-Vin=20
Scarlata</FONT></SPAN></DIV></BODY></HTML>
=00
------_=_NextPart_001_01C340CF.DF05CADB--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
