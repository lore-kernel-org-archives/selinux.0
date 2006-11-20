Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAKMTBST011432
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 17:29:11 -0500
Received: from mail3.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAKMSRZo011294
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 22:28:28 GMT
Date: Mon, 20 Nov 2006 17:29:25 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
        Andrew Morton <akpm@osdl.org>, trond.myklebust@fys.uio.no,
        selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com,
        steved@redhat.com
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be
 overridden
In-Reply-To: <1164048073.13758.29.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <XMMS.LNX.4.64.0611201727470.31270@d.namei>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
  <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com>
 <XMMS.LNX.4.64.0611141618300.25022@d.namei> <1164048073.13758.29.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 20 Nov 2006, Stephen Smalley wrote:

> > The ability to set this needs to be mediated via MAC policy.
> > 
> > See selinux_setprocattr()
> 
> That's different - selinux_set_fscreate_secid() is for internal use by a
> kernel module that wishes to temporarily assume a particular fscreate
> SID, whereas selinux_setprocattr() handles userspace writes
> to /proc/self/attr nodes.  Imposing a permission check here makes no
> sense.

Well, the hook is exported generally to the kernel, so we need to 
ensure that it is documented with a big warning.  The name of the hook 
should perhaps make it more obvious,  like set_internal_ or so.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
