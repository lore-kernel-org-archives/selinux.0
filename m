Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAQ4qQRb017949
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 23:52:26 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAQ4ppp5023146
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 04:51:51 GMT
Received: from efficax.net (rrcs-sw-24-153-230-186.biz.rr.com [24.153.230.186])
	by jazzswing.ncsc.mil  with ESMTP id hAQ4pot0023143
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 04:51:51 GMT
Received: from efficax.net (hawaii [127.0.0.1])
	by efficax.net (8.12.8/8.12.8) with ESMTP id hAQ4qH8L028261
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 22:52:17 -0600
Received: (from nick@localhost)
	by efficax.net (8.12.8/8.12.8/Submit) id hAQ4qHR1028259
	for selinux@tycho.nsa.gov; Tue, 25 Nov 2003 22:52:17 -0600
Subject: 
From: Nick <nagray@austin.rr.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1069822336.3447.1234.camel@hawaii>
Mime-Version: 1.0
Date: Tue, 25 Nov 2003 22:52:17 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve et Al.

Once the initial load has been done and the policy is in place, I should
be able to remove the development dirs (selinux-usr and linux-2.4) and
the policy source (/etc/security/selinux/src) from from my pseudo
production box and build new policies on my development server from the
/etc/security/selinux/src directory which I will then propagate over to
the system production system.

What about the file contexts, I didn't see these in the policy
directory?

I am working on several things and moving pretty fast so I may have
missed it.

I am going to have to create a /tcb directory and root all trusted code
there (policy, file contexts, binaries). I have been directed to move in
the direction of CMW. What are your thoughts on this.

Nick Gray

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
