Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA11917
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 11:51:19 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA11497
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 16:50:20 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
        by jazzband.ncsc.mil  with SMTP id QAA11493 for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 16:50:19 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015242DF@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen Smalley'" <sds@tislabs.com>,
        Russell Coker
	 <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: RE: gdm
Date: Mon, 25 Feb 2002 10:51:28 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If you would like I will try and redo the gdm domain 
to follow this guidline and make the change to xdm_t.

Russell did you need to make modifications to the 
domain for the kdm ?

Mark


-----Original Message-----
From: Stephen Smalley [mailto:sds@tislabs.com]
Sent: Monday, February 25, 2002 10:43 AM
To: Russell Coker
Cc: Westerman, Mark; SE Linux
Subject: Re: gdm



On Mon, 25 Feb 2002, Russell Coker wrote:

> Perhaps we should have a separate domain for the X server and allow only
the
> xdm type program to transition to it?

There are already domains defined for the X server (user_xserver_t and
sysadm_xserver_t) that are used when startx is used after a normal login.
Ideally, [xgk]dm would transition to one of these domains when it runs the
X server.  However, as I recall, Mark encountered difficulties in
modifying gdm along these lines due to its current structure.

> Also it would probably be a good idea to rename gdm to xdm to avoid
confusion.

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
