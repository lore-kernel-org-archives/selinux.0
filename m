From: David Howells <dhowells@redhat.com>
In-Reply-To: <1197488108.1125.141.camel@moss-spartans.epoch.ncsc.mil>
References: <1197488108.1125.141.camel@moss-spartans.epoch.ncsc.mil> <66139.71689.qm@web36604.mail.mud.yahoo.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, casey@schaufler-ca.com,
        Karl MacMillan <kmacmill@redhat.com>, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Wed, 12 Dec 2007 22:55:09 +0000
Message-ID: <715.1197500109@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> More likely, run it at build time in your .spec file to generate
> cachefiles.conf,

I don't think sticking it in cachefiles.conf is a good idea necessarily.
That has to be an administrator modifiable file.  Is there a program I could
make cachefiles run directly and capture the output of that could give me the
info I want?

> then run it again maybe upon a policy update or if the user selects a
> different policy.

How do I do that?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
