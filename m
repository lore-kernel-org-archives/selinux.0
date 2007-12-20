From: David Howells <dhowells@redhat.com>
In-Reply-To: <200712181807.53907.nickpiggin@yahoo.com.au>
References: <200712181807.53907.nickpiggin@yahoo.com.au> <200712141521.24227.nickpiggin@yahoo.com.au> <20071205194020.24617.28880.stgit@warthog.procyon.org.uk> <731.1197932071@redhat.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dhowells@redhat.com, viro@ftp.linux.org.uk, hch@infradead.org,
        Trond.Myklebust@netapp.com, sds@tycho.nsa.gov, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 24/28] AFS: Add a function to excise a rejected write from the pagecache [try #2]
Date: Thu, 20 Dec 2007 18:49:10 +0000
Message-ID: <6538.1198176550@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > > This reintroduces the fault vs truncate race window, which must be fixed.
> >
> > Hmmm...  perhaps.
> 
> What do you mean by perhaps?

I mean 'perhaps'.  I'm not sure I remember what the race was, so I can't
evaluate whether or not the same race crops up in AFS too.  So: can you
describe the race please.

> No, you could do writeback caching but disallow read of dirty data.

Someone might already have read-access via mmap at the point someone attempts
to write to an mmapped region.  That means that I'd have to revoke the read
access of the first someone before letting the write take place.

Does NFS do this?

> > > But otherwise I guess if you really want to discard the dirty data after
> > > a failed writeback attempt, what's wrong with just
> > > invalidate_inode_pages2?
> >
> > Erm...  Because it deadlocks?
> 
> Why don't you call it after calling end_page_writeback?

Because then there can be a race over who gets to flush the dead write.
Actually, this may no longer be a problem with your write_begin() changes.
I'll need to have another look at those.

Besides, I don't agree that invalidate_inode_pages2() is necessarily the right
way to do things.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
