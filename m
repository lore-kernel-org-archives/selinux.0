Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i75BOErT004372
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 07:24:14 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i75BNen4000532
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 11:23:40 GMT
Subject: Re: make policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <rcoker@redhat.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200408042027.24036.rcoker@redhat.com>
References: <200408042027.24036.rcoker@redhat.com>
Content-Type: text/plain
Message-Id: <1091705002.11061.0.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 05 Aug 2004 07:23:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-08-04 at 06:27, Russell Coker wrote:
> Does "make policy" serve any purpose any more?  It seems to me that the below 
> part of the Makefile is obsolete and should be removed.
> 
> 
> policy: $(POLICYVER)
> 
> $(POLICYVER):  policy.conf $(CHECKPOLICY)
>         $(CHECKPOLICY) -o $@ policy.conf

I still use it.  Think:  building test policy, don't want to clobber the
installed one.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
