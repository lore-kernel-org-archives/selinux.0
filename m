Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3KNAiOL006440
	for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2009 19:10:50 -0400
Received: from mail-qy0-f113.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3KNAiDa021493
	for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2009 23:10:44 GMT
Received: by qyk11 with SMTP id 11so440835qyk.32
        for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2009 16:10:43 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 20 Apr 2009 16:10:42 -0700
Message-ID: <dd18b0c30904201610s5248e8e1w69f10aa7ad452911@mail.gmail.com>
Subject: newrole and pam.d/*
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

quick question:
Is there a way to configure pam.d/*
for a one time password for the session, so when I use newrole
I don't have to give a password each time?

The reason for this is, is I'm trying to
configure all of my apps in the menu bar of
fluxbox, so when I click on any app in there
the app will automatically open in the specified role.
(rather than opening a terminal etc...)

regards,

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
