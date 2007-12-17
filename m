From: David Howells <dhowells@redhat.com>
In-Reply-To: <200712141451.56870.nickpiggin@yahoo.com.au>
References: <200712141451.56870.nickpiggin@yahoo.com.au> <20071205193818.24617.79771.stgit@warthog.procyon.org.uk> <20071205193904.24617.94077.stgit@warthog.procyon.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dhowells@redhat.com, viro@ftp.linux.org.uk, hch@infradead.org,
        Trond.Myklebust@netapp.com, sds@tycho.nsa.gov, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 09/28] FS-Cache: Release page->private after failed readahead [try #2]
Date: Mon, 17 Dec 2007 22:42:13 +0000
Message-ID: <674.1197931333@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> This is pretty nasty.

Why?  If the fs doesn't set PG_private or PG_fscache on any pages before
calling read_cache_pages(), there's no difference.

Furthermore, the differences only crop up in the error handling paths.

> I would suggest either to have the function return the number of pages that
> were added to pagecache,

Which helps how?

> or just open code it.

Well, I could give an alternative read_cache_pages(), I suppose, for just this
situation, but that means there are two parallel functions which then both
need to be maintained.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
