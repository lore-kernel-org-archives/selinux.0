From: David Howells <dhowells@redhat.com>
In-Reply-To: <200712141508.23756.nickpiggin@yahoo.com.au>
References: <200712141508.23756.nickpiggin@yahoo.com.au> <20071205193818.24617.79771.stgit@warthog.procyon.org.uk> <20071205193909.24617.26538.stgit@warthog.procyon.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dhowells@redhat.com, viro@ftp.linux.org.uk, hch@infradead.org,
        Trond.Myklebust@netapp.com, sds@tycho.nsa.gov, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 10/28] FS-Cache: Recruit a couple of page flags for cache management [try #2]
Date: Mon, 17 Dec 2007 22:36:06 +0000
Message-ID: <643.1197930966@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> I'd much prefer if you would handle this in the filesystem, and have it
> set PG_private whenever fscache needs to receive a callback, and DTRT
> depending on whether PG_fscache etc. is set or not.

That's tricky and slower[*].  One of the things I want to do is to modify
iso9660 to do be able to do caching, but PG_private is 'owned' by the generic
buffer cache code.

[*] though perhaps not significantly.

> Also, this wait_on_page_fscache_write / end_page_fscache_write stuff
> seems like it would belong in your fscache headers rather than generic
> mm code (ditto for your PG_fscache checks in the page allocator -- you
> should use their PG_owner_priv_? names for that).

I suppose that's reasonable, though I do want to mention the PG_fscache* bits
in linux/page-flags.h so that anyone looking at those bits to select one to
use can easily see a reason they might not want to.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
