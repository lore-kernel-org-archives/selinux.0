From: David Howells <dhowells@redhat.com>
In-Reply-To: <573241.88686.qm@web36613.mail.mud.yahoo.com>
References: <573241.88686.qm@web36613.mail.mud.yahoo.com>
To: casey@schaufler-ca.com
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmill@redhat.com>, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Wed, 12 Dec 2007 22:52:46 +0000
Message-ID: <698.1197499966@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> wrote:

> It would seem to me that security_secctx_to_secid() ought to suffice if the
> application code was written correctly.

That's not quite sufficient as there still needs to be a verification step to
make sure the caller is allowed to do this.

> Be aware that factors outside the LSM may be important, too. As Stephen
> points out elsewhere, Smack will require you have particular capabilities
> (CAP_MAC_OVERRIDE, CAP_MAC_ADMIN) while a DAC LSM may require
> CAP_DAC_OVERRIDE.

For what?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
