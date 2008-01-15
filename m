From: David Howells <dhowells@redhat.com>
In-Reply-To: <1200409002.9669.43.camel@moss-spartans.epoch.ncsc.mil>
References: <1200409002.9669.43.camel@moss-spartans.epoch.ncsc.mil> <1199902278.9393.283.camel@moss-spartans.epoch.ncsc.mil> <1197307397.18120.72.camel@moss-spartans.epoch.ncsc.mil> <1197305173.18120.60.camel@moss-spartans.epoch.ncsc.mil> <20071205193818.24617.79771.stgit@warthog.procyon.org.uk> <20071205193859.24617.36392.stgit@warthog.procyon.org.uk> <25037.1197306473@redhat.com> <17868.1199897484@redhat.com> <3466.1200319279@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: dhowells@redhat.com, Daniel J Walsh <dwalsh@redhat.com>,
        casey@schaufler-ca.com, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Tue, 15 Jan 2008 16:03:17 +0000
Message-ID: <32507.1200412997@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> >  (3) Check that the kernel may create files as a particular secid (this
> >      could be specified indirectly by specifying an inode, which would
> >      hide the secid inside the LSM).
> 
> I don't think this check is on the kernel per se but rather the ability
> of the daemon to nominate a secid for use on files created later by the
> kernel module.

Hmmm...  At the moment the cachefiles module works out for itself what the
file label should be by looking at the root directory it was given and
assuming the label on that is what it's going to be using.  Are you suggesting
this should be specified directly instead by the daemon?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
