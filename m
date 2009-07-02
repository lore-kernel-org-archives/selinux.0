Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6228HnR030452
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 22:08:17 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6227xfq023210
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 02:08:00 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n6228ECb029938
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 22:08:16 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n6228DMH015976
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 22:08:13 -0400
Received: from [10.16.10.57] (vpn-10-57.bos.redhat.com [10.16.10.57])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n6228Cxo023134
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 22:08:12 -0400
Message-ID: <4A4C168C.2040900@redhat.com>
Date: Wed, 01 Jul 2009 22:08:12 -0400
From: Christopher Pardy <cpardy@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re:[Patch 0/2] libsemanage: remember and retrieve dontaudit settings
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com> <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil> <4A4B9FA8.1040606@redhat.com>
In-Reply-To: <4A4B9FA8.1040606@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a heavily modified version of the patch I recently submitted. It 
provides 3 new functions: in libsepol sepol_get_disable_dontaudit; in 
libsemanage semanage_get_disable_dontaudit; in libselinux 
is_dontaudit_disabled. It also fixes issues with the previous patch.

The justification for this patch is the same as the one I posted 
earlier. Simply, there is currently no way to know if dontaudit rules 
are  enabled. Additionally once don't audit rules are turned they turn 
themselves off after policy rebuild (is that the desired functionality?) 
This patch provides  a way to check on both the current and pending 
state of the dontaudit rules and it maintains this state between policy 
rebuilds.

Signed-off-by Christopher Pardy <cpardy@redhat.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
