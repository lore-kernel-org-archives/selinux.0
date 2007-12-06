From: David Howells <dhowells@redhat.com>
In-Reply-To: <1196887108.16006.121.camel@moss-spartans.epoch.ncsc.mil>
References: <1196887108.16006.121.camel@moss-spartans.epoch.ncsc.mil> <138670.64371.qm@web36609.mail.mud.yahoo.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Cc: dhowells@redhat.com, casey@schaufler-ca.com, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 4/7] KEYS: Add keyctl function to get a security label
Date: Thu, 06 Dec 2007 01:28:25 +0000
Message-ID: <25702.1196904505@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> inode_getsecurity and getprocattr directly return the strings.
> Admittedly, the whole interface could be cleaned up and made far more
> consistent, but I don't think he necessarily has to go through the
> getsecid + secid_to_secctx sequence if he only wants the secctx.

It's what Daniel Walsh wanted.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
