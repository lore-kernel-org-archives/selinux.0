Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3RF3UVN016613
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 11:03:30 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3RF3TEq020673
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 15:03:29 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l3RF3SZf016303
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 11:03:28 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3RF3S2u009089
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 11:03:28 -0400
Received: from [10.11.15.28] (vpn-15-28.rdu.redhat.com [10.11.15.28])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3RF3SH7001121
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 11:03:28 -0400
Subject: Next policyrep patches
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 11:03:28 -0400
Message-Id: <1177686208.15215.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here is my plan for the next set of policyrep patches:

1. Basic policy objects (sepol/policy.h). Basic object system and
top-level objects for the policy representation.

2. Policy components (each as a separate patch). For example, type
declarations (which would include type and typealias) would be a patch
adding include/sepol/types.h and src/types.c.

For existing components (like booleans), I would like to merge the
record and component files. So booleans.h and boolean_record.h would be
merged. Objections?

3. When all of the components are merged I'll send the parser changes.
This is the first patch that will cause breakage. Any objection to
checkmodule being broken for a while?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
