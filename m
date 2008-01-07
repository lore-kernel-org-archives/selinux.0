From: David Howells <dhowells@redhat.com>
In-Reply-To: <200801072233.51294.nickpiggin@yahoo.com.au>
References: <200801072233.51294.nickpiggin@yahoo.com.au> <200712211208.24026.nickpiggin@yahoo.com.au> <6481.1198175619@redhat.com> <18996.1199291223@redhat.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dhowells@redhat.com, viro@ftp.linux.org.uk, hch@infradead.org,
        Trond.Myklebust@netapp.com, sds@tycho.nsa.gov, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 10/28] FS-Cache: Recruit a couple of page flags for cache management [try #2]
Date: Mon, 07 Jan 2008 13:09:03 +0000
Message-ID: <7972.1199711343@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> No. I mean call the bit PG_private2. That way non-pagecache and
> filesystems that don't use fscache can use it.

The bit is called PG_owner_priv_2, and then 'subclassed' to PG_fscache, much
like PG_owner_priv_1 is 'subclassed' to PG_checked as was recommended.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
