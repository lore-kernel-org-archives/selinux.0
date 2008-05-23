Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4NFsT7e000436
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2008 11:54:29 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4NFsSLq013250
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2008 15:54:29 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m4NFsSRZ003355
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2008 11:54:28 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4NFsR0v009362
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2008 11:54:28 -0400
Received: from holycross.boston.devel.redhat.com (holycross.boston.devel.redhat.com [10.16.60.79])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m4NFsRnJ025883
	for <selinux@tycho.nsa.gov>; Fri, 23 May 2008 11:54:27 -0400
Message-ID: <4836E8CD.2030806@redhat.com>
Date: Fri, 23 May 2008 11:54:53 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: We need to do a better job of merging policy into Refpolicy
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chris has done a brilliant job up to this point but I see my differences
between the upstream growing astronomically.  This is causing other
distributions to not be able to take advantage of SELinux use in Fedora
and  similarly it is getting harder for me to merge in upstream changes.

Currently the patch that I am applying to Refpolicy is huge

# wc policy-20080509.patch
38260   95488 1171253 policy-20080509.patch

And I don't see how we can get this merged without huge amounts of
effort by me or Chris and neither of us have the time.

I think we need a way for third parties to come in an peruse the diffs
and apply the no brainer changes to policy.

We need the ability for a couple of acks to get minor changes in,
without Chris having to look at each change.

Most of my changes to policy come about via bugzilla's so I fix a
problem reported by an AVC and update policy.   I have come up with a
system of hundreds/thousands of small changes, but it does not make
merging upstream easy.

I also have made some grand sweeping changes in the same pool that Chris
does not currently agree with or is moving in a slightly different
direction (Roles Based Home Dirs)

So I guess I am saying help.

Can we setup a system of policy Triages, which can look at the policy
patches and apply small obvious changes?

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
