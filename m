Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LIcrWt029056
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 14:38:53 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9LIcoIG011703
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 18:38:52 GMT
Message-ID: <3F957D34.7030504@redhat.com>
Date: Tue, 21 Oct 2003 14:38:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: init patch for loading policy
References: <200310200148.15852.russell@coker.com.au> <200310220043.09925.russell@coker.com.au> <1066748352.27065.100.camel@moss-spartans.epoch.ncsc.mil> <200310220200.35514.russell@coker.com.au>
In-Reply-To: <200310220200.35514.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Init has logic in it to look at its argv[0] to see if it is init.  If it 
is not it thinks it is telinit.

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
