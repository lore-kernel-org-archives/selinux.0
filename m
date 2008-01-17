From: David Howells <dhowells@redhat.com>
In-Reply-To: <28942.1200610127@redhat.com>
References: <28942.1200610127@redhat.com> <20080117204804.GC6416@fieldses.org> <20080115234724.22183.9603.stgit@warthog.procyon.org.uk> <20080115234652.22183.24850.stgit@warthog.procyon.org.uk> <20849.1200590240@redhat.com>
Cc: dhowells@redhat.com, "J. Bruce Fields" <bfields@fieldses.org>,
        sds@tycho.nsa.gov, casey@schaufler-ca.com, Trond.Myklebust@netapp.com,
        neilb@suse.de, linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [PATCH 06b/26] Security: Make NFSD work with detached security
Date: Thu, 17 Jan 2008 23:02:06 +0000
Message-ID: <29216.1200610926@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David Howells <dhowells@redhat.com> wrote:

> J. Bruce Fields <bfields@fieldses.org> wrote:
> 
> > Just curious--why?  Are get_kernel_security(), etc., particularly
> > expensive?
> 
> It involves a kmalloc().  That means an extra possibility for an error.  Plus
> it may allow you to cache the result of checking whether, say, SELinux
> security labels are allowed to be set when passed over NFS (if such is
> possible).

Apart from that, though, no, it's not particularly expensive.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
