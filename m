Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8PKmx9u032715
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 16:48:59 -0400
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8PKmwRe029602
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 20:48:58 GMT
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.11.136.114])
	by atlrel9.hp.com (Postfix) with ESMTP id 65A84341CB
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 16:48:28 -0400 (EDT)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH 0/2] Series short description
To: selinux@tycho.nsa.gov
Date: Tue, 25 Sep 2007 16:48:19 -0400
Message-ID: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset has two patches in it which I would like to get some feedback
on.  The first patch adds a functionality/compatability version number to the
policy so that we can add new functionality to the kernel which would lie
dormant until the correct policy was loaded - it is not intended to replace
Eric's undefined classes/perms work but to compliment it.  The second patch
is the first step towards a single set of access checks for the different
peer labeling mechanisms, NetLabel and labeled IPsec, by providing a single
function to determine the peer label of an incoming packet.  The ideas behind
both patches have been discussed in the past, but I'd like to see if there
are any new concerns now that people can see what an implementation would
look like.  I'm particularly interested in people's take on the policy
changes.  The approach presented in this patch seems to be sane and low risk
to me but I'm hoping some of you with more experience tinkering with the
policy code could take a look and comment.

This is an RFC quality patchset which means it does boot and passes a few
simple tests but will most likely shave your cat if your turn your back to it
for more than a few minutes.

--
paul moore
linux security @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
