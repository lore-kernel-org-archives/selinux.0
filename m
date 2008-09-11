Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8B389Ri000997
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 23:08:09 -0400
Received: from yx-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8B37Pbv002292
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2008 03:07:25 GMT
Received: by yx-out-1718.google.com with SMTP id 3so57456yxi.84
        for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 20:08:09 -0700 (PDT)
Message-ID: <48C88B93.7000006@gmail.com>
Date: Wed, 10 Sep 2008 23:08:03 -0400
From: Ivan Gyurdiev <ivg231@gmail.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: libsemage patch to not compile modules for seusers and fcontext
References: <48A48B8C.3070908@redhat.com> <1219412317.18600.60.camel@moss-spartans.epoch.ncsc.mil> <48B41D0E.6060509@redhat.com> <48B4B348.2080801@gmail.com> <48C7D9F0.4000405@redhat.com>
In-Reply-To: <48C7D9F0.4000405@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Ok I found some problems with the previous patch and did some code
> reuse.  I added a function that only read base.pp in order to handle the
>  base user_extra and seusers problem.
>   

This is starting to look better - I see no obvious correctness issues.
The function still seems much too large to maintain - maybe fcontext and 
module stuff can also be broken out into sub-functions ?

ivan



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
