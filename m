Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3HIGckL015021
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 14:16:38 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3HIGb88000464
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 18:16:37 GMT
Received: by an-out-0708.google.com with SMTP id c38so43750ana.75
        for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 11:15:54 -0700 (PDT)
Message-ID: <dd18b0c30804171048n5bb2968dy355aa500452422a4@mail.gmail.com>
Date: Thu, 17 Apr 2008 17:48:01 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: memory_device_t
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello; I have a quick question. When using a macbook pro there is a
tool(radeontool)  that I use to lower the gpu power to a low state
causing significant cooling of the system hardware. The problem I run
into is I'm receiving a: libsepol.check_assertion_helper: assertion on
line 9293 violated by allow sysadm_t memory_device_t:chr_file { read
write };
Whenever trying to write the allow rule into the policy. What would be
the best step to allow this tool?
Also I noticed when trying to run VirtualBox there seems to be a
missing audit message that is important for the application to start.
Keep in mind this was about 3 weeks ago, with the latest svn refpolicy
at the time, so the problem might already have be taken care of.
Other than that, with the latest refpolicy and kernel(git) everything
seem to be running quite smoothly.
regards;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
