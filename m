Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3DLR3j7031305
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2010 17:27:03 -0400
Received: from hades.sngx.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3DLQWVY003844
	for <selinux@tycho.nsa.gov>; Tue, 13 Apr 2010 21:26:33 GMT
To: selinux@tycho.nsa.gov
Subject: sudo + selinux
MIME-Version: 1.0
Date: Mon, 12 Apr 2010 14:30:10 -0500
From: James Cammarata <jimi@sngx.net>
Reply-To: jimi@sngx.net
Message-ID: <e2229269c988ce55126bc9fcc18f78c4@sngx.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi, we're looking towards running SELinux on RHEL5 in strict mode here,
however I'm not having any luck finding resources on configuring sudo to
work with SELinux properly.  Are there any guides/resources to getting this
working?  I've found some older mailing list threads that discuss adding
some new features to sudo to make it selinux-aware, but that doesn't seem
to have found it's way into RHEL5 yet (at least, as of 5.4).

Thanks,

James Cammarata

-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
