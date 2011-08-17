Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7H5BmNQ011101
	for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2011 01:11:48 -0400
Received: from nm25.bullet.mail.sp2.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p7H5BjCP022995
	for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2011 05:11:46 GMT
Message-ID: <4E4B4CF8.6080800@schaufler-ca.com>
Date: Tue, 16 Aug 2011 22:09:12 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: inclusion of selinux.h in cred.h
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Is there some reason that linux/selinux.h is
#included in linux/cred.h?

I've been building kernels with the inclusion
commented out and I have encountered no problems.

It's not a problem, but I am curious.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
