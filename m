Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2PIo66G007578
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 14:50:06 -0400
Received: from an-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2PIo0tT018512
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 18:50:02 GMT
Received: by an-out-0708.google.com with SMTP id c38so1096381ana.75
        for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 11:49:55 -0700 (PDT)
Message-ID: <dd18b0c30803251142o13d31368je67ab4cb57dfda3c@mail.gmail.com>
Date: Tue, 25 Mar 2008 18:42:50 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: avc's
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for the help, I looked at /proc/system/kernel/printk_ratelimit
and it seems to be set at 5. From with the info on a denial of service
with setting this to 0, then I'm going to just leave it alone.
My main concern was making sure there was'nt a problem, and with what
the info you provided it seems to be o.k.
better to be patient writing rules than in a hurry.

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
