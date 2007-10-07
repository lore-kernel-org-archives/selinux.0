Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l97NtabV017680
	for <selinux@tycho.nsa.gov>; Sun, 7 Oct 2007 19:55:36 -0400
Received: from ccerelrim01.cce.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l97NtZLW026865
	for <selinux@tycho.nsa.gov>; Sun, 7 Oct 2007 23:55:35 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH v4 0/3] Added new checks for labeled IPsec & SECMARK [en|dis]able
Date: Sun, 7 Oct 2007 19:55:26 -0400
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
References: <20071005192619.28034.62276.stgit@flek.americas.hpqcorp.net> <Xine.LNX.4.64.0710080752240.12306@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0710080752240.12306@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200710071955.26628.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 07 October 2007 5:53:11 pm James Morris wrote:
> I think it'd be good to get these into 2.6.24.  Any acks/nacks ?

Technically the ability to dynamically enable/disable the network access 
controls alters user visible behavior and could cause complaints from users.  
Granted, the chance of someone complaining about a missing unlabeled_t access 
check when they haven't explicitly configured labeled networking is pretty 
slim, but it still is possible and I don't want to knowingly cause things to 
break.

It's tempting from a performance point of view to run with this now, but I 
personally tend to think it's best to wait and implement it in policy rev 22 
when we can hide it behind the new capability bitmap field (my thinking is 
that it goes in with the new peer permission class and flow controls).

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
