Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3R3RMRb025525
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2004 23:27:22 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3R3RKdi007263
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 03:27:20 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i3R3RJJP007214 for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 03:27:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Ed Street" <edstreet@street-tek.com>
Subject: Re: /etc/passwd labeling issues
Date: Tue, 27 Apr 2004 13:25:58 +1000
Cc: "Selinux" <selinux@tycho.nsa.gov>
References: <20040426224500.7F3B83A4053@abyss.simplyaquatics.com>
In-Reply-To: <20040426224500.7F3B83A4053@abyss.simplyaquatics.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <200404271325.58348.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 27 Apr 2004 08:44, "Ed Street" <edstreet@street-tek.com> wrote:
> So we have 2 choices for our debian users.  A) Change the password, change

No, we have only one realistic choice.  To fix PAM and make it work correctly 
as it does in Fedora.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
