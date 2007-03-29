Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2TEPr3P031855
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2007 10:25:53 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2TEPlHY018176
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2007 14:25:48 GMT
Subject: class unique perms hashtab nprim
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 29 Mar 2007 10:25:53 -0400
Message-Id: <1175178353.14369.3.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was working on the kernel portion of object class discovery, and I
found something interesting.  I had assumed that the number of
permissions in the class would be the number of primaries in the class's
common permissions hashtab plus the unique permissions hashtab.  However
I found that the unique permissions nprim already is the number of
common perms + number of unique perms, i.e.

match = hashtab_search(policydb.p_classes.table,"file");
nperms = match->permissions.nprim + match->comdatum->permissions.nprim;

results in nperms being 37 because match->permissions.nprim is 20 and
match->comdatum->permissions.nprim is 17.  I would have expected the
former to be 3 instead of 20.  Is this the expected behavior?


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
