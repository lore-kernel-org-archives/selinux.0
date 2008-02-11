Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1BAxBMK005915
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2008 05:59:11 -0500
Received: from us.intercode.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1BAx9Af028198
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2008 10:59:10 GMT
Date: Mon, 11 Feb 2008 21:57:37 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: David Howells <dhowells@redhat.com>
cc: Trond.Myklebust@netapp.com, chuck.lever@oracle.com, nfsv4@linux-nfs.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/37] Security: De-embed task security record from task
 and use refcounting
In-Reply-To: <20080208165235.15902.8174.stgit@warthog.procyon.org.uk>
Message-ID: <Xine.LNX.4.64.0802112156030.27028@us.intercode.com.au>
References: <20080208165156.15902.62457.stgit@warthog.procyon.org.uk>
 <20080208165235.15902.8174.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 8 Feb 2008, David Howells wrote:

> Remove the temporarily embedded task security record from task_struct.  Instead
> it is made to dangle from the task_struct::sec and task_struct::act_as pointers
> with references counted for each.

...

These patches are kind of huge.

> +static int selinux_task_dup_security(struct task_security *sec)
> +{
> +	struct task_security_struct *tsec1, *tsec2;
> +
> +	tsec1 = sec->security;
> +
> +	tsec2 = kmemdup(tsec1, sizeof(*tsec1), GFP_KERNEL);
> +	if (!tsec2)
> +		return -ENOMEM;
> +
> +	tsec2->osid = tsec1->osid;
> +	tsec2->sid = tsec1->sid;
> +
> +	tsec2->exec_sid = tsec1->exec_sid;
> +	tsec2->create_sid = tsec1->create_sid;
> +	tsec2->keycreate_sid = tsec1->keycreate_sid;
> +	tsec2->sockcreate_sid = tsec1->sockcreate_sid;
> +	tsec2->ptrace_sid = SECINITSID_UNLABELED;
> +	sec->security = tsec2;
> +
> +	return 0;
>  }

Why manually copy these fields after a kmemdup?

What about the task backpointer? (i.e. tsec2->task)


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
