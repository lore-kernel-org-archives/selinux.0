Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB5L8FqR015593
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2008 16:08:15 -0500
Received: from moss-saturn.epoch.ncsc.mil (moss-saturn [144.51.25.128])
	by facesaver.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB5L8FZf017142
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2008 16:08:15 -0500
Received: from moss-saturn.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-saturn.epoch.ncsc.mil (8.14.2/8.14.2) with ESMTP id mB5KRWcq002933
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2008 15:27:32 -0500
Received: (from dpquigl@localhost)
	by moss-saturn.epoch.ncsc.mil (8.14.2/8.14.2/Submit) id mB5KRWSe002931
	for selinux@tycho.nsa.gov; Fri, 5 Dec 2008 15:27:32 -0500
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [RFC] Provide a method for detecting labeling support on a file system(Take 2).
Date: Fri,  5 Dec 2008 15:27:29 -0500
Message-Id: <1228508852-2906-1-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


This is the second version of the patch set. It addresses James' concerns by
adding SE_ as a prefix to all of the new flags and fixes their use through the
code. 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
