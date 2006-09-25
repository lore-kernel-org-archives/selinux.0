Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PJ4hac024308
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 15:04:43 -0400
Received: from e32.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PJ43aU025020
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 19:04:09 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8PJ4WDT009876
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 15:04:32 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8PJ4OQH325142
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 13:04:24 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8PJ4N3C001510
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 13:04:24 -0600
Date: Mon, 25 Sep 2006 13:52:39 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200609251852.k8PIqd5w031210@faith.austin.ibm.com>
To: dwalsh@redhat.com, latten@austin.ibm.com, redhat-lspp@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: [Fwd: How should we handle polmatch avcs?]
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>Seems like we have a problem with current OpenSwan/IPSec stuff.
>
>I believe that some of these are bugs in the implementation.
>
>-------- Original Message --------
>Subject: 	How should we handle polmatch avcs?
>Date: 	Sat, 23 Sep 2006 06:59:30 -0400
>From: 	Daniel J Walsh <dwalsh@redhat.com>
>To: 	Stephen Smalley <sds@tycho.nsa.gov>, "Christopher J. PeBenito" 
><cpebenito@tresys.com>
>
>
>
>https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=207304
>
>allow initrc_t self:association polmatch;
>allow unlabeled_t initrc_t:association polmatch;
>allow unlabeled_t self:association polmatch;

I have run across the last of the 3 rules, and believe we do need it.
The first 2, I have not come across yet.

The last rule will definitely be needed by selinux_xfrm_state_pol_flow_match()
when sending unlabeled packets. Because, avc_has_perm() takes SA sid and 
policy sid to check. And when sending unlabeled packets, these will
both be unlabeled_t. 

I am not very familiar with openswan or pluto. My guess is they
do not contain modifications to use labeled ipsec. Thus this is
running just plain non-labeled ipsec.

The first two rules, I am not sure I understand where they are being 
required. Could not be the hook mentioned above, because in the case
of unlabeled packets, policy and SA sids will always be unlabeled_t.
The only other hook that uses polmatch is selinux_xfrm_policy_lookup()
and avc_has_perm() checks flow sid and policy sid. Again, in the case
of unlabeled packets, the policy sid should always be unlabeled_t. So,
target will always be unlabeled_t... maybe some sort of transition happens?


I added "polmatch" to kernel_sendrecv_unlabeled_association interface 
in kernel.if. Originally, the check in selinux_xfrm_policy_lookup()
was for association:sendto recvfrom. This was changed with the 
introduction of the latest set of patches to labeled ipsec that 
introduced, polmatch. Thus I figured we needed to add "polmatch"
here too.  

Also, selinux_xfrm_policy_lookup() will get called when an app wants 
to send a packet. It does an avc_has_perm()
using flow sid as source and policy sid as target.  I noticed that the 
flow_sid must sometimes be assigned the socket sid, because for a ping, 
my source sid aka flow_sid is ping_t. avc_has_perm() appears to check
if ping_t can access unlabeled_t. Thus, apps sending unlabeled
ipsec packets, will call selinux_xfrm_policy_lookup... so it seem
easier to just add polmatch in this interface. This interface gets called
by corenet_non_ipsec_sendrecv in corenetwork.if. I noticed most
apps/daemons and init call corenet_non_ipsec_sendrecv.

Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
