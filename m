Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB1JcqRb009498
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 14:38:52 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB1Jc7p5002082
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 19:38:07 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hB1Jc7t0002079
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 19:38:07 GMT
Subject: Re: [PATCH] checkpolicy-5
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031128093154.GB27465@wavehammer.waldi.eu.org>
References: <20031128093154.GB27465@wavehammer.waldi.eu.org>
Content-Type: text/plain
Message-Id: <1070307524.12270.221.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 01 Dec 2003 14:38:44 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-11-28 at 04:31, Bastian Blank wrote:
> hi folks
> 
> this patch fixes:
> - size_t vs. int, unsigned int, __u32
> - mark some attributes as unused

Thanks, merged.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
