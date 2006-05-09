Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k49Eb1AW017186
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 10:37:01 -0400
Received: from smtp-bedford.mitre.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k49Eb0a2025338
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 14:37:00 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.12.11.20060308/8.11.6) with SMTP id k49Eb0PQ022235
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 10:37:00 -0400
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (Postfix) with ESMTP id 22E78BF01
	for <selinux@tycho.nsa.gov>; Tue,  9 May 2006 10:37:00 -0400 (EDT)
From: Brian Sniffen <bsniffen@mitre.org>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Network access controls (resolving xfrm, secmark, and NetLabel)
References: <445B7CEC.1020106@hp.com>
Date: Tue, 09 May 2006 10:35:46 -0400
In-Reply-To: <445B7CEC.1020106@hp.com> (Paul Moore's message of "Fri, 05 May
	2006 12:27:24 -0400")
Message-ID: <m24pzz6zb1.fsf@raven-king.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore <paul.moore@hp.com> writes:

> The secmark approach requires the labeling mechanism to live inside
> the netfilter code (correct James?) while the NetLabel approach
> allows the labeling mechanism to happen anywhere it can, in the xfrm
> transforms, netfilter, you name it.

The sequencing of netfilter makes it very clear how to handle multiple
attempts to apply a label, and very easy to be sure which labels will
be applied to which packets.  With multiple NetLabel points of
contact, how much will you be able to tell statically about the labels
on various sorts of packet?  In how many places will an analyst need
to look?

-Brian

-- 
Brian T. Sniffen                                      bsniffen@mitre.org
The MITRE Corporation                                       781-271-2904

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
