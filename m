Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAGMIXRb003380
	for <selinux@tycho.nsa.gov>; Sun, 16 Nov 2003 17:18:33 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAGMIWqY002458
	for <selinux@tycho.nsa.gov>; Sun, 16 Nov 2003 22:18:32 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hAGMIV0o002455 for <selinux@tycho.nsa.gov>; Sun, 16 Nov 2003 22:18:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: policy bug
Date: Mon, 17 Nov 2003 09:17:55 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20031116133109.GE17041@vnl.com>
In-Reply-To: <20031116133109.GE17041@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311170917.55412.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 17 Nov 2003 00:31, Dale Amon <amon@vnl.com> wrote:
> Here's another for you Russ. Fresh from today:
>
> ERROR 'name conflict for type run_init_conf_t' at token ';' on line 42023:
>
> type run_init_conf_t, file_type, sysadmfile;

Just remove the run_init_conf_t entries from later.te.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
