Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAKFN38D030942
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 10:23:04 -0500
Received: from e1.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAKFLNJs021934
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 15:21:24 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAKFNIqI005124
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 10:23:18 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kAKFMvFF152680
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 10:22:58 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kAKFMut1016430
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 10:22:57 -0500
Subject: Re: [redhat-lspp] labeled ipsec policy
From: Joy Latten <latten@austin.ibm.com>
To: Paul Moore <pcmoore@engin.umich.edu>
Cc: redhat-lspp@redhat.com, selinux@tycho.nsa.gov, cpebenito@tresys.com,
        jbrindle@tresys.com
In-Reply-To: <200611201000.06118.pcmoore@engin.umich.edu>
References: <1163802623.17737.398.camel@faith.austin.ibm.com>
	 <200611201000.06118.pcmoore@engin.umich.edu>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 09:09:42 -0600
Message-Id: <1164035382.17737.408.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-11-20 at 10:00 -0500, Paul Moore wrote:
> On Friday 17 November 2006 5:30 pm, Joy Latten wrote:
> > The following policy enables labeled ipsec to run
> > in enforcing mode. I configure labeled ipsec in sysadm_r role.
> > Thus the rules I needed were specific to this role.
> 
> I'll let the policy gurus comment on the rest of the policy, but I think that 
> we would want only the secadm_r role (in the MLS/LSPP policy) to be able to 
> configure labeled IPsec.  Yes?
> 
Actually, I wondered about this too. But when I took a look at the
policy source, I noticed that in userdomain.te, sysadm_t was allowed
to execute ipsec programs ipsec_exec_mgmt(sysadm_t), so I just assumed I
should use sysadm_r role. Not sure if this was correct or not. Tried
secadm_r role out of curiousity and got quite a lot of avc denied
messages. So went with sysadm_r. :-)

If secadm_r should be used, please let me know as I would need to get
labeled ipsec working with policy in enforcing mode.

Joy 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
