Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAFGMlYY026553
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 11:22:47 -0500
Received: from mail7.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAFGL8u5002847
	for <selinux@tycho.nsa.gov>; Wed, 15 Nov 2006 16:21:09 GMT
Date: Wed, 15 Nov 2006 11:22:55 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: David Howells <dhowells@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, trond.myklebust@fys.uio.no,
        selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com,
        steved@redhat.com
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be
 overridden
In-Reply-To: <24555.1163598644@redhat.com>
Message-ID: <XMMS.LNX.4.64.0611151120240.8593@d.namei>
References: <XMMS.LNX.4.64.0611141618300.25022@d.namei>
 <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
 <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com>
 <24555.1163598644@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 15 Nov 2006, David Howells wrote:

> James Morris <jmorris@namei.org> wrote:
> 
> > The ability to set this needs to be mediated via MAC policy.
> 
> Something like this, you mean?

Yes, although perhaps writing to tsec->kern_create_sid or similar, which 
then overrides tsec->create_sid if set.  Also need 
/proc/pid/attr/kern_fscreate as a read only node.


> +	error = task_has_perm(current, current, PROCESS__SETFSCREATE);

I wonder if we also need 'relabelto' and 'relabelfrom' permissions, to 
control which labels are being used.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
