Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAPE32Rb013790
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 09:03:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAPE2Sp5024130
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 14:02:28 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hAPE2Rt0024119
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 14:02:27 GMT
Date: Tue, 25 Nov 2003 14:02:56 +0000
From: Dale Amon <amon@vnl.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: Still no authentication from new debian packages
Message-ID: <20031125140255.GI2718@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been working on this in the background for 
many weeks now, trying to build an selinux
image disk that simply works when rsync'd. I've
<ahem> a bit more work ahead yet.

I'm still not getting past the problem with the 
packages. I do not get the expected role prompt;
and newrole goes to the password file, which it
shouldn't.

This still looks like a wrong package set but everything
updates flawlessly from Russell's repository and I 
cannot see any unexpected version numbers. I've got
another system that was built from Colin's old package
set some months ago and it works fine. I can't see 
why one package set works and the other does not.

I'd like very much to compare notes with someone else
who has installed a virgin debian sid with Russell's
new selinux packages on top. 

What is the most likely package to be the guilty
party? 

Fortuneately the -test10 kernel has made debugging
a bit easier on my test box... the NIC's work now.
Before the only way to change a package was to 
boot off an NFS floppy, flatten the whole fs (the
small boot kernel couldn't handle the xattr and
security attr) and rsync the entire disk. Let's just
say that it didn't require a lot of attention but
didn't allow for more than one or two test runs in
a day...

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
