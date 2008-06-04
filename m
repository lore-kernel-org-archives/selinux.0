Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m546tGl9021405
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2008 02:55:16 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m546tFn4014649
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2008 06:55:16 GMT
Received: by an-out-0708.google.com with SMTP id d30so536421and.75
        for <selinux@tycho.nsa.gov>; Tue, 03 Jun 2008 23:55:15 -0700 (PDT)
Message-ID: <dd18b0c30806032355v44c0b5d2u965e3e7a65ba2e24@mail.gmail.com>
Date: Wed, 4 Jun 2008 06:55:15 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: NetLabel
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello; Hopefully this is the right list to post this question,
after looking at  NetLabel, in dmesg I couldn't help but see:
[    0.570655] NetLabel: Initializing
[    0.570660] NetLabel:  domain hash size = 128
[    0.570663] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.570730] NetLabel:  unlabeled traffic allowed by default

"unlabeled traffic allowed by default."
is this similar to selinux (handle_unkown=deny, if so is there an
option to change this to "unlabeled traffic deny."
Also is there a location for this in the kernel i.g. /proc/sys/net/*
regards;
-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
