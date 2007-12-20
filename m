From: David Howells <dhowells@redhat.com>
In-Reply-To: <200712181800.23578.nickpiggin@yahoo.com.au>
References: <200712181800.23578.nickpiggin@yahoo.com.au> <200712141508.23756.nickpiggin@yahoo.com.au> <20071205193909.24617.26538.stgit@warthog.procyon.org.uk> <643.1197930966@redhat.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dhowells@redhat.com, viro@ftp.linux.org.uk, hch@infradead.org,
        Trond.Myklebust@netapp.com, sds@tycho.nsa.gov, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 10/28] FS-Cache: Recruit a couple of page flags for cache management [try #2]
Date: Thu, 20 Dec 2007 18:33:39 +0000
Message-ID: <6481.1198175619@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > > I'd much prefer if you would handle this in the filesystem, and have it
> > > set PG_private whenever fscache needs to receive a callback, and DTRT
> > > depending on whether PG_fscache etc. is set or not.
> >
> > That's tricky and slower[*].  One of the things I want to do is to modify
> > iso9660 to do be able to do caching, but PG_private is 'owned' by the
> > generic buffer cache code.
> 
> Maybe it is harder, but it is the right way to do it.

You're wrong.  It would mean that PG_private is the logical disjunction of
PG_fscache and some condition not otherwise explicitly stored.  I tried that
with NFS and it was nasty.

As you can no doubt see, it means that you can't distinguish all the states
you used to be able to.

> So you should modify the filesystems rather than core code.

I think you missed what I said:

	but PG_private is 'owned' by the generic buffer cache code.

That means more of the core code would have to change - or, at least, change
more.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
