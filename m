From: David Howells <dhowells@redhat.com>
In-Reply-To: <1190403055.6721.3.camel@heimdal.trondhjem.org>
References: <1190403055.6721.3.camel@heimdal.trondhjem.org> <20070921144703.8323.50492.stgit@warthog.procyon.org.uk> <20070921144755.8323.45791.stgit@warthog.procyon.org.uk>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: dhowells@redhat.com, viro@ftp.linux.org.uk, hch@infradead.org,
        sds@tycho.nsa.gov, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 10/22] CacheFiles: Add a hook to write a single page of data to an inode
Date: Sat, 22 Sep 2007 00:11:35 +0100
Message-ID: <10126.1190416295@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Trond Myklebust <Trond.Myklebust@netapp.com> wrote:

> So why do you need a new address space operation? AFAICS the generic
> implementation will work for pretty much everyone who supports the
> existing prepare_write()/commit_write().

Because Christoph decreed that I wasn't allowed to call prepare_write() and
commit_write() directly.  It's possible that the method should be in the
inode_operations rather than on the address space.

> Furthermore, you don't appear to supply any alternative "optimised"
> implementations...

Optimised in what fashion?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
