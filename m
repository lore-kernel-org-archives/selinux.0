Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB24nlRb012274
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 23:49:47 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB24nkqY012504
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 04:49:46 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hB24ni0o012501 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 04:49:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: nagray@bruzenak.com, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: What causes this??
Date: Tue, 2 Dec 2003 15:49:34 +1100
References: <1070340338.12612.2.camel@hawaii>
In-Reply-To: <1070340338.12612.2.camel@hawaii>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312021549.34383.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Dec 2003 15:45, Nick <nagray@bruzenak.com> wrote:
> I just rebuilt a system and when I try to change roles I get this
>
>
> [root@hawaii SELinux]# newrole -r sysadm_r
> cannot find your entry in the passwd file.
> [root@hawaii SELinux]#

Please give us the output of the command "id".  Chances are you are not 
running in a correct context.

Also please tell us whether you are using the old SE Linux or the new SE 
Linux, and whether you are in enforcing or permissive mode.  If enforcing 
then show us any AVC messages that occur in the kernel message log at the 
time you run "newrole".

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
