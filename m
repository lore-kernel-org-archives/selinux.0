Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2QCixs2030412
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 08:44:59 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2QCivDC000972
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 12:44:57 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m2QCirev012934
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 08:44:53 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m2QCiq3i027290
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 08:44:52 -0400
Received: from vpn-15-27.rdu.redhat.com (vpn-15-27.rdu.redhat.com [10.11.15.27])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m2QCiqJB000747
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 08:44:52 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: selinux@tycho.nsa.gov
Subject: USER_AVC vs USER_MAC_POLICY_LOAD ?
Date: Wed, 26 Mar 2008 08:44:45 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803260844.45708.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Lately dbus has taken to sending this again:

localhost  dbus: Can't send to audit system: USER_AVC avc:  received 
policyload notice (seqno=2) : exe="?" (sauid=81, hostname=?, addr=?, 
terminal=?)

This is clearly not an AVC - which is an access control decision. This is a 
policy load - something entirely different. The audit system wants to have 1 
type = 1 meaning. We need to be able to differentiate information flow 
decisions from everything else.

I will be releasing an update to the audit system this week. I can add 
USER_MAC_POLICY_LOAD type to libaudit.h if that would help solve the problem. 
This does beg the question, though, do we really want these events being 
recorded? If so, I think we should use an appropriate type and not USER_AVC.

Thanks,
-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
