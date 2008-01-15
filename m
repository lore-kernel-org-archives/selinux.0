Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM
	settings for task actions [try #2]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <3524.1200319577@redhat.com>
References: <3466.1200319279@redhat.com>
	 <1199902278.9393.283.camel@moss-spartans.epoch.ncsc.mil>
	 <1197307397.18120.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1197305173.18120.60.camel@moss-spartans.epoch.ncsc.mil>
	 <20071205193818.24617.79771.stgit@warthog.procyon.org.uk>
	 <20071205193859.24617.36392.stgit@warthog.procyon.org.uk>
	 <25037.1197306473@redhat.com> <17868.1199897484@redhat.com>
	 <3524.1200319577@redhat.com>
Content-Type: text/plain
Date: Tue, 15 Jan 2008 09:58:48 -0500
Message-Id: <1200409128.9669.46.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-01-14 at 14:06 +0000, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > Okay...  It looks like I want four security operations/hooks for cachefiles:
> 
> FYI, I added the following vectors:
> 
> 	# kernel services that need to override task security
> 	class kernel_service
> 	{
> 		use_as_override
> 		create_files_as
> 	}
> 
> The first allows:
> 
> 	avc_has_perm(daemon_tsec->sid, nominated_sid,
> 		     SECCLASS_KERNEL_SERVICE,
> 		     KERNEL_SERVICE__USE_AS_OVERRIDE,
> 		     NULL);
> 
> And the second something like:
> 
> 	avc_has_perm(tsec->sid, inode->sid,
> 		     SECCLASS_KERNEL_SERVICE,
> 		     KERNEL_SERVICE__CREATE_FILES_AS,
> 		     NULL);
> 
> Rather than specifically dedicating them to the cache, I made them general.

Make sure that you or Dan submits a policy patch to register these
classes and permissions in the policy when the kernel patch is queued
for merge.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
