Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA05292
	for <selinux@tycho.nsa.gov>; Wed, 22 May 2002 08:53:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA23843
	for <selinux@tycho.nsa.gov>; Wed, 22 May 2002 12:53:19 GMT
Received: from mx0.gmx.net (mx0.gmx.net [213.165.64.100])
	by jazzswing.ncsc.mil  with SMTP id MAA23839
	for <selinux@tycho.nsa.gov>; Wed, 22 May 2002 12:53:18 GMT
Date: Wed, 22 May 2002 14:53:18 +0200 (MEST)
From: Ian Sollars <ian.sollars@gmx.net>
To: selinux@tycho.nsa.gov
Cc: jaegert@us.ibm.com, aherzog@mitre.org, mayerf@tresys.com
MIME-Version: 1.0
Subject: Re: Policy creation RFC
Message-ID: <30373.1022071998@www37.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This has been interesting. I must confess I'm a little out of my
depth here. I was looking at the possibility of writing a policy
creation tool to keep me occupied. The idea was to have wizards for
some basic policy categories (user, daemon, etc.) and some visual
representation of the policy for more detailed manipulation.

However, all I have to show so far is plenty of waste paper. I
started looking at object models and storage - I was considering an
RDBMS or XML, and one effort I've been sent a link to[1] uses LDAP -
and at this point I realised just how non-trivial this would be.

I'm still interested in writing something, but it would seem that
there are issues such as semantics and interoperability that should
be addressed first, and are a little over my head.

Ian

[1] http://www.praefect-sys.com/en/VPB/index.php would appear to have
a wider focus, but is (or will) have some capability with respect to
selinux.

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
