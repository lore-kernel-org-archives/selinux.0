From: David Howells <dhowells@redhat.com>
In-Reply-To: <200712211208.24026.nickpiggin@yahoo.com.au>
References: <200712211208.24026.nickpiggin@yahoo.com.au> <200712181800.23578.nickpiggin@yahoo.com.au> <643.1197930966@redhat.com> <6481.1198175619@redhat.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dhowells@redhat.com, viro@ftp.linux.org.uk, hch@infradead.org,
        Trond.Myklebust@netapp.com, sds@tycho.nsa.gov, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 10/28] FS-Cache: Recruit a couple of page flags for cache management [try #2]
Date: Wed, 02 Jan 2008 16:27:03 +0000
Message-ID: <18996.1199291223@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Then make a PG_private2 bit and use that.

To what end?  Are you suggesting I should have:

	PG_private2 = PG_private | PG_fscache

That's redundant information and doesn't help anything really.

My suggestion (PG_private and PG_fscache separate and independent) is pretty
efficient to actually render into machine instructions, especially if the two
bits are placed in the lower part of the word.  On x86, the test for both bits
can be done with a single TEST instruction, and on most RISC archs, a MOVE and
a single AND will usually suffice.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
