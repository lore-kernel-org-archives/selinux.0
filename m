Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0SNfQ53028306
	for <selinux@tycho.nsa.gov>; Fri, 28 Jan 2005 18:41:26 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0SNdKka009392
	for <selinux@tycho.nsa.gov>; Fri, 28 Jan 2005 23:39:20 GMT
Subject: Re: [ RESEND ] Fedora Rawhide mplayer policy
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <41FABDB1.7030606@redhat.com>
References: <1106944688.2174.13.camel@cobra.ivg2.net>
	 <41FAAA5A.1020800@redhat.com> <1106947027.2936.1.camel@cobra.ivg2.net>
	 <41FABDB1.7030606@redhat.com>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 16:41:24 -0700
Message-Id: <1106955684.15978.5.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Why not label win32_lib_t as being texrel_shlib_t?

It's not a text relocation issue.
It just needs { execute } so I could label it shlib_t.
Should I do that instead?

See, it's a *windows* shared library though, so I thought
it needed to be separated somehow from the elves (hehe..ELFs).

Currently it's marked lib_t. I bet xine gives denials for that too.


-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
