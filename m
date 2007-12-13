From: David Howells <dhowells@redhat.com>
In-Reply-To: <1197557461.20226.24.camel@moss-spartans.epoch.ncsc.mil>
References: <1197557461.20226.24.camel@moss-spartans.epoch.ncsc.mil> <1197488108.1125.141.camel@moss-spartans.epoch.ncsc.mil> <66139.71689.qm@web36604.mail.mud.yahoo.com> <715.1197500109@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, casey@schaufler-ca.com,
        Karl MacMillan <kmacmill@redhat.com>, viro@ftp.linux.org.uk,
        hch@infradead.org, Trond.Myklebust@netapp.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Thu, 13 Dec 2007 16:03:47 +0000
Message-ID: <21903.1197561827@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> 
> Yes, we could easily make a simple program that just invokes a
> libselinux function that in turn grabs the proper context from some
> context configuration file under /etc/selinux/$SELINUXTYPE/contexts/ and
> outputs it.  Dan can help with that.

That sounds nicely genericisable, perhaps even for any LSM.

	/usr/bin/lsm-get-context cachefiles

It does have to be able to come up with different contexts for different
caches, but that can be controlled by changing the name supplied to it.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
