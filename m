Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA09069
	for <selinux@tycho.nsa.gov>; Wed, 29 May 2002 08:39:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA23446
	for <selinux@tycho.nsa.gov>; Wed, 29 May 2002 12:37:58 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA23442 for <selinux@tycho.nsa.gov>; Wed, 29 May 2002 12:37:58 GMT
Date: Wed, 29 May 2002 08:38:30 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: =?iso-8859-1?q?vishwakarma=20singh?= <vsingh014@yahoo.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: setuid problem
In-Reply-To: <20020529030941.3019.qmail@web14311.mail.yahoo.com>
Message-ID: <Pine.GSO.4.33.0205290834100.4237-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 29 May 2002, [iso-8859-1] vishwakarma singh wrote:

> I like that all the setuid programs are executed even
> if  new sid  assigned to them fails to comply to the
> rules of the policy (in this case program will be
> prevented  from executing ) . that is , i want to run
> all setuid programs  just like  simple linux . than
> what are the changes i should bring in ....

Execution of a setuid program doesn't imply any change in SID.  The
SELinux user identity attribute in the security context is independent of
the Linux uid, as explained in the Configuring the SELinux Policy report.
Setuid programs should run "just like simple linux", including the change
in the Linux uid.  No change required.  However, the program may
subsequently fail due to a lack of permission in the SELinux policy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
