Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lAGK3PDP017748
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 15:03:25 -0500
Subject: [RFC Labeled NFS] Labeling support for NFSv4
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: labeled-nfs@linux-nfs.org, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 16 Nov 2007 15:03:24 -0500
Message-Id: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is the first set of patches for the labeled-nfs work since early August.
Much has changed since then and we have a reasonably functional prototype of
the dumb server implementation. This patch series provides the ability to
retrieve and set labels on the server, provides callback notification for label
changes on the server, and life-cycle management for the fattr structure which
is used to transport the labels.

The patch series should apply on top of any 2.6.24-rc2 kernel and I know for a
fact that it will apply on top of commit 
9418d5dc9ba40b88737580457bf3b7c63c60ec43 in Linus's git tree. To get the tree
up and running for testing just apply the patch and have fun. 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
