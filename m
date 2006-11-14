Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAELJb06001326
	for <selinux@tycho.nsa.gov>; Tue, 14 Nov 2006 16:19:37 -0500
Received: from mail7.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAELHx1p025276
	for <selinux@tycho.nsa.gov>; Tue, 14 Nov 2006 21:18:00 GMT
Date: Tue, 14 Nov 2006 16:19:48 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, trond.myklebust@fys.uio.no,
        selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com,
        steved@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be
 overridden
In-Reply-To: <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com>
Message-ID: <XMMS.LNX.4.64.0611141618300.25022@d.namei>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
 <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 14 Nov 2006, David Howells wrote:

> +static u32 selinux_set_fscreate_secid(u32 secid)
> +{
> +	struct task_security_struct *tsec = current->security;
> +	u32 oldsid = tsec->create_sid;
> +
> +	tsec->create_sid = secid;
> +	return oldsid;
> +}

The ability to set this needs to be mediated via MAC policy.

See selinux_setprocattr()



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
