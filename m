Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3Q357Rb018730
	for <selinux@tycho.nsa.gov>; Sun, 25 Apr 2004 23:05:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3Q355di008832
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2004 03:05:05 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i3Q353JP008795 for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2004 03:05:04 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Ed Street" <edstreet@street-tek.com>
Subject: Re: /etc/passwd labeling issues
Date: Mon, 26 Apr 2004 13:03:34 +1000
Cc: <selinux@tycho.nsa.gov>
References: <20040425163937.D5AE63A404F@abyss.simplyaquatics.com>
In-Reply-To: <20040425163937.D5AE63A404F@abyss.simplyaquatics.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200404261303.34755.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 26 Apr 2004 02:39, "Ed Street" <edstreet@street-tek.com> wrote:
> As for the labeling issue for /etc/passwd I noticed in passwd.te this line
>
>
>
> file_type_auto_trans($1_t, etc_t, shadow_t, file)

If you don't have that then the new /etc/shadow file (with a complete copy of 
all /etc/shadow data) will briefly have the type etc_t and be readable by 
almost every domain.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
