Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m29JhjiT008452
	for <selinux@tycho.nsa.gov>; Sun, 9 Mar 2008 15:43:45 -0400
Received: from fg-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m29JhfBt018973
	for <selinux@tycho.nsa.gov>; Sun, 9 Mar 2008 19:43:41 GMT
Received: by fg-out-1718.google.com with SMTP id 16so1204670fgg.40
        for <selinux@tycho.nsa.gov>; Sun, 09 Mar 2008 12:43:37 -0700 (PDT)
Message-ID: <cadfc0e40803091236i5ddca650hd81d470109295541@mail.gmail.com>
Date: Sun, 9 Mar 2008 13:36:21 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>, "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Subject: x fails to start on fc9
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

selinux-policy 3.3.1-11
xorg-x11-server-Xorg-1.4.99.900-0.28.20080304

Error message something like:
file_contexts line 0 invalid context system_u:object_r:info_xproperty_t:s0
SELinux: Failed to set label property on window!

I'm using MLS policy in permissive mode.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
