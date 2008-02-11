Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1BAiqkH004757
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2008 05:44:52 -0500
Received: from us.intercode.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1BAiokt004055
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2008 10:44:51 GMT
Date: Mon, 11 Feb 2008 21:43:47 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: David Howells <dhowells@redhat.com>
cc: Trond.Myklebust@netapp.com, chuck.lever@oracle.com, nfsv4@linux-nfs.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/37] Security: Separate task security context from
 task_struct
In-Reply-To: <20080208165229.15902.75572.stgit@warthog.procyon.org.uk>
Message-ID: <Xine.LNX.4.64.0802112142370.27028@us.intercode.com.au>
References: <20080208165156.15902.62457.stgit@warthog.procyon.org.uk>
 <20080208165229.15902.75572.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 8 Feb 2008, David Howells wrote:

> Separate the task security context from task_struct.  At this point, the
> security data is temporarily embedded in the task_struct with two pointers
> pointing to it.
> 
> Alpha needs further alteration as it refers to UID & GID in entry.S via asm
> offsets.
> 
> Sparc needs further alteration as it refers to UID & GID in sclow.S via asm
> offsets.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: James Morris <jmorris@namei.org>

(SELinux stuff mostly).

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
