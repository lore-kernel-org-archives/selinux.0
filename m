Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h82HC2La017741
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 13:12:03 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h82HAUpQ015375
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 17:10:30 GMT
Received: from mx1.utulsa.edu (mx1.utulsa.edu [129.244.3.226])
	by jazzswing.ncsc.mil  with SMTP id h82HATQX015372
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 17:10:30 GMT
Message-ID: <3F54CF05.8050608@utulsa.edu>
Date: Tue, 02 Sep 2003 12:10:29 -0500
From: Nick Davis <nicholas-davis@utulsa.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: glibc rpm install error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I've been trying to get SELinux 2.6 up and running on a RH9 box, and am 
having some difficulties.  I can compile/install the kernel just fine, 
but I run into problems when building the userspace tools.  
Specifically, I'm trying to get the SRPMs all built.  The source RPMs 
all install and build, leaving me with several RPMS in the i386 
directory.  I've managed to get everything working fine (i.e. RPMs all 
install without errors) except the SELinux-patched glibc RPMs.  Here's 
the error I get:

Error: %postun(glibc-2.3.2-27.9.selinux.0) scriptlet failed, exit status 121

 From that point on, any command I run gives a Segmentation Fault.  I 
tried installing the glibc RPMs last, after all of the other utils, but 
the same thing happens.

Has anyone run into this problem before, or have an idea on what the 
problem might be?

Thanks in advance,

Nick Davis
Center for Information Security
University of Tulsa



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
