Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LCSwWt025976
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 08:28:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9LCSuIE021705
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 12:28:57 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9LCSu1J021702 for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 12:28:56 GMT
Subject: Re: init patch for loading policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <3F944BF1.50606@redhat.com>
References: <200310200148.15852.russell@coker.com.au>
	 <1066672941.22196.259.camel@moss-spartans.epoch.ncsc.mil>
	 <3F944118.80809@redhat.com>
	 <1066682781.22196.398.camel@moss-spartans.epoch.ncsc.mil>
	 <3F944BF1.50606@redhat.com>
Content-Type: text/plain
Message-Id: <1066738770.27065.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 21 Oct 2003 08:19:30 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-10-20 at 16:56, Daniel J Walsh wrote:
> I don't believe there is anyway to get init to re-run the initscripts
> which means that no scripts will get started from the 'correct '
> init,  unless you change run-level.  

I'd suggest trying it before giving up on this path, as it is obviously
cleaner than patching /sbin/init.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
