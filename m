Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5SHbfgA005829
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2005 13:37:41 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5SHaMxl019940
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2005 17:36:22 GMT
Subject: Groups in the alternative user solution
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: kmacmillan@tresys.com, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 28 Jun 2005 13:34:36 -0400
Message-Id: <1119980076.4806.23.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So, how will groups work.

In particular,

a user belongs to multiple groups, each of which
may have a selinux user mapping, in addition to
the user herself possibly having a corresponding
selinux user. Also, there's the default mapping.

- How should the selection work?
- What would be the useradd interface for mapping
a user to a selinux user?
- What would be the interface for mapping a group
to a selinux user?





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
