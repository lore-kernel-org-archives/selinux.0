Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l05GQgdb024837
	for <selinux@tycho.nsa.gov>; Fri, 5 Jan 2007 11:26:42 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l05GRRY9005259
	for <selinux@tycho.nsa.gov>; Fri, 5 Jan 2007 16:27:28 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l05GRR4j008397
	for <selinux@tycho.nsa.gov>; Fri, 5 Jan 2007 11:27:27 -0500
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l05GRRlq003644
	for <selinux@tycho.nsa.gov>; Fri, 5 Jan 2007 11:27:27 -0500
Received: from [10.11.14.221] (vpn-14-221.rdu.redhat.com [10.11.14.221])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l05GRQAt011680
	for <selinux@tycho.nsa.gov>; Fri, 5 Jan 2007 11:27:26 -0500
Message-ID: <459E7C60.8070308@mentalrootkit.com>
Date: Fri, 05 Jan 2007 11:27:12 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: [PATCH] check for handle creation failures in seobject
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

seobject.py assumes that handle creation always succeeds, though this is 
not always the case. This patch checks for that failure.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

diff -r 4400130009b8 policycoreutils/semanage/seobject.py
--- a/policycoreutils/semanage/seobject.py	Fri Jan 05 11:19:01 2007 -0500
+++ b/policycoreutils/semanage/seobject.py	Fri Jan 05 11:24:32 2007 -0500
@@ -208,6 +208,9 @@ class semanageRecords:
  class semanageRecords:
  	def __init__(self):
  		self.sh = semanage_handle_create()
+                if not self.sh:
+                       raise ValueError(_("Could not create semanage 
handle"))
+
  		self.semanaged = semanage_is_managed(self.sh)

  		if not self.semanaged:

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
