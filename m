Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9DCSiWt013775
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 08:28:45 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9DCSiUb023779
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 12:28:44 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9DCSghX023776 for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 12:28:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Carlos =?iso-8859-1?q?An=EDsio=20Monteiro?= <monteiro@ipen.br>,
   selinux@tycho.nsa.gov
Subject: Re: login process
Date: Mon, 13 Oct 2003 22:28:34 +1000
References: <3F8A6068.5040209@ipen.br>
In-Reply-To: <3F8A6068.5040209@ipen.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310132228.34578.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The most likely cause of that problem is the login process running in the 
wrong domain.  The set of acceptable contexts for the user process is 
determined from the context of the login process (should be 
system_u:object_r:local_login_t) and the file /etc/security/default_contexts.

Assuming that your default_contexts file has the correct data (most likely as 
it a default install will put the right file there) then the problem is the 
context of the login process.

If you run "ps ax --context | grep login" then you'll see the context.

The wrong context can be caused by /bin/login having the wrong type 
(ls --context to inspect it) or by the parent process (getty) running in the 
wrong context.


PS  If you have problems sending to the list please paste the text into a new 
message rather than forwarding.  Forwarding tends to leave the message as an 
attachment and break quoting.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
