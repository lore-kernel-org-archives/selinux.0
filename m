Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0E4dDRb023614
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 23:39:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0E4dCiV016627
	for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 04:39:12 GMT
Received: from thoron.boston.redhat.com (nat-pool-bos.redhat.com [66.187.230.200])
        by jazzband.ncsc.mil  with ESMTP id i0E4dC06016624 for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 04:39:12 GMT
Date: Tue, 13 Jan 2004 23:39:09 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: "David S. Miller" <davem@redhat.com>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>, <sds@epoch.ncsc.mil>,
   <selinux@tycho.nsa.gov>
Subject: Re: [PATCH][SELINUX] 6/7 Add SO_PEERSEC socket option and getpeersec
 LSM hook.
In-Reply-To: <20040113161257.40f1ff16.davem@redhat.com>
Message-ID: <Xine.LNX.4.44.0401132336560.9386-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 13 Jan 2004, David S. Miller wrote:

> I'm totally fine with this patch but I cannot apply it as it will not go in
> cleanly without your previous SELINUX bits applied, please resend to me
> when that stuff goes in.

It's in -mm2 now.  It could either be left there for merging to mainline,
or Andrew could drop it and I can send you the patch after the rest of the
-mm2 stuff ends up in bitkeeper.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
