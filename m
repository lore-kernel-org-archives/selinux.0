Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA23580
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 08:24:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1PDOUI07601
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 13:24:30 GMT
Received: from RelaySNC.nai.com (relaysnc.nai.com [161.69.3.67])
        by jazzband.ncsc.mil  with ESMTP id h1PDOTf07592 for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 13:24:30 GMT
Received: from scwsout1.nai.com (scwsout1.nai.com [161.69.3.73])
	by RelaySNC.nai.com (Switch-2.2.4/Switch-2.2.4) with SMTP id h1PDDE008109
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 07:13:14 -0600 (CST)
Message-ID: <8894CA1F87A5D411BD24009027EE783801C14C8E@md-exchange1.na.nai.com>
From: Kelly_Djahandari@nai.com
To: mayerf@tresys.com, selinux@tycho.nsa.gov
Subject: RE: policy Makefile patch
Date: Tue, 25 Feb 2003 05:27:12 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've updated sourceforge with Frank Mayer's policy Makefile patch. Thanks
Frank for the patch.

Kelly Djahandari
Network Associates Laboratories


> -----Original Message-----
> From: Frank Mayer [mailto:mayerf@tresys.com]
> Sent: Monday, February 24, 2003 12:20 PM
> To: 'Frank Mayer'; selinux@tycho.nsa.gov
> Subject: RE: policy Makefile patch
> 
> 
> Sorry there was a problem with the last patch file...here is a
> correction.  Frank
> 
> > -----Original Message-----
> > From: owner-selinux@tycho.nsa.gov 
> [mailto:owner-selinux@tycho.nsa.gov]
> On
> > Behalf Of Frank Mayer
> > Sent: Friday, February 21, 2003 5:14 PM
> > To: selinux@tycho.nsa.gov
> > Subject: policy Makefile patch
> > 
> > Attached is a patch that changes the policy make file.  The problem
> was
> > that the users file was being run through m4, but user names must
> > support any name that might be used for a Linux user.  Any name that
> is
> > also used as a macro name, or something as simple as "dnl" 
> would cause
> > an error if defined as a user in the policy.  This patch excludes
> users
> > (as well as the flask definitions and the security context
> > specifications) from the m4 processing, but still has all the te and
> > rbac files, as well as the constraints file, pass through m4.
> > 
> > Frank
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
