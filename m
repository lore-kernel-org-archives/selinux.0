Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9HBOeWt008431
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 07:24:40 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9HBOcmR010110
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 11:24:39 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9HBOajp010107 for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 11:24:37 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: kamal <kamalnee@iitk.ac.in>, selinux@tycho.nsa.gov
Subject: Re: process context
Date: Fri, 17 Oct 2003 21:24:26 +1000
References: <3F8EEA16.8090908@ipen.br> <200310171327.31980.russell@coker.com.au> <3F8FC612.2090105@iitk.ac.in>
In-Reply-To: <3F8FC612.2090105@iitk.ac.in>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310172124.26830.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 17 Oct 2003 20:36, kamal wrote:
> Russell Coker wrote:
> >I guess that at boot time the init process (usually /sbin/init) was not
> >labeled with init_exec_t, that caused init to be run in kernel_t.
>
> But why does this happen? I also had the same problem, and because getty
> process is not labeled properly, login fails to get default context.

The most likely cause of /sbin/init having the wrong type is that it was never 
labeled correctly.  The seond most likely cause is that you copied over a 
newer version without relabeling afterwards.

> Output of "ls --context /sbin/init" is:
> -rwxr-xr-x  root     root     system_u:object_r:init_exec_t    /sbin/init

That's the correct value.  So "telinit u" should result in it getting the 
right context.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
