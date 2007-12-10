From: David Howells <dhowells@redhat.com>
In-Reply-To: <1197305173.18120.60.camel@moss-spartans.epoch.ncsc.mil>
References: <1197305173.18120.60.camel@moss-spartans.epoch.ncsc.mil> <20071205193818.24617.79771.stgit@warthog.procyon.org.uk> <20071205193859.24617.36392.stgit@warthog.procyon.org.uk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, viro@ftp.linux.org.uk, hch@infradead.org,
        Trond.Myklebust@netapp.com, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Mon, 10 Dec 2007 17:07:53 +0000
Message-ID: <25037.1197306473@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Stephen Smalley <sds@tycho.nsa.gov> wrote:

> > +	tsec->create_sid = SECINITSID_UNLABELED;
> > +	tsec->keycreate_sid = SECINITSID_UNLABELED;
> > +	tsec->sockcreate_sid = SECINITSID_UNLABELED;

Cleared means what?  Setting to 0?  Or is there some other constant I should
use for that?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
