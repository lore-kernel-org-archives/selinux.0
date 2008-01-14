From: David Howells <dhowells@redhat.com>
In-Reply-To: <3466.1200319279@redhat.com>
References: <3466.1200319279@redhat.com> <1199902278.9393.283.camel@moss-spartans.epoch.ncsc.mil> <1197307397.18120.72.camel@moss-spartans.epoch.ncsc.mil> <1197305173.18120.60.camel@moss-spartans.epoch.ncsc.mil> <20071205193818.24617.79771.stgit@warthog.procyon.org.uk> <20071205193859.24617.36392.stgit@warthog.procyon.org.uk> <25037.1197306473@redhat.com> <17868.1199897484@redhat.com> 
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM settings for task actions [try #2]
Date: Mon, 14 Jan 2008 14:06:17 +0000
Message-ID: <3524.1200319577@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David Howells <dhowells@redhat.com> wrote:

> Okay...  It looks like I want four security operations/hooks for cachefiles:

FYI, I added the following vectors:

	# kernel services that need to override task security
	class kernel_service
	{
		use_as_override
		create_files_as
	}

The first allows:

	avc_has_perm(daemon_tsec->sid, nominated_sid,
		     SECCLASS_KERNEL_SERVICE,
		     KERNEL_SERVICE__USE_AS_OVERRIDE,
		     NULL);

And the second something like:

	avc_has_perm(tsec->sid, inode->sid,
		     SECCLASS_KERNEL_SERVICE,
		     KERNEL_SERVICE__CREATE_FILES_AS,
		     NULL);

Rather than specifically dedicating them to the cache, I made them general.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
