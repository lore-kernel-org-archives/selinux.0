From: David Howells <dhowells@redhat.com>
In-Reply-To: <81862.27432.qm@web36605.mail.mud.yahoo.com>
References: <81862.27432.qm@web36605.mail.mud.yahoo.com>
To: casey@schaufler-ca.com
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmill@redhat.com>, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Wed, 12 Dec 2007 18:25:29 +0000
Message-ID: <32137.1197483929@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> wrote:

> You may need to have an application, say cachefileselinuxcontext, that will
> read the current policy and spit out an appropriate value of "<whatever>",
> but that can be separate and LSM specific without mucking up your basic
> infrastructure applications.

What would I do with such a thing?  How would it get run?  Spat out to where?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
