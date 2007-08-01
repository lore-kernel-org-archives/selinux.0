Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l71K6HpU025587
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 16:06:17 -0400
Received: from moss-terrapins.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l71K6FpI005681
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 20:06:16 GMT
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov, labeled-nfs@linux-nfs.org
Subject: [RFC] SENFS: MAC labeling support for NFSv4
Date: Wed,  1 Aug 2007 16:02:05 -0400
Message-Id: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is the first set of patches attempting to provide a generic framework for
MAC labeling in NFSv4. This patch set is based heavily off of the patch from
Sparta that was circulated privately in our discussion. It contains several new
LSM hooks to provide a method for setting the incore inode data and encoding
security information for passing across the wire in a module independent
manner. This patch set does not provide a method for setting the label on the
server from the client but provides the method for encoding those labels on the
client. The patch applies on top of James Morris's SELinux git tree at git
commit hash 80ba80a9bf25d251237694c3fcee850a73324532. I am currently
maintaining these patches using guilt so if you have any patches for me to add
to the set or to fold into the current patch set please mail them to the list
and I will add them to the next round of patches.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
