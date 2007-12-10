From: David Howells <dhowells@redhat.com>
In-Reply-To: <370690.53043.qm@web36615.mail.mud.yahoo.com>
References: <370690.53043.qm@web36615.mail.mud.yahoo.com>
To: casey@schaufler-ca.com
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmill@redhat.com>, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Mon, 10 Dec 2007 23:44:18 +0000
Message-ID: <25991.1197330258@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> wrote:

> That happens to me when interfaces are described in SELinux terms. I
> still don't care much for multiple contexts, and I don't have a good
> grasp of how you'll deal with Smack, or any LSM other than SELinux.

Me neither.  I understand SELinux somewhat, though it's got a lot of wibbly
bits, and WinNT's security system, but I have no experience of the other
stuff.

> Just as Stephen mentions, I also don't see the generality that a change
> of this magnitude really ought to provide.

Perhaps it should be a specific interface, solely for cachefiles's use then.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
