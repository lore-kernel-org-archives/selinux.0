Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA05983
	for <selinux@tycho.nsa.gov>; Wed, 22 May 2002 10:24:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA29241
	for <selinux@tycho.nsa.gov>; Wed, 22 May 2002 14:24:38 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA29231
	for <selinux@tycho.nsa.gov>; Wed, 22 May 2002 14:24:34 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <sds@tislabs.com>
Subject: Re:  Is this a module bug?
Date: Wed, 22 May 2002 16:24:25 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <000501c20190$eec4f9c0$2c1801d0@Dakota>
In-Reply-To: <000501c20190$eec4f9c0$2c1801d0@Dakota>
MIME-Version: 1.0
Message-Id: <20020522142425.D01493B0@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 22 May 2002 15:02, Steve wrote:
> I'm away at an offsite this week, so I can't look into this closely.
> However, offhand, anything that is done during module initialization will
> occur in the context of the process that performed the insertion, so it
> will show up under kmod_t or insmod_t.  Hence, this isn't surprising.

Hmm.  So we just have to give insmod_t and kmod_t all capabilities?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
