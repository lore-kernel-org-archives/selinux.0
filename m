Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1BHVFot020433
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2008 12:31:15 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1BHVEJt013651
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2008 17:31:14 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Xine.LNX.4.64.0802112156030.27028@us.intercode.com.au>
References: <Xine.LNX.4.64.0802112156030.27028@us.intercode.com.au> <20080208165156.15902.62457.stgit@warthog.procyon.org.uk> <20080208165235.15902.8174.stgit@warthog.procyon.org.uk>
To: James Morris <jmorris@namei.org>
Cc: dhowells@redhat.com, Trond.Myklebust@netapp.com, chuck.lever@oracle.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/37] Security: De-embed task security record from task and use refcounting
Date: Mon, 11 Feb 2008 17:30:36 +0000
Message-ID: <28534.1202751036@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris <jmorris@namei.org> wrote:

> > Remove the temporarily embedded task security record from task_struct.
> > Instead it is made to dangle from the task_struct::sec and
> > task_struct::act_as pointers with references counted for each.
> 
> ...
> 
> These patches are kind of huge.

Yeah, I know.  The problem is that each patch must compile and run.  They
can't be split up without violating that unfortunately.

> Why manually copy these fields after a kmemdup?

Fair point.  Fixed.

> What about the task backpointer? (i.e. tsec2->task)

The problem is that there can't be one with this patch as the task_security
struct and the LSM security data attached to it may outlive the task it points
back to.

It seems that the backpointer can be dispensed with.  Nothing particularly
seems to use it.  Do you know the reason for its existence?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
