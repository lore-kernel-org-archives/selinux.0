Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3RFr3RC004718
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 11:53:03 -0400
Received: from smtp105.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p3RFr0AP015246
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 15:53:00 GMT
Message-ID: <4DB83BDB.8080301@schaufler-ca.com>
Date: Wed, 27 Apr 2011 08:52:59 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Roberto Sassu <roberto.sassu@polito.it>
CC: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com, jmorris@namei.org,
        zohar@linux.vnet.ibm.com, safford@watson.ibm.com,
        tyhicks@linux.vnet.ibm.com, kirkland@canonical.com,
        ecryptfs-devel@lists.launchpad.net, eparis@redhat.com,
        sds@tycho.nsa.gov, selinux@tycho.nsa.gov, viro@zeniv.linux.org.uk
Subject: Re: [RFC][PATCH 0/7] File descriptor labeling
References: <1303907657-18366-1-git-send-email-roberto.sassu@polito.it>
In-Reply-To: <1303907657-18366-1-git-send-email-roberto.sassu@polito.it>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/27/2011 5:34 AM, Roberto Sassu wrote:
> File descriptor labeling issue
>
> Actually SELinux and SMACK assign to file descriptors the same label of the
> opening process and use it in LSM hooks security_file_permission(),
> security_file_fcntl() and others to verify if the 'current' process has the
> rights to perform the requested operation.
>
> Using the credentials of the 'current' process may be not appropriate in
> case a file descriptor is opened by a kernel service (i.e. a filesystem)
> and made shared among user processes. For instance, in a system with
> SELinux and eCryptfs, if the process A opens an encrypted file, eCryptfs
> obtains a file descriptor to access the correspondent inode in the lower
> filesystem, labeled with the A's label.
>
> If the process B accesses the same encrypted file, it needs the 'use'
> permission on the A's label other than permissions for the lower inode.
> However, if B is the first accessing process, A needs the 'use' permission
> on the B's label.
>
> The solution proposed is to modify those kernel services that deal with
> file descriptors to provide their set of credentials to dentry_open(), so
> that obtained objects are labeled with a unique label. In this way, in the
> above example, if eCryptfs provides its credentials with the label C to
> dentry_open(), all user processes need the 'use' permission only on C.
>
>
>
> File descriptor labeling and IMA
>
> The above proposal suggests to use the file descriptor label as a new
> criteria in the IMA policy to determine if a file must be measured. It will
> be possible to measure all files opened by a kernel service by simply
> writing a rule where the file descriptor label given as a value matches the
> one provided by the same service together with other credentials to the
> function dentry_open().
>
> In the above example, if eCryptfs provides its credentials with the label C
> to dentry_open(), it is possible to measure all inodes opened in the lower
> filesystem by specifying a rule like:
>
> fowner_type=C
>
>
> The benefits of this new criteria will be greater with the integration of
> EVM and the IMA appraisal feature in the kernel. ECryptfs can be used in
> conjunction with these components to verify the integrity of the content
> and extended attributes of encrypted files.
>
> Roberto Sassu
>
>
> Roberto Sassu (7):
>   fs: initialize file->f_cred with credentials provided
>   selinux: label new file descriptors using file->f_cred
>   smack: assign the label set in file->f_cred to new file descriptors
>   smack: fix label check in smack_kernel_act_as()
>   smack: import the security label in smack_secctx_to_secid()
>   security: new LSM hook security_file_getsecid()
>   ima: added new LSM conditions in the policy
>
>  Documentation/ABI/testing/ima_policy |    7 ++++-
>  fs/file_table.c                      |    5 +--
>  fs/internal.h                        |    2 +-
>  fs/namei.c                           |    2 +-
>  fs/open.c                            |    2 +-
>  include/linux/security.h             |   12 +++++++++
>  security/capability.c                |    6 ++++
>  security/integrity/ima/ima.h         |    4 +-
>  security/integrity/ima/ima_api.c     |    4 +-
>  security/integrity/ima/ima_main.c    |    4 +-
>  security/integrity/ima/ima_policy.c  |   45 +++++++++++++++++++++++++++++----
>  security/security.c                  |    6 ++++
>  security/selinux/hooks.c             |    9 ++++++-
>  security/smack/smack_lsm.c           |   23 +++++++++++++++--
>  14 files changed, 108 insertions(+), 23 deletions(-)

I have not given this patch set a complete review, but at first
glance I do not like it. You seem to be making a lot of assumptions
about the interactions between services and LSMs that I don't
know are valid. It is possible that I have not dug in deeply
enough to understand where this is headed. I will have a more
complete review in a bit.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
