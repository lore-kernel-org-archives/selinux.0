Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA27016
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 11:04:39 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA27187
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 16:01:43 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id QAA27183
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 16:01:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Wayne Salamon <wsalamon@tislabs.com>, <selinux@tycho.nsa.gov>
Subject: Re: run_init policy
Date: Tue, 28 Jan 2003 17:04:09 +0100
References: <Pine.LNX.4.33.0301281029520.1754-100000@vox.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0301281029520.1754-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301281704.09253.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 28 Jan 2003 16:36, Wayne Salamon wrote:
>   The existing policy only allows run_init to execute file with the
> initrc_exec_t type. In the current file contexts, only the rc files in
> /etc have the type; the /etc/init.d, /etc/rc?.d scripts have the etc_t.
> Therefore, run_init cannot execute the individual rc scripts.

I submitted a policy patch to do this along with the program open_init_pty 
which is used to allocate a pty for the daemon startup process.  The new pty 
(allocated through expect) allows the daemon to write messages which are 
readable by the administrator in the startup phase, while being unable to 
interfere with other administrative logins.

This works reasonably well except in some situations where the daemon parent 
exits before the child has finished with the controlling tty and then the 
child gets upset and aborts.  The solution I've used so far is to put
"sleep 1" statements in the start scripts for those daemons as an interim 
measure.

Steve didn't like the way it was going and removed the open_init_pty script 
without making matching changes to the policy.

Before the next release I'll solve this properly one way or another.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
