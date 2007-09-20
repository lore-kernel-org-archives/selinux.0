From: David Howells <dhowells@redhat.com>
In-Reply-To: <46F1F2EE.1010904@kernel.org>
References: <46F1F2EE.1010904@kernel.org> <20070919161749.8334.26064.stgit@warthog.procyon.org.uk> <20070919161805.8334.96808.stgit@warthog.procyon.org.uk>
To: Andrew Morgan <morgan@kernel.org>
Cc: dhowells@redhat.com, viro@ftp.linux.org.uk, hch@infradead.org,
        Trond.Myklebust@netapp.com, sds@tycho.nsa.gov, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 3/3] CRED: Move the effective capabilities into the cred struct
Date: Thu, 20 Sep 2007 09:15:15 +0100
Message-ID: <10709.1190276115@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Andrew Morgan <morgan@kernel.org> wrote:

> OOC If we were to simply drop support for one process changing the
> capabilities of another, would we need this patch?

Well, the patch could be less, but there's still the possibility of a kernel
service wanting to override the capabilities mask.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
