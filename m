Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA14392
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 08:30:44 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA26939
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 12:29:07 GMT
Received: from smails.columbia.tresys.com ([66.200.42.2])
        by jazzband.ncsc.mil  with ESMTP id MAA26935 for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 12:29:06 GMT
From: "david caplan" <dac@tresys.com>
To: "Samarth  Sharma" <samarth7880@rediffmail.com>, <selinux@tycho.nsa.gov>
Subject: RE:
Date: Fri, 9 Aug 2002 08:32:34 -0400
Message-ID: <GBEAJBKHFOBIBBJBCGAGIEGFCEAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20020809120131.14012.qmail@webmail10.rediffmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The security checks performed by the SELinux mechanism are orthogonal to the
normal/standard Linux permission checks.  I.e., both most be satisfied for
access to be granted.  For example, read access to a file is granted only if
the user is allowed read access via the protection bits *and* the SELinux
policy allows the domain, which the user is currently in, access to the
object type the file is labeled with.

So, if the protection bits preclude the user from reading the file *or*
SELinux does not specifically allow access to the object from the current
domain then access is denied.

David

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
Behalf Of Samarth Sharma
Sent: Friday, August 09, 2002 8:02 AM
To: selinux@tycho.nsa.gov
Subject:


hi,
  is it possible to override the Linux uid permission checks using
the SELinux policy??
thanks
samarth
__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/


--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
