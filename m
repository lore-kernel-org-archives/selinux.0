From: David Howells <dhowells@redhat.com>
Subject: [PATCH 0/3] Introduce credential record
To: viro@ftp.linux.org.uk, hch@infradead.org, Trond.Myklebust@netapp.com,
        sds@tycho.nsa.gov, casey@schaufler-ca.com
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
Date: Wed, 19 Sep 2007 17:17:49 +0100
Message-ID: <20070919161749.8334.26064.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Hi Al, Christoph, Trond, Stephen, Casey,

Here's a set of patches that implement a very basic set of COW credentials.  It
compiles, links and runs for x86_64 with EXT3, (V)FAT, NFS, AFS, SELinux and
keyrings all enabled.  Most other filesystems are disabled, apart from things
like proc.  It is not intended to completely cover the kernel at this point.

The cred struct contains the credentials that the kernel needs to act upon
something or to create something.  Credentials that govern how a task may be
acted upon remain in the task struct.

Because keyrings and effective capabilities can be installed or changed in one
process by another process, they are shadowed by the cred structure rather than
residing there.  Additionally, the session and process keyrings are shared
between all the threads of a process.  The shadowing is performed by
update_current_cred() which is invoked on entry to any system call that might
need it.

A thread's cred struct may be read by that thread without any RCU precautions
as only that thread may replace the its own cred struct.  To change a thread's
credentials, dup_cred() should be called to create a new copy, the copy should
be changed, and then set_current_cred() should be called to make it live.  Once
live, it may not be changed as it may then be shared with file descriptors, RPC
calls and other threads.  RCU will be used to dispose of the old structure.


The three patches are:

 (1) Introduce struct cred and migrate fsuid, fsgid, the groups list and the
     keyrings pointer to it.

 (2) Introduce a security pointer into the cred struct and add LSM hooks to
     duplicate the information pointed to thereby and to free it.

     Make SELinux implement the hooks, splitting out some the task security
     data to be associated with struct cred instead.

 (3) Migrate the effective capabilities mask into the cred struct.


I plan on adding a fourth patch that will allow the LSM security contents of a
cred struct to be manipulated by the kernel - something that cachefiles and
possibly NFSd will require.

To substitute a temporary set of credentials, the cred struct attached to the
task should be altered, like so:

	int get_privileged_creds(...)
	{
		/* get special privileged creds */
		my_special_cred = dup_cred(current->cred);
		change_fsuid(my_special_cred, 123);
	}

	int do_stuff(...)
	{
		struct cred *cred;

		/* rotate in the new creds, saving the old */
		cred = __set_current_cred(get_cred(my_special_cred));

		do_privileged_stuff();

		/* restore the old creds */
		set_current_cred(cred);
	}

One thing I'm not certain about is how this should interact with /proc, which
can display some of the stuff in the cred struct.  I think it may be necessary
to have a real cred pointer and an effective cred pointer, with the contents of
/proc coming from the real, but the effective governing what actually goes on.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
