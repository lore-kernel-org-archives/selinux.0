Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7UK3mX9018596
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 16:03:48 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7UK3luK010457
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 20:03:48 GMT
Received: from smtp1.fc.hp.com (smtp.cnd.hp.com [15.15.136.127])
	by atlrel7.hp.com (Postfix) with ESMTP id B95B43A56D
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 16:03:05 -0400 (EDT)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by smtp1.fc.hp.com (Postfix) with ESMTP id 920791B4BB6
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 20:02:35 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl.fc.hp.com (Postfix) with ESMTP id 7A01939C1A0
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 14:02:35 -0600 (MDT)
Received: from ldl.fc.hp.com ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id onhEQ9ZbbAVx for <selinux@tycho.nsa.gov>;
	Thu, 30 Aug 2007 14:02:32 -0600 (MDT)
Received: from [16.116.100.36] (unknown [16.116.100.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ldl.fc.hp.com (Postfix) with ESMTP id C2EC339C19D
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 14:02:31 -0600 (MDT)
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: Backwards compatibility (proposal for a new compat_net like flag)
Date: Thu, 30 Aug 2007 16:02:25 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708301602.27272.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As you may have noticed there has been a _lot_ of discussion lately about the 
labeled networking functionality in SELinux and how to both improve the 
existing functionality as well as introduce new functionality to enable 
SELinux to be used in more and more places.  Several different things were 
debated including fallback peer labels, packet flow control, loopback 
labeling, and the use of unified access checks for the different peer 
labeling mechanisms (NetLabel, labeled IPsec).

While it should be possible to implement some of the new ideas while retaining 
backwards compatibility (fallback labels, loopback labeling) some other ideas 
would most likely introduce problems when used with older policy (packet flow 
control, unified access checks).  Unfortunately, as discussed numerous times 
before, we don't presently have a good way to select kernel behavior at 
runtime and if we want to move forward with some of the new labeled 
networking ideas we need a way to preserve the existing behavior.

To help solve this problem I'd like to propose we introduce a new tunable, 
similar to the existing compat_net flag, but instead of it being a simple 
boolean value I would like to implement it as an integer value.  This new 
tunable, let's call it "select_net", would act as a versioning value for the 
network access controls.  The existing behavior would be used when 
select_net==0 and the new behavior would be used when select_net==1; if we 
needed to introduce new checks in the future which could break compatibility 
we only enable them when select_net==2.

Thoughts?  It's not perfect, I know, but I'd like to be able to start moving 
forward with some of these labeled networking changes but the compatibility 
concerns are crippling us ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
