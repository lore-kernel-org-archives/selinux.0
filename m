From: David Howells <dhowells@redhat.com>
In-Reply-To: <200801081401.11975.nickpiggin@yahoo.com.au>
References: <200801081401.11975.nickpiggin@yahoo.com.au> <200801072233.51294.nickpiggin@yahoo.com.au> <18996.1199291223@redhat.com> <7972.1199711343@redhat.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: dhowells@redhat.com, viro@ftp.linux.org.uk, hch@infradead.org,
        Trond.Myklebust@netapp.com, sds@tycho.nsa.gov, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 10/28] FS-Cache: Recruit a couple of page flags for cache management [try #2]
Date: Tue, 08 Jan 2008 23:51:24 +0000
Message-ID: <31207.1199836284@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > > No. I mean call the bit PG_private2. That way non-pagecache and
> > > filesystems that don't use fscache can use it.
> >
> > The bit is called PG_owner_priv_2, and then 'subclassed' to PG_fscache,
> > much like PG_owner_priv_1 is 'subclassed' to PG_checked as was recommended.
> 
> It is not owner_priv if you're putting checks and tests into core
> kernel pagecache code for it. owner_priv means a filesystem has it
> _all_ to itself.

Okay, I'll change it if it makes you happy.  Bear in mind, though, you're
dictating instructions that conflict with those other people have dictated.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
