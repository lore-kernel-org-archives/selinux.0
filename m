Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9L186Wt023898
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 21:08:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9L185mR007092
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 01:08:05 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9L184jp007088 for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 01:08:04 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>,
   Carlos Anisio Monteiro <monteiro@ipen.br>
Subject: Re: process context
Date: Tue, 21 Oct 2003 11:07:56 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
References: <3F8EEA16.8090908@ipen.br> <3F93BEEF.9060904@ipen.br> <3F93EAB3.7080109@redhat.com>
In-Reply-To: <3F93EAB3.7080109@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310211107.56066.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Oct 2003 00:01, Daniel J Walsh wrote:
> Currently that is what we are suggesting.  Modify mkinitrd with minimal
> policy and then have the initscripts load the on disk policy as early as
> possible.   We are working to the point where init itself will load
> policy and modification of the initrd will go away.

Unless of course we decide to go with a modified init, which means that we 
don't need policy in the initrd.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
