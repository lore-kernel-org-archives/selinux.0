From: Ed Clarke <clarke@cilia.org>
Message-Id: <200201212108.g0LL8tu06231@news.cilia.org>
Subject: ntp security policy
To: SELinux@tycho.nsa.gov
Date: Mon, 21 Jan 2002 16:08:55 -0500 (EST)
Reply-To: clarke@cilia.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Has anyone developed a security policy for ntpd?  This is probably
simple:

	read access to:
		/etc/ntp.conf
		/etc/ntp/keys
	read/write access to:
		/etc/ntp/drift

but it also has enhanced privs to permit access to the system clock
via adjtime(x) etc. and speaks via tcp to various external peers and
servers.

I'm not sure how to start since I only got the system up and working
yesterday.  I'll admit that the thought of a cracker breaking into
this system and being unable to use so much as an editor is slowing
down my understanding of the system.  It's hard to study when you can't
stop giggling...

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
