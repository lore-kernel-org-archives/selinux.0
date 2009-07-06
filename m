Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n66I151A000410
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 14:01:05 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n66I1io3004698
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 18:01:45 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n66I14Pk010542
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 14:01:04 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n66I13OE030960
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 14:01:04 -0400
Received: from [10.16.3.86] (dhcp-100-3-86.bos.redhat.com [10.16.3.86])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n66I13fs008587
	for <selinux@tycho.nsa.gov>; Mon, 6 Jul 2009 14:01:03 -0400
Message-ID: <4A523BDD.60006@redhat.com>
Date: Mon, 06 Jul 2009 14:01:01 -0400
From: Christopher Pardy <cpardy@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [Patch 3/2 v2] semodule: maintain old functionality
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>	 <4A4B9FA8.1040606@redhat.com> <4A4C168C.2040900@redhat.com>	 <4A4C17D1.3060208@redhat.com>	 <1246538797.13464.277.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CBC6C.5090709@redhat.com>	 <1246544004.13464.299.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CC469.3050805@redhat.com>	 <1246545328.13464.317.camel@moss-pluto.epoch.ncsc.mil>	 <4A4CD320.2090706@redhat.com>	 <1246554554.13464.356.camel@moss-pluto.epoch.ncsc.mil>	 <4A51ED89.8010001@redhat.com>  <4A51EEA5.4070802@redhat.com>	 <1246888018.28321.23.camel@moss-pluto.epoch.ncsc.mil> <1246888326.28321.26.camel@moss-pluto.epoch.ncsc.mil> <4A520D47.4040708@redhat.com> <4A52100C.3010302@redhat.com> <4A523752.5000404@redhat.com>
In-Reply-To: <4A523752.5000404@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------080409040102030802020702"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080409040102030802020702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Patch for semodule command
semodule -B
Will now turn on dontaudit rules
semodule -DB
Will turn off dontaudit rules.
With other patch all other semanage commands will maintain state.
 
Created by Dan Walsh
 
Signed-off-by: Christopher Pardy <cpardy@redhat.com>

---
 policycoreutils/semodule/semodule.c |    3 +++
 1 file changed, 3 insertions(+)

diff -urpN selinux.orig3/policycoreutils/semodule/semodule.c selinux/policycoreutils/semodule/semodule.c
--- selinux.orig3/policycoreutils/semodule/semodule.c	2009-07-06 13:26:25.802165404 -0400
+++ selinux/policycoreutils/semodule/semodule.c	2009-07-06 13:58:22.572415382 -0400
@@ -421,6 +421,9 @@ int main(int argc, char *argv[])
 			semanage_set_rebuild(sh, 1);
 		if (disable_dontaudit)
 			semanage_set_disable_dontaudit(sh, 1);
+		else if(build)
+			semanage_set_disable_dontaudit(sh,0);
+
 		result = semanage_commit(sh);
 	}
 

--------------080409040102030802020702
Content-Type: text/plain;
 name="selinux.patch3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="selinux.patch3"

diff -urpN selinux.orig3/policycoreutils/semodule/semodule.c selinux/policycoreutils/semodule/semodule.c
--- selinux.orig3/policycoreutils/semodule/semodule.c	2009-07-06 13:26:25.802165404 -0400
+++ selinux/policycoreutils/semodule/semodule.c	2009-07-06 13:58:22.572415382 -0400
@@ -421,6 +421,9 @@ int main(int argc, char *argv[])
 			semanage_set_rebuild(sh, 1);
 		if (disable_dontaudit)
 			semanage_set_disable_dontaudit(sh, 1);
+		else if(build)
+			semanage_set_disable_dontaudit(sh,0);
+
 		result = semanage_commit(sh);
 	}
 

--------------080409040102030802020702--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
