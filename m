Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5C9AcnM008732
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2012 05:10:38 -0400
Received: by lbbgk8 with SMTP id gk8so223791lbb.12
        for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2012 02:10:37 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 12 Jun 2012 17:10:37 +0800
Message-ID: <CAO-AVB509YFaTbpGQgajMiEhAXFEnzwHa5NMWrQcq1pmk6Ay7A@mail.gmail.com>
Subject: How to use the refpolicy in a embedded linux system?
From: casinee app <appcasinee@gmail.com>
To: =?GB2312?B?U0UtTGludXggzOHOyg==?= <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
how to use the refpolicy in a embedded linux system?
I've copied the referpolicy in the host system to the root file system
for the embedded linux system.
But when i executed the  command #restorecon -R / , there were so many
"operation not support" messages in the output.
How to use the refpolicy in a embedded linux system?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
