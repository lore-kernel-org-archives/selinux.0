Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5IL1N7i020451
	for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2008 17:01:23 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5IL1MiJ013518
	for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2008 21:01:22 GMT
Received: by fg-out-1718.google.com with SMTP id 16so231361fgg.40
        for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2008 14:01:21 -0700 (PDT)
Message-ID: <cadfc0e40806181401w635b2a5fo5c257e4050f4a6c0@mail.gmail.com>
Date: Wed, 18 Jun 2008 16:01:21 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SELinux Mail List" <selinux@tycho.nsa.gov>
Subject: window manager policy
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm contemplating some AVC's that originate in metacity and am
wondering whether a window manager is a special case of an X client
that requires its' own policy. Are there things that a window manager
does that other X clients shouldn't? Also on an MLS system should the
window manager run at the users highwater mark or ranged?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
