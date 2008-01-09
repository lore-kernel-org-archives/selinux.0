Subject: Re: [PATCH 08/28] SECURITY: Allow kernel services to override LSM
	settings for task actions [try #2]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
In-Reply-To: <17868.1199897484@redhat.com>
References: <1197307397.18120.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1197305173.18120.60.camel@moss-spartans.epoch.ncsc.mil>
	 <20071205193818.24617.79771.stgit@warthog.procyon.org.uk>
	 <20071205193859.24617.36392.stgit@warthog.procyon.org.uk>
	 <25037.1197306473@redhat.com>  <17868.1199897484@redhat.com>
Content-Type: text/plain
Date: Wed, 09 Jan 2008 13:11:18 -0500
Message-Id: <1199902278.9393.283.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-01-09 at 16:51 +0000, David Howells wrote:
> Okay.  I can:
> 
>  (1) Have cachefilesd (the daemon) pass a security context string to the
>      cachefiles kernel module, which can then convert it to a secID.  It'll
>      require a security_secctx_to_secid() function, but I'm fairly certain I
>      have a patch to add such kicking around somewhere.

Already planned for 2.6.25, see:
http://marc.info/?l=selinux&m=119973017423487&w=2

That is in the labeled networking tree.

>  (2) Make security_task_kernel_act_as() take a task_security struct and a
>      secID and just assign the latter to the former.  I'm not sure it makes
>      sense to do any checks here, other than checking that under SELinux the
>      secID is of SECCLASS_PROCESS class.
> 
> However, I need to write a check that the cachefilesd daemon is permitted to
> nominate the secID it did.  Can someone tell me how to do this?  The obvious
> way to do this is to add another PROCESS__xxx security permit specifically for
> cachefiles, but that seems like a waste of a bit when there are only two spare
> bits.
> 
> 	avc_has_perm(daemon_tsec->sid, nominated_sid,
> 		     SECCLASS_PROCESS, PROCESS__CACHEFILES_USE, NULL);
> 
> Now, I recall the addition of another security class being mentioned, which
> presumably would give something like:
> 
> 	avc_has_perm(daemon_tsec->sid, nominated_sid,
> 		     SECCLASS_CACHE, CACHE__USE_AS_OVERRIDE, NULL);
> 
> And I assume this doesn't care if one, the other or both of the two SIDs
> mentioned are of SECCLASS_PROCESS rather than of SECCLASS_CACHE.

Right, the latter is reasonable.
Requires adding the class and permission definition to
policy/flask/security_classes and policy/flask/access_vectors and then
regenerating the kernel headers from those files, ala:
  svn co http://oss.tresys.com/repos/refpolicy/trunk refpolicy
  cd refpolicy/policy/flask
  vi security_classes access_vectors
  <add new class to end>
  make
  make LINUX_D=/path/to/linux-2.6 tokern
 
Dan knows how to do that.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
