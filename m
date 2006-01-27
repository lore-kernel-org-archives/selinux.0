Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0RJWVXf009672
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 14:32:31 -0500 (EST)
Received: from e36.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0RJWTC1004177
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 19:32:29 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0RJWU7W011347
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 14:32:30 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0RJUeO9264668
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 12:30:40 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k0RJWTS1003817
	for <selinux@tycho.nsa.gov>; Fri, 27 Jan 2006 12:32:29 -0700
Subject: Best method for obtaining the 'sid' of a task?
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Cc: Linux Audit Discussion <linux-audit@redhat.com>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 13:38:44 -0600
Message-Id: <1138390724.7916.21.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

The audit subsystem would like to collect and record security label
information on a user process emitting audit messages.  Due to the
asynchronous nature of netlink, the kernel cannot rely on the pid sent
in the kernel-bound netlink packet because the pid may have already been
recycled and the information recorded to the audit log, incorrect.
Furthermore, we're not permitted to package the security label with the
kernel-bound message itself due to the potential of spoofing.  Thus, the
solution seems to be similar to that of login uid, where we package the
sid with the kernel-bound netlink packet at time of delivery when we
know we have the right process (because we are running as that process).
This guarantees that the sid cannot be spoofed and that we're in fact
sending the correct sid.  Once the kernel receives this packet, it can
then resolve the sid to the correct security label.  One of the pitfalls
of this approach may be that the sid disappears because policy is
reloaded while the packet is in transit.  Is this correct?  I think, in
terms of an IT security evaluation, we can make the assumption that this
won't be done.  Aside from this concern, the question I have is this:

"What is the best way to do this?"

Because I am not exposed to: task_security_struct in net/af_netlink.c, I
cannot simply do a:

if (current->security)
	NETLINK_CB(skb).selinux_sid = current->security->sid;

So I did a little digging and I thought perhaps the security hook,
selinux_getprocattr(), could be modified such that I can pass into it
&NETLINK_CB(skb).selinux_sid and obtain the 'sid' in addition to the
context since we're already obtaining the sid there.  The disadvantage I
see here, is that it changes the interface.  I'm not sure how sensitive
people are to this.  Are there any alternative (possibly better)
suggestions?

Thanks.

-tim


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
