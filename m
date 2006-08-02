Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k72Jnatp008075
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 15:49:36 -0400
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k72JnTeA021251
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 19:49:30 GMT
Subject: Re: [PATCH 7/6] netfilter integration take 2: style fixes
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1154538846.31522.177.camel@sgc.columbia.tresys.com>
References: <1154538846.31522.177.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 15:49:30 -0400
Message-Id: <1154548170.27457.93.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-02 at 13:14 -0400, Christopher J. PeBenito wrote:
> This applies on top of the previous patches, to fix style.  Also removed
> a NULL check since semanage_path() can't return NULL.
> 

This looks good to me.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
