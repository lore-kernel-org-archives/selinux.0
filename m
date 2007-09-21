From: David Howells <dhowells@redhat.com>
In-Reply-To: <1190403225.6721.6.camel@heimdal.trondhjem.org>
References: <1190403225.6721.6.camel@heimdal.trondhjem.org> <20070921144703.8323.50492.stgit@warthog.procyon.org.uk> <20070921144800.8323.72246.stgit@warthog.procyon.org.uk>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: dhowells@redhat.com, viro@ftp.linux.org.uk, hch@infradead.org,
        sds@tycho.nsa.gov, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 11/22] CacheFiles: Permit the page lock state to be monitored
Date: Sat, 22 Sep 2007 00:14:41 +0100
Message-ID: <10150.1190416481@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Trond Myklebust <Trond.Myklebust@netapp.com> wrote:

> > This is used by CacheFiles to detect read completion on a page in the
> > backing filesystem so that it can then copy the data to the waiting netfs
> > page.
> 
> Won't it in any case want to lock the page too?

No.  Why would it?  All it wants to do is to read the page (copying it to the
netfs's page), assuming it becomes PG_uptodate.

> That would be the only way to ensure that the page is still mapped into the
> address space when you're writing it out...

I don't understand what you're getting at.  Write the page out where?  We've
just read it in from the cache, so why would we be writing it back out?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
