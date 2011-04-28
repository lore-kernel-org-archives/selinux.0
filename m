From: Roberto Sassu <roberto.sassu@polito.it>
To: Tyler Hicks <tyhicks@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 0/7] File descriptor labeling
Date: Thu, 28 Apr 2011 14:35:07 +0200
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com, jmorris@namei.org,
        zohar@linux.vnet.ibm.com, safford@watson.ibm.com,
        kirkland@canonical.com, ecryptfs-devel@lists.launchpad.net,
        eparis@redhat.com, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        viro@zeniv.linux.org.uk, john.johansen@canonical.com,
        apparmor@lists.ubuntu.com
References: <1303907657-18366-1-git-send-email-roberto.sassu@polito.it> <4DB87A6B.7060805@schaufler-ca.com> <20110427232718.GG30854@boyd.l.tihix.com>
In-Reply-To: <20110427232718.GG30854@boyd.l.tihix.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201104281435.08273.roberto.sassu@polito.it>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, April 28, 2011 01:27:19 AM Tyler Hicks wrote:
> On Wed Apr 27, 2011 at 01:19:55PM -0700, Casey Schaufler <casey@schaufler-ca.com> wrote:
> > On 4/27/2011 5:34 AM, Roberto Sassu wrote:
> > > File descriptor labeling issue
> > >
> > > Actually SELinux and SMACK assign to file descriptors the same label of the
> > > opening process and use it in LSM hooks security_file_permission(),
> > > security_file_fcntl() and others to verify if the 'current' process has the
> > > rights to perform the requested operation.
> > >
> > > Using the credentials of the 'current' process may be not appropriate in
> > > case a file descriptor is opened by a kernel service (i.e. a filesystem)
> > > and made shared among user processes. For instance, in a system with
> > > SELinux and eCryptfs, if the process A opens an encrypted file, eCryptfs
> > > obtains a file descriptor to access the correspondent inode in the lower
> > > filesystem, labeled with the A's label.
> > >
> > > If the process B accesses the same encrypted file, it needs the 'use'
> > > permission on the A's label other than permissions for the lower inode.
> > > However, if B is the first accessing process, A needs the 'use' permission
> > > on the B's label.
> > 
> > I am having trouble understanding the argument. I will pose my
> > question in Smack terms, as I can speak most definitively in them.
> > 
> > A process running with a Smack label "A" creates a file, and that
> > file gets labeled "A", as it ought. If eCryptfs is behaving correctly
> > this ought not change. If eCryptfs in encrypting the label it needs
> > to do so in such a way as to be able to decrypt it prior to
> > presentation to the vfs layer, where it will be used in an access
> > check. When the process running with a Smack label "B" comes along
> > the vfs code will check the fetched and possibly decrypted "A"
> > against "B" and, unless there is an explicit Smack rule in place
> > granting "B" access to "A", fail.
> > 
> > What is the problem? What is eCryptfs doing that prevents this
> > from working?
> 
> Hi Casey - I think what Roberto is getting at is the way eCryptfs uses
> only one lower file per eCryptfs inode. Imagine that there are 5
> files open for ~/secret/foo at the eCryptfs layer, only 1 file is going
> to be open in the lower filesystem and all eCryptfs file operations will
> be multiplexed through it.
> 
> To make things more complicated, if the eCryptfs file is opened for
> writing, the lower file must be opened for reading and writing. This is
> because a write operation requires eCryptfs to vfs_read() from the lower
> filesystem, decrypt that data and then vfs_write() the new data.
> 
> If the lower file can't be opened O_RDWR by the calling process, the
> request is handed off to a kernel thread to open the lower file on
> behalf of the calling process. It is definitely ugly.
> 
> Roberto, I hope I correctly described the situation that you're trying
> to address. Can you tell me why we can't have a 1:1 mapping of eCryptfs
> files to lower files?
> 
> Instead of having just one lower file attached to the eCryptfs inode, we
> could have a list of opened files. There would be one for each eCryptfs
> file that was opened. ecryptfs_writepage() would have to pick, in a
> somewhat random fashion, one of the lower files to use. Of course, we
> would still need to solve the problem of opening the lower file O_RDWR
> when the calling process is only allowed write access (I may have just
> answered my own question of why the 1:1 mapping technique won't solve
> this problem).
> 

Hi Tyler

i think the 1:1 mapping isn't necessary at least from the security perspective.
Since eCryptfs is a stacked filesystem access control is performed on
both the upper and the lower layer.
ECryptfs relies on the lower filesystem for the management of extended
attributes, so this means that the security label of both the upper and
the lower inodes is the same (however this is not the current behavior
in SELinux, which assigns the label 'ecryptfs_t' to the upper inode).
In my view, for this reason the access control checks can be performed
only at the upper layer, letting eCryptfs full privileges to access inodes
in the lower filesystem.
This solves the problem of opening the lower file in r/w mode even if only
the read is requested, because at the upper layer the subject is the
accessing process with its own credentials which needs the read permission
and at the lower layer the subject is the eCryptfs kernel module with
unlimited privileges.
The issue i described in the cover letter is related to the label assigned
to the file descriptor obtained by eCryptfs (or another kernel service) when
opening an inode in the lower filesystem, which actually depends on the
first accessing process.
This label is checked against the credentials of the 'current' process in the
hook security_file_permission(), which is triggered by vfs calls (read, write,
readdir) performed on both the upper and the lower inodes.
In SELinux, a process needs the permission to 'use' a opened file descriptor.
So, having a fixed label helps in defining the rule that must be added in the
policy for eCryptfs to ensure it works properly.


PS: i'm adding in CC the Apparmor's mantainer and the mailing list to have
their opinion about the protection offered for the eCryptfs filesystem and
other kernel services. The overall thread is available at the url:

https://lkml.org/lkml/2011/4/27/201

Thanks

Roberto Sassu


> Tyler
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
