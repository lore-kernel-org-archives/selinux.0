From: David Howells <dhowells@redhat.com>
Subject: [PATCH 00/26] Permit filesystem local caching
To: sds@tycho.nsa.gov, casey@schaufler-ca.com, Trond.Myklebust@netapp.com,
        npiggin@suse.de
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Tue, 15 Jan 2008 23:46:52 +0000
Message-ID: <20080115234652.22183.24850.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



These patches add local caching for network filesystems such as NFS.

The patches can roughly be broken down into a number of sets:

  (*) 01-keys-inc-payload.diff
  (*) 02-keys-search-keyring.diff
  (*) 03-keys-callout-blob.diff

      Three patches to the keyring code made to help the CIFS people.
      Included because of patches 05-08.

  (*) 04-keys-get-label.diff

      A patch to allow the security label of a key to be retrieved.
      Included because of patches 05-08.

  (*) 05-security-current-fsugid.diff
  (*) 06-security-separate-task-bits.diff
  (*) 07-security-subjective.diff
  (*) 08-security-secctx2secid.diff
  (*) 09-security-additional-classes.diff
  (*) 10-security-kernel_service-class.diff
  (*) 11-security-kernel-service.diff

      Patches to permit the subjective security of a task to be overridden.
      All the security details in task_struct are decanted into a new struct
      that task_struct then has two pointers two: one that defines the
      objective security of that task (how other tasks may affect it) and one
      that defines the subjective security (how it may affect other objects).

      Note that I have dropped the idea of struct cred for the moment.  With
      the amount of stuff that was excluded from it, it wasn't actually any
      use to me.  However, it can be added later.

      Required for cachefiles.

  (*) 12-release-page.diff
  (*) 13-fscache-page-flags.diff
  (*) 14-add_wait_queue_tail.diff
  (*) 15-fscache.diff

      Patches to provide a local caching facility for network filesystems.

  (*) 16-cachefiles-ia64.diff
  (*) 17-cachefiles-ext3-f_mapping.diff
  (*) 18-cachefiles-write.diff
  (*) 19-cachefiles-monitor.diff
  (*) 20-cachefiles-export.diff
  (*) 21-cachefiles.diff

      Patches to provide a local cache in a directory of an already mounted
      filesystem.

  (*) 22-nfs-memleak.diff
  (*) 23-fscache-nfs.diff
  (*) 24-fscache-nfs-mount.diff
  (*) 25-fscache-nfs-display.diff
  (*) 26-fscache-nfs-persb.diff

      Patches to provide NFS with local caching.  The fifth of these patches
      makes caching configurable per superblock.

This release is mainly for the security guys (esp Stephen and Casey) to have a
look at to see if they are happy with the security stuff.

The SELinux base code will also need updating to have the security class, lest
the following error appear in dmesg:

	context_struct_compute_av:  unrecognized class 69


I know Nick Piggin has a couple of issues still, but I'll look again at those
next.

Andrew, Linus, can you please hold off on taking these patches for the moment.


--
A tarball of the patches is available at:

	http://people.redhat.com/~dhowells/fscache/patches/nfs+fscache-26.tar.bz2


To use this version of CacheFiles, the cachefilesd-0.9 is also required.  It
is available as an SRPM:

	http://people.redhat.com/~dhowells/fscache/cachefilesd-0.9-1.fc7.src.rpm

Or as individual bits:

	http://people.redhat.com/~dhowells/fscache/cachefilesd-0.9.tar.bz2
	http://people.redhat.com/~dhowells/fscache/cachefilesd.fc
	http://people.redhat.com/~dhowells/fscache/cachefilesd.if
	http://people.redhat.com/~dhowells/fscache/cachefilesd.te
	http://people.redhat.com/~dhowells/fscache/cachefilesd.spec

The .fc, .if and .te files are for manipulating SELinux.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
