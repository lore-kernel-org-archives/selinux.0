Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93KpohQ025754
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 16:51:50 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93KpFGw011443
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 20:51:15 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k93KpocK001348
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 16:51:50 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k93KpoR3015440
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 16:51:50 -0400
Subject: Labeled networking at the end of the day Oct 2, 2006
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
Content-Type: text/plain
Date: Tue, 03 Oct 2006 16:53:19 -0400
Message-Id: <1159908799.10614.22.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Where do we stand with labeled networking today?

I published a kernel yesterday which is sorta close to having what we
need for labeled networking.  This kernel includes 3 patch sets.

1) netlabel changes to audit configuration changes
2) secid reconciliation patch set (9 patches) for secmark/ipsec
3) secid reconciliation patch to include netlabel

to even be close to a usable kernel we still need

1) fix for packets intended for ipsec tunnels to not be clear text.
Venkat indicated he had his own way he wanted to solve this problem on
Monday but I did not see any updates today.  This is a major problem
which must get fixed somehow, soon.
2) ipsec configuration auditing.  if we can do this in policy all the
better.  if not, I need a patch.
3) fix for netlabel caching race which can cause an opps.  Can be worked
around by using a sysctl (see the e-mail from paul moore)
4) fix for netlabel correctness in the same e-mail from paul he
mentioned correctness issues in -v3 inside selinux-ip-postroute-last

Testing with compat-net is not going to help us.  At this time I don't
believe that RHEL5 is going to ship with compat-net set (at least I
don't plan to right now)

Non-kernel code issues which must be resolved/explained
1) I also haven't heard any response to method's inquiry about the
meaning of some unlabeled_t denials namely

audit(1159877238.937:35): avc:  denied  { polmatch } for  
scontext=system_u:object_r:unlabeled_t:s0 
tcontext=root:system_r:unconfined_t:s0-s0:c0.c255 tclass=association

2) policy must be updated to include flow_in and flow_out for
unlabeled_t packets.  dwalsh made a policy to at least define these
which I may put on my people page in a bit.  Doesn't fix the denials,
but at least you can fix them yourself in modules.  Venkat has promised
a policy patch to fix these issues.  I certainly hope that will be soon.
3) policy must be updated to understand that by default traffic on the
loopback interface is going to be labeled and not unlabeled_t any more
(avahi_t I'm seeing hitting this)

Also we have at least 2 cleanups that need to be done to the labeled
networking code.

1) Patch 7/9 from the reconciliation thread should be cleaned up to
better use BUG_ON()
2) Patch 2/9 should drop polsec from the hook interface in security_ops

I think this is a pretty good outline of where we are, what is broken,
what is backported in my RHEL5 based kernel, and what needs to be
answered/cleaned up for the future.  If I missed something, if you see
something else wrong, if there is anything you can do to address any of
these point please don't hesitate to send an e-mail.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
