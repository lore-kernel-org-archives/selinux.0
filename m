Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5ULZ63j006845
	for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 17:35:06 -0400
Received: from g1t0027.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5ULYnHr017759
	for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 21:34:49 GMT
Received: from g1t0038.austin.hp.com (g1t0038.austin.hp.com [16.236.32.44])
	by g1t0027.austin.hp.com (Postfix) with ESMTP id 35CE538839
	for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 21:34:35 +0000 (UTC)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by g1t0038.austin.hp.com (Postfix) with ESMTP id 070AE30046
	for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 21:34:34 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl.fc.hp.com (Postfix) with ESMTP id 314A239C007
	for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 15:34:34 -0600 (MDT)
Received: from ldl.fc.hp.com ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UcXWHqHGWwNG for <selinux@tycho.nsa.gov>;
	Tue, 30 Jun 2009 15:34:32 -0600 (MDT)
Received: from flek.localnet (squirrel.fc.hp.com [15.11.146.57])
	by ldl.fc.hp.com (Postfix) with ESMTP id B2B6A39C003
	for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 15:34:32 -0600 (MDT)
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: The problem with TUN/TAP devices
Date: Tue, 30 Jun 2009 17:34:31 -0400
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200906301734.31986.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Unfortunately we have a problem with the network access controls and TUN/TAP 
devices.  The basic issue is that packets entering the stack via a TUN device, 
e.g. QEMU/KVM guest instance operating with a bridged network configuration, 
do not have a fully initialized sock associated with them.  I say "fully 
initialized" because the basic initialization has been done (memory allocated, 
initial values set to SECINITSID_UNLABELED, etc.) but the last step where we 
assign the sock a label/SID never happens.  Why?  Because the TUN driver code 
only calls sk_alloc() and nothing else in the TUN code paths finish the 
SELinux sock setup.

Okay, so what?  Well, the problem is that the SELinux IP postrouting code 
treats the packet's sock label (the one that is still set as unlabeled_t in 
the TUN case) as the originating peer label; in short it looks like packets 
sent from your QEMU/KVM instance are unlabeled_t instead of my_guest_t:s3.  
Needless to say this is not ideal.

So how do we fix it?  Well, there are a two options that I can think of right 
now (feel free to add to the list):

1. Set the sock's label/SID in sk_alloc()
2. Introduce a new hook to set the label/SID of a sock and call it from
   tun_set_iff()

The problem with #2 is that it introduces a new (basically TUN specific) hook 
to do something silly.  Important, but still kinda silly.  The problem with #1 
is that we currently set the sock's label/SID in selinux_socket_post_create() 
and match it with the inode's label/SID which has the potential to get ugly (I 
haven't verified all of those cases yet).  However, there may be an 
alternative, call it #1a, where set label the sock in sk_alloc() and then use 
the sock's label to set the inode's label in socket_post_create(); this should 
solve the potential ugliness.

Thoughts?

There is also a somewhat related issue involving persistent TUN/TAP devices 
but I'd like to resolve this before getting deeper into that problem.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
