Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m68J32ek006408
	for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2008 15:03:02 -0400
Received: from fg-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m68J2pt7020529
	for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2008 19:02:56 GMT
Received: by fg-out-1718.google.com with SMTP id 16so1038929fgg.40
        for <selinux@tycho.nsa.gov>; Tue, 08 Jul 2008 12:02:51 -0700 (PDT)
Message-ID: <cadfc0e40807081202l7badbcb8h84ee373161fd6fd2@mail.gmail.com>
Date: Tue, 8 Jul 2008 14:02:50 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SELinux List" <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: newrole assertion
Cc: "Joe Nall" <joe@nall.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Using MLS enforcing in a gnome-terminal with context
user_u:user_r:user_t:s0-s15:c0.c1023 I run newrole and get these
results

newrole -l s1-s1 -- -c "gnome-terminal --disable-factory"
Password:
**
** ERROR:(terminal.c:1016):new_terminal_with_options: assertion
failed: (profile)


I think Joe straced this and has a little more info if he'd like to chime in.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
