Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4QDTs92019445
	for <selinux@tycho.nsa.gov>; Fri, 26 May 2006 09:29:54 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4QDTrMO015671
	for <selinux@tycho.nsa.gov>; Fri, 26 May 2006 13:29:53 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k4QDU72G002918
	for <selinux@tycho.nsa.gov>; Fri, 26 May 2006 09:30:07 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k4QDU7hM002917
	for selinux@tycho.nsa.gov; Fri, 26 May 2006 09:30:07 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1148575812.3304.45.camel@moss-tarheels.epoch.ncsc.mil> 
References: <1148575812.3304.45.camel@moss-tarheels.epoch.ncsc.mil> 
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: jmorris@redhat.com, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        dhowells@redhat.com
Subject: Re: [PATCH] selinux: Kernel access key retention support for SELinux 
Date: Fri, 26 May 2006 10:37:27 +0100
Message-ID: <18216.1148636247@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:

> This revision incorporates the changes previously suggested on this
> list, and also includes an extension to the key_alloc security hook,
> to allow its callers to pass in a task representing the proper context
> for the key being allocated (previously, the "current" pointer was
> used).  This is important in a number of functions where the key
> framework is generating keypairs for specific threads and processes,
> primarily in process_keys.c.

Looks okay.

> Actually, I was a bit concerned that no locking is performed on those task
> structures while the keyring is being allocated.  David, are you confident
> that no locking is required, and that those task structures will persist
> across the calls to keyring_alloc?

The task struct should be pinned by the caller of key_alloc(), either by the
context being the current process, or by the caller of request_key() being
asleep until the requested key is instantiated.

However, I've now a horrible feeling that I can see a race between two
processes both trying to instantiate the same key: what if one checks the
authorisation key preparatory to searching it, then the second instantiates
and revokes the authorisation key, and then the first searches the context
process's keyrings?

I've a feeling there's a race there; and I've a feeling that I need to make a
revocation key op so that the any ref on the task struct can be discarded
properly when the key is revoked:-/


Anyway, that's the subject for a separate patch.  I don't think it would
change yours:

---<snip>---
From: Michael LeMay <mdlemay@epoch.ncsc.mil>

Introduce SELinux hooks to support the access key retention subsystem
within the kernel.  Incorporate new flask headers from a modified
version of the SELinux reference policy, with support for the new
security class representing retained keys.  Extend the "key_alloc"
security hook with a task parameter representing the intended
ownership context for the key being allocated.  Attach security
information to root's default keyrings within the SELinux
initialization routine.

Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>
Signed-Off-By: David Howells <dhowells@redhat.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
