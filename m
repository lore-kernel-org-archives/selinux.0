Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3EFoK2d022923
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 11:50:20 -0400
Received: from hades.sngx.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3EFpDaU021474
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 15:51:13 GMT
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: sudo + selinux
MIME-Version: 1.0
Date: Tue, 13 Apr 2010 08:53:27 -0500
From: James Cammarata <jimi@sngx.net>
Cc: Selinux <selinux@tycho.nsa.gov>
Reply-To: jimi@sngx.net
In-Reply-To: <4BC5D183.20403@redhat.com>
References: <C7EA5D61.B6871%csellers@tresys.com> <a7997a4e13a79796e80e71b9ff6d31c9@sngx.net> <4BC5B6AC.1040101@redhat.com> <4fc4d1cb9c79a5ba45b92b1c6c25b8b3@sngx.net> <4BC5D183.20403@redhat.com>
Message-ID: <3acfd6eb614d7ebec2d3c10d98940708@sngx.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 14 Apr 2010 10:30:27 -0400, Daniel J Walsh <dwalsh@redhat.com>
> We are very careful of what we backport and sudo has not come up on the
> priority list.  With Shipping versions of RHEL we are hesitant to make
> major modifications that could cause a regression.

Understood, I'm just surprised that running SElinux in strict mode breaks
sudo isn't more of a priority.  Are that few people using strict mode?

-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
