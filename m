Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA20066
	for <selinux@tycho.nsa.gov>; Thu, 20 Feb 2003 11:52:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA14002
	for <selinux@tycho.nsa.gov>; Thu, 20 Feb 2003 16:49:21 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id QAA13998
	for <selinux@tycho.nsa.gov>; Thu, 20 Feb 2003 16:49:20 GMT
Message-Id: <200302201659.LAA12535@moss-shockers.ncsc.mil>
Date: Thu, 20 Feb 2003 11:59:57 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Switching Security Policies
To: sds@epoch.ncsc.mil, selinux@tycho.nsa.gov, CNguyen@mykotronx.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I understand that SELinux is not quite Multi-Level Security (MLS) yet, but

The optional MLS policy component is experimental, as noted in
selinux/README.MLS and in the help text for the kernel option.  You can
experiment with the MLS policy if you like, but it is likely that you
can achieve your security goals simply by configuring the TE policy
appropriately.  If you merely want a two level system, you can easily
represent the levels as TE domains and define appropriate allow rules
to enable authorized information flows.  You can also define
appropriate TE domains for any trusted subjects and set up assured
pipelines for downgrading.

> is it possible to switch security policies w/o having to reboot SELinux? For
> example: if I need Security Policy A for environment A, and Security Policy
> B for environment B, is there a (secure, of course) method to allow
> authorized user to switch from one policy to the other as the user moves
> from one  environment to the other environment?

You can change the policy at runtime via load_policy, assuming that your
initial policy loaded at boot time grants the necessary permission.  The
example policy allows authorized administrators to reload the policy.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
