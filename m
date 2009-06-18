Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5IBsWeL004337
	for <selinux@tycho.nsa.gov>; Thu, 18 Jun 2009 07:54:32 -0400
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5IBsJCm004721
	for <selinux@tycho.nsa.gov>; Thu, 18 Jun 2009 11:54:19 GMT
Date: Thu, 18 Jun 2009 21:54:28 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] cleanup in ss/services.c
In-Reply-To: <4A39FB0F.4090701@ak.jp.nec.com>
Message-ID: <alpine.LRH.2.00.0906182154060.25135@tundra.namei.org>
References: <4A39FB0F.4090701@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 18 Jun 2009, KaiGai Kohei wrote:

> It is a cleanup patch to cut down a line within 80 columns.
> 
>  Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
> --
>  security/selinux/ss/services.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next


-- 
James Morris <jmorris@namei.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
