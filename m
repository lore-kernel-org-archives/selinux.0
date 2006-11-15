From: David Howells <dhowells@redhat.com>
In-Reply-To: <1163609565.5691.167.camel@lade.trondhjem.org> 
References: <1163609565.5691.167.camel@lade.trondhjem.org>  <1163603377.5691.113.camel@lade.trondhjem.org> <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> <20061114200632.12943.72086.stgit@warthog.cambridge.redhat.com> <26454.1163606424@redhat.com> 
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
        sds@tycho.nsa.gov, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        aviro@redhat.com, steved@redhat.com
Subject: Re: [PATCH 05/19] NFS: Use local caching 
Date: Wed, 15 Nov 2006 17:07:53 +0000
Message-ID: <31660.1163610473@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> > This is releasepage() not invalidatepage().  It is conditional.
> 
> ...and invalidate_complete_page2() calls try_to_release_page() which
> again calls releasepage(). Success or failure of the latter should
> therefore not depend on the internal fscache state.

Okay... invalidate_complete_page2() passes __GFP_WAIT through.  I'll make
nfs_fscache_release_page() check for that, and if it's set, it'll wait for
FS-Cache to finish with the page before returning true.

This sounds like invalidate_inode_pages2() is doing the wrong thing.  After
all, releasepage() _is_ conditional.  It sounds like it should be calling
invalidatepage() instead.  Either that or NFS should be calling something
else entirely.

> > Hmmm...  I wonder if I need to do this in nfs_update_inode() at all.
> > Won't the pages and the cache object attached to an inode be discarded
> > anyway if the file attributes returned by the server change?
> 
> In the case of a read-only file, yes. That is not true of a read/write
> file.

So I can assume that, as we're only caching read-only files, I don't need to
invoke FS-Cache here.

> > > >  static void nfs_readpage_release(struct nfs_page *req)
> > > >  {
> > > > +	struct inode *d_inode = req->wb_context->dentry->d_inode;
> > > > +
> > > > +	if (PageUptodate(req->wb_page))
> > > > +		nfs_readpage_to_fscache(d_inode, req->wb_page, 0);
> > > > +
> > > 
> > > Will usually be called from an rpciod context. Should therefore not be
> > > grabbing semaphores, doing memory allocation etc.
> > 
> > Is it possible to make an NFS kernel thread that can have completed nfs_page
> > structs queued for writing to the cache?
> 
> Why should we add extra context switches for the non-fscache case? Just
> move the call to nfs_readpage_to_fscache into its own kernel thread.

Sorry, I meant can I make use of the nfs_page struct that was handed to
nfs_readpage_release() by queuing it for an auxiliary thread to call
nfs_readpage_to_fscache() on?  I didn't intend to call nfs_readpage_release()
in another thread.

After all, nfs_readpage_release() would ordinarily just clear and release it.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
