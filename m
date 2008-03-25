Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2PFwfPI019146
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 11:58:41 -0400
Received: from an-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2PFwbh6005487
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 15:58:37 GMT
Received: by an-out-0708.google.com with SMTP id c38so1075895ana.75
        for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 08:58:27 -0700 (PDT)
Message-ID: <dd18b0c30803250831i36f92d9fv5fa5b1b532cb9f8@mail.gmail.com>
Date: Tue, 25 Mar 2008 15:31:14 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: avc's
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello; I've noticed with using the latest refpolicy(svn) and kernel,
after the policy compile and then a reboot im only receiving a few(10
or so) avc's,
then after I go and allow those avc's and reboot the next ten or so
would appear. Is this something with the kernel, or libraries.
when I issue dmesg it gives me something about: 200 messages
suppressed. I thought it was because of the refpolicy being in svn and
under heavy development, but I tried a stable refpolicy and received
the same results.

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
