Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA11837
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 11:43:29 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA28700
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 16:42:20 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA28696
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 16:42:20 GMT
Date: Mon, 25 Feb 2002 11:43:02 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: gdm
In-Reply-To: <20020225042432.3A43D24A95@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0202251139400.16566-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 25 Feb 2002, Russell Coker wrote:

> Perhaps we should have a separate domain for the X server and allow only the
> xdm type program to transition to it?

There are already domains defined for the X server (user_xserver_t and
sysadm_xserver_t) that are used when startx is used after a normal login.
Ideally, [xgk]dm would transition to one of these domains when it runs the
X server.  However, as I recall, Mark encountered difficulties in
modifying gdm along these lines due to its current structure.

> Also it would probably be a good idea to rename gdm to xdm to avoid confusion.

My opinion, for what it is worth, is that 'xdm_t' is the correct general
name for an X Display Manager domain.  However, you should retain a type
alias for gdm_t to avoid killing any running gdm processes when you make
the change.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
