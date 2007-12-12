From: David Howells <dhowells@redhat.com>
In-Reply-To: <66139.71689.qm@web36604.mail.mud.yahoo.com>
References: <66139.71689.qm@web36604.mail.mud.yahoo.com>
To: casey@schaufler-ca.com
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmill@redhat.com>, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Wed, 12 Dec 2007 19:29:34 +0000
Message-ID: <32581.1197487774@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> wrote:

> Put the result into /etc/cachefiles.conf.

Ewww.  Runtime mangling of the configuration.  I suppose it doesn't have to be
in that file with the rest of the config.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
