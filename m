Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1BAdHpJ003927
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2008 05:39:17 -0500
Received: from us.intercode.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1BAdDkt001896
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2008 10:39:13 GMT
Date: Mon, 11 Feb 2008 21:38:03 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: David Howells <dhowells@redhat.com>
cc: Trond.Myklebust@netapp.com, chuck.lever@oracle.com, nfsv4@linux-nfs.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/37] Security: Change current->fs[ug]id to current_fs[ug]id()
In-Reply-To: <20080208165224.15902.1262.stgit@warthog.procyon.org.uk>
Message-ID: <Xine.LNX.4.64.0802112137340.27028@us.intercode.com.au>
References: <20080208165156.15902.62457.stgit@warthog.procyon.org.uk>
 <20080208165224.15902.1262.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 8 Feb 2008, David Howells wrote:

> Change current->fs[ug]id to current_fs[ug]id() so that fsgid and fsuid can be
> separated from the task_struct.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
