Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM
	settings for task actions [try #2]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <3466.1200319279@redhat.com>
References: <1199902278.9393.283.camel@moss-spartans.epoch.ncsc.mil>
	 <1197307397.18120.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1197305173.18120.60.camel@moss-spartans.epoch.ncsc.mil>
	 <20071205193818.24617.79771.stgit@warthog.procyon.org.uk>
	 <20071205193859.24617.36392.stgit@warthog.procyon.org.uk>
	 <25037.1197306473@redhat.com> <17868.1199897484@redhat.com>
	 <3466.1200319279@redhat.com>
Content-Type: text/plain
Date: Tue, 15 Jan 2008 09:56:42 -0500
Message-Id: <1200409002.9669.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-01-14 at 14:01 +0000, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > > 	avc_has_perm(daemon_tsec->sid, nominated_sid,
> > > 		     SECCLASS_CACHE, CACHE__USE_AS_OVERRIDE, NULL);
> > > 
> > > And I assume this doesn't care if one, the other or both of the two SIDs
> > > mentioned are of SECCLASS_PROCESS rather than of SECCLASS_CACHE.
> > 
> > Right, the latter is reasonable.
> 
> Okay...  It looks like I want four security operations/hooks for cachefiles:
> 
>  (1) Check that a daemon can nominate a secid for use by the kernel to override
>      the process subjective secid.
> 
>  (2) Set the secid mentioned in (1).
> 
>  (3) Check that the kernel may create files as a particular secid (this could
>      be specified indirectly by specifying an inode, which would hide the secid
>      inside the LSM).

I don't think this check is on the kernel per se but rather the ability
of the daemon to nominate a secid for use on files created later by the
kernel module.

>  (4) Set the fscreate secid mentioned in (3).
> 
> Now, it's possible to condense (1) and (2) into a single op, and condense (3)
> and (4) into a single op.  That, however, might make the ops unusable by nfsd,
> which may well want to bypass the checks or do them elsewhere.
> 
> Any thoughts?

I think it is fine to combine them.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
