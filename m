Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h36L4TI4013192
	for <selinux@tycho.nsa.gov>; Sun, 6 Apr 2003 17:04:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h36L0nOv003924
	for <selinux@tycho.nsa.gov>; Sun, 6 Apr 2003 21:00:49 GMT
Received: from eos.telenet-ops.be (eos.telenet-ops.be [195.130.132.40])
	by jazzswing.ncsc.mil  with ESMTP id h36L0mY1003921
	for <selinux@tycho.nsa.gov>; Sun, 6 Apr 2003 21:00:48 GMT
Date: Sun, 6 Apr 2003 23:04:01 +0200
From: Kurt Roeckx <Q@ping.be>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: screen problem.
Message-ID: <20030406210401.GA18189@ping.be>
References: <20030405234354.GA14856@ping.be> <200304061750.33400.russell@coker.com.au> <20030406130219.GA16130@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030406130219.GA16130@ping.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Everything seems to work expect reading the ~/.screenrc

I found an other problem ...

After a make relabel, all my screens change to context to
var_run_t instead of var_run_user_screen_t.


Kurt


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
