Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA15975
	for <selinux@tycho.nsa.gov>; Sat, 20 Apr 2002 14:15:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA19992
	for <selinux@tycho.nsa.gov>; Sat, 20 Apr 2002 18:13:19 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA19903
	for <selinux@tycho.nsa.gov>; Sat, 20 Apr 2002 18:13:17 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Ivan Pulleyn <ivan@torpid.com>
Subject: Re: boot loader
Date: Sat, 20 Apr 2002 20:14:45 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.10.10204201020030.2381-100000@norway.torpid.com>
In-Reply-To: <Pine.LNX.4.10.10204201020030.2381-100000@norway.torpid.com>
MIME-Version: 1.0
Message-Id: <20020420181446.4926144F6C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 20 Apr 2002 17:24, Ivan Pulleyn wrote:
> I don't know how granular these policies can get (I'm just a lurker on
> this list), but it would be cool if you could restrict boot_loader to
> access only the first couple disk blocks where lilo writes to, and
> privmem to only the less than 1MB region where BIOS values are.

They aren't that granular.

Probably the best way to achieve what you suggest would be to change the 
device drivers to have a separate device node for the first 512 bytes of the 
disk.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
