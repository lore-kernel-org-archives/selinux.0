Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA29167
	for <selinux@tycho.nsa.gov>; Sat, 1 Jun 2002 03:21:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id HAA28716
	for <selinux@tycho.nsa.gov>; Sat, 1 Jun 2002 07:21:38 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id HAA28712
	for <selinux@tycho.nsa.gov>; Sat, 1 Jun 2002 07:21:37 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: jw@centraltexasit.com, selinux@tycho.nsa.gov
Subject: Re: How to go about mixing kernel patches...
Date: Sat, 1 Jun 2002 09:21:09 +0200
References: <200205312140.02418.jw@centraltexasit.com>
In-Reply-To: <200205312140.02418.jw@centraltexasit.com>
MIME-Version: 1.0
Message-Id: <20020601072110.02ACE7118@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 1 Jun 2002 04:39, JW wrote:
> I hope no one minds to mposting this here, if you do, flame away.
>
> My first difficulty it appling the SE Linux patch to the SuSE-patched
> kernel.
>
> I applied lsm-2.4-2002050211.patch.gz to vanila 2.4.18 and they apply
> perfectly.
>
> I applied it to linux-2.4.18-SuSE and got some errors, producing the
> following rejects:

Probably the best thing to do is use the upstream kernel instead of the SuSE 
patched one.

Also you could look around the SuSE site for a list of patch files that they 
use, and select the few that are relevant to you instead of the many that 
conflict with SE Linux.

NB  XFS and LSM patches conflict...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
