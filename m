Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1KGLYZS016260
	for <selinux@tycho.nsa.gov>; Mon, 20 Feb 2006 11:21:38 -0500
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1KGK9LI027583
	for <selinux@tycho.nsa.gov>; Mon, 20 Feb 2006 16:20:09 GMT
Subject: Re: Latesr diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43F86FA2.8010505@redhat.com>
References: <43F86FA2.8010505@redhat.com>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 11:24:10 -0500
Message-Id: <1140452650.30819.6.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-02-19 at 08:16 -0500, Daniel J Walsh wrote:
> Add java_domtrans to eliminate some exec* messages in log files

I put the implementation of the interface in a ifdef(`targeted_policy'
since its not valid for strict.

Dropped the semodule policy, see the semodule policy thread.

The remainder should be merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
