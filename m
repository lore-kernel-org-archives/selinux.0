Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7SFnTLa019873
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 11:49:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7SFnSet028778
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 15:49:28 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h7SFnQlq028763 for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2003 15:49:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Package install probs
Date: Fri, 29 Aug 2003 01:49:15 +1000
References: <20030828144825.GA6898@vnl.com>
In-Reply-To: <20030828144825.GA6898@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308290149.15229.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 29 Aug 2003 00:48, Dale Amon wrote:
> Colin, at the end of the install of the default policy
> I'm getting this error message:
>
>  an error on line 39260 "Unknown type klogd_t at token ';'"
> "neverallow ~klogd_t proc_kmsg_t:file ~{ getattr }"
> while parsing /usr/bin/checkpolicy configuration make
> /etc/security/selinux/policy.15 error 1

Looks like you don't have the file klogd.te installed.  The relevant line in 
assert.te does not have an ifdef around it because klogd.te is in the core 
policy and getting a usable system without klogd is very difficult.

However this should probably be changed.  We are now discussing having a mini 
policy for initrd's again, and for an initrd we don't really need a klogd.  
I've added an appropriate ifdef in my tree for the mini policy.  But for your 
use probably adding klogd is best.

However if you use a syslogd that includes klogd functionality in the main 
program (such as syslog-ng) then the thing to do is add the ability to read 
/proc/kmsg to syslogd_t and change assert.te to refer to syslogd_t instead of 
klogd_t.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
