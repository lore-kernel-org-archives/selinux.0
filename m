From: Roberto Sassu <roberto.sassu@polito.it>
To: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC][PATCH 0/7] File descriptor labeling
Date: Fri, 29 Apr 2011 11:26:49 +0200
Cc: Tyler Hicks <tyhicks@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com, jmorris@namei.org,
        zohar@linux.vnet.ibm.com, safford@watson.ibm.com,
        kirkland@canonical.com, ecryptfs-devel@lists.launchpad.net,
        eparis@redhat.com, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        viro@zeniv.linux.org.uk, john.johansen@canonical.com,
        apparmor@lists.ubuntu.com
References: <1303907657-18366-1-git-send-email-roberto.sassu@polito.it> <201104281435.08273.roberto.sassu@polito.it> <4DB9A5D9.7030607@schaufler-ca.com>
In-Reply-To: <4DB9A5D9.7030607@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
  boundary="Boundary-01=_ZRouNQpkziq70rZ"
Message-Id: <201104291126.50067.roberto.sassu@polito.it>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-01=_ZRouNQpkziq70rZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Thursday, April 28, 2011 07:37:29 PM Casey Schaufler wrote:
> On 4/28/2011 5:35 AM, Roberto Sassu wrote:
> > On Thursday, April 28, 2011 01:27:19 AM Tyler Hicks wrote:
> >> On Wed Apr 27, 2011 at 01:19:55PM -0700, Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>> On 4/27/2011 5:34 AM, Roberto Sassu wrote:
> >>>> File descriptor labeling issue
> >>>>
> >>>> Actually SELinux and SMACK assign to file descriptors the same label of the
> >>>> opening process and use it in LSM hooks security_file_permission(),
> >>>> security_file_fcntl() and others to verify if the 'current' process has the
> >>>> rights to perform the requested operation.
> >>>>
> >>>> Using the credentials of the 'current' process may be not appropriate in
> >>>> case a file descriptor is opened by a kernel service (i.e. a filesystem)
> >>>> and made shared among user processes. For instance, in a system with
> >>>> SELinux and eCryptfs, if the process A opens an encrypted file, eCryptfs
> >>>> obtains a file descriptor to access the correspondent inode in the lower
> >>>> filesystem, labeled with the A's label.
> >>>>
> >>>> If the process B accesses the same encrypted file, it needs the 'use'
> >>>> permission on the A's label other than permissions for the lower inode.
> >>>> However, if B is the first accessing process, A needs the 'use' permission
> >>>> on the B's label.
> >>> I am having trouble understanding the argument. I will pose my
> >>> question in Smack terms, as I can speak most definitively in them.
> >>>
> >>> A process running with a Smack label "A" creates a file, and that
> >>> file gets labeled "A", as it ought. If eCryptfs is behaving correctly
> >>> this ought not change. If eCryptfs in encrypting the label it needs
> >>> to do so in such a way as to be able to decrypt it prior to
> >>> presentation to the vfs layer, where it will be used in an access
> >>> check. When the process running with a Smack label "B" comes along
> >>> the vfs code will check the fetched and possibly decrypted "A"
> >>> against "B" and, unless there is an explicit Smack rule in place
> >>> granting "B" access to "A", fail.
> >>>
> >>> What is the problem? What is eCryptfs doing that prevents this
> >>> from working?
> >> Hi Casey - I think what Roberto is getting at is the way eCryptfs uses
> >> only one lower file per eCryptfs inode. Imagine that there are 5
> >> files open for ~/secret/foo at the eCryptfs layer, only 1 file is going
> >> to be open in the lower filesystem and all eCryptfs file operations will
> >> be multiplexed through it.
> >>
> >> To make things more complicated, if the eCryptfs file is opened for
> >> writing, the lower file must be opened for reading and writing. This is
> >> because a write operation requires eCryptfs to vfs_read() from the lower
> >> filesystem, decrypt that data and then vfs_write() the new data.
> >>
> >> If the lower file can't be opened O_RDWR by the calling process, the
> >> request is handed off to a kernel thread to open the lower file on
> >> behalf of the calling process. It is definitely ugly.
> >>
> >> Roberto, I hope I correctly described the situation that you're trying
> >> to address. Can you tell me why we can't have a 1:1 mapping of eCryptfs
> >> files to lower files?
> >>
> >> Instead of having just one lower file attached to the eCryptfs inode, we
> >> could have a list of opened files. There would be one for each eCryptfs
> >> file that was opened. ecryptfs_writepage() would have to pick, in a
> >> somewhat random fashion, one of the lower files to use. Of course, we
> >> would still need to solve the problem of opening the lower file O_RDWR
> >> when the calling process is only allowed write access (I may have just
> >> answered my own question of why the 1:1 mapping technique won't solve
> >> this problem).
> >>
> > Hi Tyler
> >
> > i think the 1:1 mapping isn't necessary at least from the security perspective.
> > Since eCryptfs is a stacked filesystem access control is performed on
> > both the upper and the lower layer.
> > ECryptfs relies on the lower filesystem for the management of extended
> > attributes, so this means that the security label of both the upper and
> > the lower inodes is the same (however this is not the current behavior
> > in SELinux, which assigns the label 'ecryptfs_t' to the upper inode).
> 
> Where does this assignment occur?
> 

Hi Casey

The assignment happens at the inode's initialization time and depends on
the behavior configured for a specific filesystem.
The SELinux reference policy actually configures static labeling for inodes
in the eCryptfs filesystem while for example allows ext4 inodes to be
initialized using extended attributes.


> > In my view, for this reason the access control checks can be performed
> > only at the upper layer, letting eCryptfs full privileges to access inodes
> > in the lower filesystem.
> 
> On this point I most strongly disagree.
> 
> The behavior of a filesystem and the data that it uses to determine
> that behavior is wrought with complex interactions which may include
> but are not limited to caching, read-aheads, garbage collection,
> and various side effects of access control. If eCryptfs needs to go
> mucking about with the data used by the underlying filesystem it is
> not stacking properly. A stacked filesystem has no business whatever
> changing the data of the underlying filesystem.
> 

Ok, probably i have to go more in deep to explain how access control is
performed on eCryptfs. I'm talking for the SELinux's case, so SELinux experts
can correct me if i'm wrong.

First, i want to use extended attributes to initialize an eCryptfs inode, so
both the upper and the lower inodes have the same security context
because eCryptfs calls the *xattr() methods of the underlying filesystem.

Then, the process A accesses the eCryptfs inode 'I'. On the upper layer access
control is performed using the credentials of the 'current' process and the
security context of I.

If the process is allowed to access the upper inode, eCryptfs opens the lower
inode, presenting its own credentials with the type 'kernel_t'. Then, SELinux
checks if 'kernel_t' can access the inode with the security context of 'I'. If so,
eCryptfs obtains a file descriptor which, in this patch set, is labeled using the
same credentials it provided at open time and binds it to the upper inode.

Suppose for a moment that A is working on the eCryptfs inode 'I' and the process
B requests the same inode. ECryptfs uses the already opened file descriptor and
B will be granted to open the requested inode if:

- B has the 'open' permission on the upper inode 'I';


and can perform read/write operations if:

- B has the 'read' and 'write' permissions on the upper inode 'I';
- B is allowed to use the file descriptor opened by eCryptfs ('kernel_t').
- B has the 'read' and 'write' permissions on the lower inode I;


What i miss to say in my previous email is that even if eCryptfs is granted
to access inodes in the lower filesystem with full privileges, user processes
still need the permission to deal with the lower inode, but the check on the
upper inode is sufficient because the security context is the same.

Roberto Sassu


> > This solves the problem of opening the lower file in r/w mode even if only
> > the read is requested, because at the upper layer the subject is the
> > accessing process with its own credentials which needs the read permission
> > and at the lower layer the subject is the eCryptfs kernel module with
> > unlimited privileges.
> 
> Excuse my ignorance for a moment. Is eCryptfs a user mode filesystem,
> or in the kernel properly? The behavior makes it sound like the former
> while the interfaces you're requesting make it seem like the latter.
> 
> > The issue i described in the cover letter is related to the label assigned
> > to the file descriptor obtained by eCryptfs (or another kernel service) when
> > opening an inode in the lower filesystem, which actually depends on the
> > first accessing process.
> > This label is checked against the credentials of the 'current' process in the
> > hook security_file_permission(), which is triggered by vfs calls (read, write,
> > readdir) performed on both the upper and the lower inodes.
> > In SELinux, a process needs the permission to 'use' a opened file descriptor.
> > So, having a fixed label helps in defining the rule that must be added in the
> > policy for eCryptfs to ensure it works properly.
> 
> I'm afraid to suggest this, but it looks as if you may be
> able to solve your problems with some SELinux policy. I am
> of course not an expert on SELinux policy, but it looks as
> if not specifying an appropriate policy for the user space
> component is what is in the way here.
> 
> > PS: i'm adding in CC the Apparmor's mantainer and the mailing list to have
> > their opinion about the protection offered for the eCryptfs filesystem and
> > other kernel services. The overall thread is available at the url:
> >
> > https://lkml.org/lkml/2011/4/27/201
> >
> > Thanks
> >
> > Roberto Sassu
> >
> >
> >> Tyler
> >>
> >
> 
> 

--Boundary-01=_ZRouNQpkziq70rZ
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'Sans Serif'; font-size:10pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">On Thursday, April 28, 2011 07:37:29 PM Casey Schaufler wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; On 4/28/2011 5:35 AM, Roberto Sassu wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; On Thursday, April 28, 2011 01:27:19 AM Tyler Hicks wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; On Wed Apr 27, 2011 at 01:19:55PM -0700, Casey Schaufler &lt;casey@schaufler-ca.com&gt; wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt; On 4/27/2011 5:34 AM, Roberto Sassu wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt; File descriptor labeling issue</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt; Actually SELinux and SMACK assign to file descriptors the same label of the</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt; opening process and use it in LSM hooks security_file_permission(),</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt; security_file_fcntl() and others to verify if the 'current' process has the</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt; rights to perform the requested operation.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt; Using the credentials of the 'current' process may be not appropriate in</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt; case a file descriptor is opened by a kernel service (i.e. a filesystem)</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt; and made shared among user processes. For instance, in a system with</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt; SELinux and eCryptfs, if the process A opens an encrypted file, eCryptfs</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt; obtains a file descriptor to access the correspondent inode in the lower</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt; filesystem, labeled with the A's label.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt; If the process B accesses the same encrypted file, it needs the 'use'</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt; permission on the A's label other than permissions for the lower inode.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt; However, if B is the first accessing process, A needs the 'use' permission</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;&gt; on the B's label.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt; I am having trouble understanding the argument. I will pose my</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt; question in Smack terms, as I can speak most definitively in them.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt; A process running with a Smack label &quot;A&quot; creates a file, and that</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt; file gets labeled &quot;A&quot;, as it ought. If eCryptfs is behaving correctly</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt; this ought not change. If eCryptfs in encrypting the label it needs</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt; to do so in such a way as to be able to decrypt it prior to</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt; presentation to the vfs layer, where it will be used in an access</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt; check. When the process running with a Smack label &quot;B&quot; comes along</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt; the vfs code will check the fetched and possibly decrypted &quot;A&quot;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt; against &quot;B&quot; and, unless there is an explicit Smack rule in place</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt; granting &quot;B&quot; access to &quot;A&quot;, fail.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt; What is the problem? What is eCryptfs doing that prevents this</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;&gt; from working?</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; Hi Casey - I think what Roberto is getting at is the way eCryptfs uses</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; only one lower file per eCryptfs inode. Imagine that there are 5</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; files open for ~/secret/foo at the eCryptfs layer, only 1 file is going</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; to be open in the lower filesystem and all eCryptfs file operations will</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; be multiplexed through it.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; To make things more complicated, if the eCryptfs file is opened for</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; writing, the lower file must be opened for reading and writing. This is</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; because a write operation requires eCryptfs to vfs_read() from the lower</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; filesystem, decrypt that data and then vfs_write() the new data.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; If the lower file can't be opened O_RDWR by the calling process, the</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; request is handed off to a kernel thread to open the lower file on</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; behalf of the calling process. It is definitely ugly.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; Roberto, I hope I correctly described the situation that you're trying</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; to address. Can you tell me why we can't have a 1:1 mapping of eCryptfs</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; files to lower files?</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; Instead of having just one lower file attached to the eCryptfs inode, we</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; could have a list of opened files. There would be one for each eCryptfs</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; file that was opened. ecryptfs_writepage() would have to pick, in a</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; somewhat random fashion, one of the lower files to use. Of course, we</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; would still need to solve the problem of opening the lower file O_RDWR</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; when the calling process is only allowed write access (I may have just</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; answered my own question of why the 1:1 mapping technique won't solve</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; this problem).</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; Hi Tyler</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; i think the 1:1 mapping isn't necessary at least from the security perspective.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; Since eCryptfs is a stacked filesystem access control is performed on</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; both the upper and the lower layer.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; ECryptfs relies on the lower filesystem for the management of extended</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; attributes, so this means that the security label of both the upper and</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; the lower inodes is the same (however this is not the current behavior</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; in SELinux, which assigns the label 'ecryptfs_t' to the upper inode).</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; Where does this assignment occur?</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Hi Casey</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">The assignment happens at the inode's initialization time and depends on</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">the behavior configured for a specific filesystem.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">The SELinux reference policy actually configures static labeling for inodes</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">in the eCryptfs filesystem while for example allows ext4 inodes to be</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">initialized using extended attributes.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; In my view, for this reason the access control checks can be performed</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; only at the upper layer, letting eCryptfs full privileges to access inodes</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; in the lower filesystem.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; On this point I most strongly disagree.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; The behavior of a filesystem and the data that it uses to determine</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; that behavior is wrought with complex interactions which may include</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; but are not limited to caching, read-aheads, garbage collection,</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; and various side effects of access control. If eCryptfs needs to go</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; mucking about with the data used by the underlying filesystem it is</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; not stacking properly. A stacked filesystem has no business whatever</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; changing the data of the underlying filesystem.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Ok, probably i have to go more in deep to explain how access control is</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">performed on eCryptfs. I'm talking for the SELinux's case, so SELinux experts</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">can correct me if i'm wrong.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">First, i want to use extended attributes to initialize an eCryptfs inode, so</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">both the upper and the lower inodes have the same security context</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">because eCryptfs calls the *xattr() methods of the underlying filesystem.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Then, the process A accesses the eCryptfs inode 'I'. On the upper layer access</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">control is performed using the credentials of the 'current' process and the</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">security context of I.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">If the process is allowed to access the upper inode, eCryptfs opens the lower</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">inode, presenting its own credentials with the type 'kernel_t'. Then, SELinux</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">checks if 'kernel_t' can access the inode with the security context of 'I'. If so,</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">eCryptfs obtains a file descriptor which, in this patch set, is labeled using the</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">same credentials it provided at open time and binds it to the upper inode.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Suppose for a moment that A is working on the eCryptfs inode 'I' and the process</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">B requests the same inode. ECryptfs uses the already opened file descriptor and</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">B will be granted to open the requested inode if:</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">- B has the 'open' permission on the upper inode 'I';</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">and can perform read/write operations if:</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">- B has the 'read' and 'write' permissions on the upper inode 'I';</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">- B is allowed to use the file descriptor opened by eCryptfs ('kernel_t').</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">- B has the 'read' and 'write' permissions on the lower inode I;</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">What i miss to say in my previous email is that even if eCryptfs is granted</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">to access inodes in the lower filesystem with full privileges, user processes</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">still need the permission to deal with the lower inode, but the check on the</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">upper inode is sufficient because the security context is the same.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Roberto Sassu</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; This solves the problem of opening the lower file in r/w mode even if only</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; the read is requested, because at the upper layer the subject is the</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; accessing process with its own credentials which needs the read permission</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; and at the lower layer the subject is the eCryptfs kernel module with</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; unlimited privileges.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; Excuse my ignorance for a moment. Is eCryptfs a user mode filesystem,</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; or in the kernel properly? The behavior makes it sound like the former</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; while the interfaces you're requesting make it seem like the latter.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; The issue i described in the cover letter is related to the label assigned</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; to the file descriptor obtained by eCryptfs (or another kernel service) when</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; opening an inode in the lower filesystem, which actually depends on the</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; first accessing process.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; This label is checked against the credentials of the 'current' process in the</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; hook security_file_permission(), which is triggered by vfs calls (read, write,</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; readdir) performed on both the upper and the lower inodes.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; In SELinux, a process needs the permission to 'use' a opened file descriptor.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; So, having a fixed label helps in defining the rule that must be added in the</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; policy for eCryptfs to ensure it works properly.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; I'm afraid to suggest this, but it looks as if you may be</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; able to solve your problems with some SELinux policy. I am</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; of course not an expert on SELinux policy, but it looks as</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; if not specifying an appropriate policy for the user space</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; component is what is in the way here.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; PS: i'm adding in CC the Apparmor's mantainer and the mailing list to have</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; their opinion about the protection offered for the eCryptfs filesystem and</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; other kernel services. The overall thread is available at the url:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; https://lkml.org/lkml/2011/4/27/201</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; Thanks</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; Roberto Sassu</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt; Tyler</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br /></p></body></html>
--Boundary-01=_ZRouNQpkziq70rZ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
