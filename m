Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4UNsMI4001837
	for <selinux@tycho.nsa.gov>; Fri, 30 May 2003 19:54:22 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4UNrgss005584
	for <selinux@tycho.nsa.gov>; Fri, 30 May 2003 23:53:52 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h4UNrThY005575
	for <selinux@tycho.nsa.gov>; Fri, 30 May 2003 23:53:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: John Wolff <jrwolff@comcast.net>, selinux@tycho.nsa.gov
Subject: Re: Compaq DL-360
Date: Sat, 31 May 2003 09:53:08 +1000
References: <3ED7C88A.7060209@comcast.net>
In-Reply-To: <3ED7C88A.7060209@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305310953.08664.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 31 May 2003 07:09, John Wolff wrote:
> Has anyone attempted to get SE Linux running on a Compaq DL-360 server?

Can you boot a non-SE kernel you compiled?

You say "SE Linux modules loaded", it's recommended that SE Linux be 
statically linked into the kernel not used as modules.

Please capture the panic, if it's an Oops then run it through ksymoops and 
post the results here, if it's some other crash message then just post the 
messages here.  The serial-port console support is a good way of capturing 
such boot messages.

Try getting it to boot with a floppy disk as the root device to eliminate RAID 
issues.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
