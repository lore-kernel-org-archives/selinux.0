Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NKNsoi009458
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 16:23:54 -0400
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NKNrU1013380
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 20:23:53 GMT
From: Paul Moore <paul.moore@hp.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: netlabel can be run in init scripts I think?
Date: Fri, 23 Mar 2007 16:23:40 -0400
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
References: <46042AC3.6050006@redhat.com>
In-Reply-To: <46042AC3.6050006@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703231623.40160.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, March 23 2007 3:30:11 pm Daniel J Walsh wrote:
> I believe this patch came from netlabel guys.

Yes it did, I believe it was posted to this list too, although I could be 
mistaken.  That being said, I wonder if instead of init_daemon_domain() 
init_system_domain() should be used - thoughts?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
