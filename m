From: David Howells <dhowells@redhat.com>
In-Reply-To: <10249.1190416956@redhat.com>
References: <10249.1190416956@redhat.com> <46F3F8BF.1030404@redhat.com> <20070921144703.8323.50492.stgit@warthog.procyon.org.uk> <20070921144815.8323.77745.stgit@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Peter Staubach <staubach@redhat.com>,
        viro@ftp.linux.org.uk, hch@infradead.org, Trond.Myklebust@netapp.com,
        sds@tycho.nsa.gov, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 14/22] NFS: Use local caching
Date: Sat, 22 Sep 2007 00:37:26 +0100
Message-ID: <10304.1190417846@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David Howells <dhowells@redhat.com> wrote:

> Peter Staubach <staubach@redhat.com> wrote:
> 
> > Did I miss the section where the modified semantics about which
> > mounted file systems can use the cache and which ones can not
> > was implemented?
> 
> Yes.

fs/nfs/super.c:

		case Opt_sharecache:
			mnt->flags &= ~NFS_MOUNT_UNSHARED;
			break;
		case Opt_nosharecache:
			mnt->flags |= NFS_MOUNT_UNSHARED;
			mnt->options &= ~NFS_OPTION_FSCACHE;
			break;
		case Opt_fscache:
			/* sharing is mandatory with fscache */
			mnt->options |= NFS_OPTION_FSCACHE;
			mnt->flags &= ~NFS_MOUNT_UNSHARED;
			break;
		case Opt_nofscache:
			mnt->options &= ~NFS_OPTION_FSCACHE;
			break;

Hmmm...  Actually, I'm not sure this is sufficient.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
