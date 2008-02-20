Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1KKGjeK032405
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 15:16:45 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1KKGTMM005871
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 20:16:29 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20080220195811.GD16668@sergelap.austin.ibm.com>
References: <20080220195811.GD16668@sergelap.austin.ibm.com> <20080220160557.4715.66608.stgit@warthog.procyon.org.uk>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: dhowells@redhat.com, Trond.Myklebust@netapp.com, chuck.lever@oracle.com,
        casey@schaufler-ca.com, nfsv4@linux-nfs.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 00/37] Permit filesystem local caching
Date: Wed, 20 Feb 2008 20:11:21 +0000
Message-ID: <12508.1203538281@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Serge E. Hallyn <serue@us.ibm.com> wrote:

> Seems *really* weird that every time you send this, patch 6 doesn't seem
> to reach me in any of my mailboxes...  (did get it from the url
> you listed)

It's the largest of the patches, so that's not entirely surprising.  Hence why
I included the URL to the tarball also.

> I'm sorry if I miss where you explicitly state this, but is it safe to
> assume, as perusing the patches suggests, that
> 
> 	1. tsk->sec never changes other than in task_alloc_security()?  

Correct.

> 	2. tsk->act_as is only ever dereferenced from (a) current->

That ought to be correct.

> 	   except (b) in do_coredump?

Actually, do_coredump() only deals with current->act_as.

> (thereby carefully avoiding locking issues)

That's the idea.

> I'd still like to see some performance numbers.  Not to object to
> these patches, just to make sure there's no need to try and optimize
> more of the dereferences away when they're not needed.

I hope that the performance impact is minimal.  The kernel should spend very
little time looking at the security data.  I'll try and get some though.

> Oh, manually copied from patch 6, I see you have in the task_security
> struct definition:
> 
> 	kernel_cap_t    cap_bset;       /* ? */
> 
> That comment can be filled in with 'capability bounding set' (for this
> task and all its future descendents).

Thanks.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
