Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9B6d7Wk009805
	for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2006 02:39:07 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9B6cSY0002625
	for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2006 06:38:28 GMT
Message-ID: <452C9182.5070405@tresys.com>
Date: Wed, 11 Oct 2006 02:38:58 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Todd Miller <Todd.Miller@sparta.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: PATCH: fix memory leak in setfiles.c
References: <1ED46139-F06C-4DC6-A577-09BC257C9FBF@sparta.com>
In-Reply-To: <1ED46139-F06C-4DC6-A577-09BC257C9FBF@sparta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Todd Miller wrote:
> Add a missing freecon() on an error path.
>
>  - todd
>
Thanks for finding and fixing this memory leak. For future reference, 
inlined patches that apply with -p1 from the top of the repository are 
preferred.

Acked-By: Joshua Brindle <jbrindle@tresys.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
