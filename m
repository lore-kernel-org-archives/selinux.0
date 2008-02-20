Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1KJxMnu030568
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 14:59:22 -0500
Received: from e6.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1KJxKfY000377
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 19:59:20 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1KK0FJZ008295
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 15:00:15 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m1KJwJKH208200
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 14:58:19 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m1KJwI2o006763
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 14:58:18 -0500
Date: Wed, 20 Feb 2008 13:58:11 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: Trond.Myklebust@netapp.com, chuck.lever@oracle.com, casey@schaufler-ca.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 00/37] Permit filesystem local caching
Message-ID: <20080220195811.GD16668@sergelap.austin.ibm.com>
References: <20080220160557.4715.66608.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080220160557.4715.66608.stgit@warthog.procyon.org.uk>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting David Howells (dhowells@redhat.com):
> 
> 
> These patches add local caching for network filesystems such as NFS.
> 
> The patches can roughly be broken down into a number of sets:
> 
>   (*) 01-keys-inc-payload.diff
>   (*) 02-keys-search-keyring.diff
>   (*) 03-keys-callout-blob.diff
> 
>       Three patches to the keyring code made to help the CIFS people.
>       Included because of patches 05-08.
> 
>   (*) 04-keys-get-label.diff
> 
>       A patch to allow the security label of a key to be retrieved.
>       Included because of patches 05-08.
> 
>   (*) 05-security-current-fsugid.diff
>   (*) 06-security-separate-task-bits.diff

Seems *really* weird that every time you send this, patch 6 doesn't seem
to reach me in any of my mailboxes...  (did get it from the url
you listed)

I'm sorry if I miss where you explicitly state this, but is it safe to
assume, as perusing the patches suggests, that

	1. tsk->sec never changes other than in task_alloc_security()?  

	2. tsk->act_as is only ever dereferenced from (a) current->
	   except (b) in do_coredump?

(thereby carefully avoiding locking issues)

I'd still like to see some performance numbers.  Not to object to
these patches, just to make sure there's no need to try and optimize
more of the dereferences away when they're not needed.

Oh, manually copied from patch 6, I see you have in the task_security
struct definition:

	kernel_cap_t    cap_bset;       /* ? */

That comment can be filled in with 'capability bounding set' (for this
task and all its future descendents).

thanks,
-serge

>   (*) 07-security-subjective.diff
>   (*) 08-security-kernel_service-class.diff
>   (*) 09-security-kernel-service.diff
>   (*) 10-security-nfsd.diff
> 
>       Patches to permit the subjective security of a task to be overridden.
>       All the security details in task_struct are decanted into a new struct
>       that task_struct then has two pointers two: one that defines the
>       objective security of that task (how other tasks may affect it) and one
>       that defines the subjective security (how it may affect other objects).
> 
>       Note that I have dropped the idea of struct cred for the moment.  With
>       the amount of stuff that was excluded from it, it wasn't actually any
>       use to me.  However, it can be added later.
> 
>       Required for cachefiles.
> 
>   (*) 11-release-page.diff
>   (*) 12-fscache-page-flags.diff
>   (*) 13-add_wait_queue_tail.diff
>   (*) 14-fscache.diff
> 
>       Patches to provide a local caching facility for network filesystems.
> 
>   (*) 15-cachefiles-ia64.diff
>   (*) 16-cachefiles-ext3-f_mapping.diff
>   (*) 17-cachefiles-write.diff
>   (*) 18-cachefiles-monitor.diff
>   (*) 19-cachefiles-export.diff
>   (*) 20-cachefiles.diff
> 
>       Patches to provide a local cache in a directory of an already mounted
>       filesystem.
> 
>   (*) 21-nfs-comment.diff
>   (*) 22-nfs-fscache-option.diff
>   (*) 23-nfs-fscache-kconfig.diff
>   (*) 24-nfs-fscache-top-index.diff
>   (*) 25-nfs-fscache-server-obj.diff
>   (*) 26-nfs-fscache-super-obj.diff
>   (*) 27-nfs-fscache-inode-obj.diff
>   (*) 28-nfs-fscache-use-inode.diff
>   (*) 29-nfs-fscache-invalidate-pages.diff
>   (*) 30-nfs-fscache-iostats.diff
>   (*) 31-nfs-fscache-page-management.diff
>   (*) 32-nfs-fscache-read-context.diff
>   (*) 33-nfs-fscache-read-fallback.diff
>   (*) 34-nfs-fscache-read-from-cache.diff
>   (*) 35-nfs-fscache-store-to-cache.diff
>   (*) 36-nfs-fscache-mount.diff
>   (*) 37-nfs-fscache-display.diff
> 
>       Patches to provide NFS with local caching.
> 
>       A couple of questions on the NFS iostat changes: (1) Should I update the
>       iostat version number; (2) is it permitted to have conditional iostats?
> 
> 
> I've brought the patchset up to date with respect to the 2.6.25-rc1 merge
> window, in particular altering Smack to handle the split in objective and
> subjective security in the task_struct.
> 
> --
> A tarball of the patches is available at:
> 
> 	http://people.redhat.com/~dhowells/fscache/patches/nfs+fscache-30.tar.bz2
> 
> 
> To use this version of CacheFiles, the cachefilesd-0.9 is also required.  It
> is available as an SRPM:
> 
> 	http://people.redhat.com/~dhowells/fscache/cachefilesd-0.9-1.fc7.src.rpm
> 
> Or as individual bits:
> 
> 	http://people.redhat.com/~dhowells/fscache/cachefilesd-0.9.tar.bz2
> 	http://people.redhat.com/~dhowells/fscache/cachefilesd.fc
> 	http://people.redhat.com/~dhowells/fscache/cachefilesd.if
> 	http://people.redhat.com/~dhowells/fscache/cachefilesd.te
> 	http://people.redhat.com/~dhowells/fscache/cachefilesd.spec
> 
> The .fc, .if and .te files are for manipulating SELinux.
> 
> David
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
