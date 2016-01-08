Subject: Re: Labeling nsfs filesystem
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
 Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <568ECC43.40500@m4x.org> <568ED656.5030106@tycho.nsa.gov>
 <568FB2FA.3010702@tresys.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <568FC404.1030307@tycho.nsa.gov>
Date: Fri, 8 Jan 2016 09:13:24 -0500
MIME-Version: 1.0
In-Reply-To: <568FB2FA.3010702@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/08/2016 08:00 AM, Christopher J. PeBenito wrote:
> On 1/7/2016 4:19 PM, Stephen Smalley wrote:
>> On 01/07/2016 03:36 PM, Nicolas Iooss wrote:
>>> Hello,
>>>
>>> Since Linux 3.19 targets of /proc/PID/ns/* symlinks have lived in a fs
>>> separated from /proc, named nsfs [1].  These targets are used to enter
>>> the namespace of another process by using setns() syscall [2].  On old
>>> kernels, they were labeled with procfs default type (for example
>>> "getfilecon /proc/self/ns/uts" returned system_u:object_r:proc_t:s0).
>>> When using a recent kernel with a policy without nsfs support, the
>>> inodes are not labeled, as reported for example in Fedora bug #1234757
>>> [3].  As I encounter this issue on my systems, I asked yesterday on the
>>> refpolicy ML how nsfs inodes should be labeled [4].
>>>
>>> After digging a little bit about the possibilities, here is a summary of
>>> the options I have considered so far.
>>>
>>> Option 1: define a new type to label nsfs inodes, nsfs_t.  This works as
>>> expected (c.f. [5] for more details).
>>>
>>> Option 2: "fs_use_task nsfs gen_context(system_u:object_r:fs_t,s0);".
>>> Even though this works well for /proc/self/ns/*, this behaves in a weird
>>> way with other processes in the initial namespaces. Here is a shell
>>> session with such a configuration (on a system running in permissive
>>> mode):
>>>
>>>     # runcon system_u:system_r:init_t sleep 1000000&
>>>     [1] 26633
>>>     # ls -lZ /proc/26633/ns/uts
>>>     lrwxrwxrwx. 1 root root system_u:system_r:init_t 0 Jan  7 19:49
>>>     /proc/26633/ns/uts -> uts:[4026531838]
>>>     # getfilecon /proc/26633/ns/uts
>>>     /proc/26633/ns/uts sysadm_u:sysadm_r:sysadm_t
>>>     # runcon user_u:user_r:user_t getfilecon /proc/26633/ns/uts
>>>     /proc/26633/ns/uts user_u:user_r:user_t
>>>
>>> In short, nsfs inodes get created with the context of the running task.
>>> This is because the inodes do not exist before getfilecon() opens them
>>> (c.f. ns_get_path() function in fs/nsfs.c [6] and
>>> inode_doinit_with_dentry() in security/selinux/hooks.c, which does
>>> "isec->sid = current_sid()" in SECURITY_FS_USE_TASK case [7]).  This
>>> issue does not appear with Docker and the network namespace used by
>>> systemd services for PrivateNetwork feature because a file descriptor to
>>> the network namespace is kept open, so the inode is created by the task
>>> "owning" the namespace and its label is stable.
>>>
>>>
>>> Option 3: do not add anything in the policy and add
>>> "security_task_to_inode(task, inode);" right after the inode
>>> initialization in ns_get_path() (line 90 of [6]), which is what /proc
>>> uses to make /proc/PID inodes have the context of their tasks.  Then
>>> "getfilecon /proc/PID/ns/uts" returns the context of task PID (and not
>>> the context that is used by getfilecon command), but as this inode is
>>> per-namespace and not per-task, there can be situations like this:
>>>
>>>     # id -Z ; getfilecon /proc/self/ns/uts
>>>     sysadm_u:sysadm_r:sysadm_t
>>>     /proc/self/ns/uts sysadm_u:sysadm_r:sysadm_t
>>>
>>>     # runcon 'user_u:user_r:user_t' bash -c 'exec 3</proc/self/ns/uts &&
>>>     sleep 100000' & P=$!
>>>     [1] 803
>>>
>>>     # ls -lZ "/proc/$P/fd/3"
>>>     lr-x------. 1 root root user_u:user_r:user_t 64 Jan  6 23:17
>>>     /proc/803/fd/3 -> uts:[4026531838]
>>>
>>>     # getfilecon "/proc/$P/fd/3" "/proc/$P/ns/uts"
>>>     /proc/803/fd/3   user_u:user_r:user_t
>>>     /proc/803/ns/uts user_u:user_r:user_t
>>>
>>>     # getfilecon /proc/self/ns/uts
>>>     /proc/self/ns/uts user_u:user_r:user_t
>>>
>>>     # fg
>>>     ^C
>>>     # getfilecon /proc/self/ns/uts
>>>     /proc/self/ns/uts sysadm_u:sysadm_r:sysadm_t
>>>
>>> So in fact each /proc/self/ns/* symlink target is labeled accordingly to
>>> the first process which opened it.  I do not know whether this behaviour
>>> fits with the "real world usage" of namespaces (e.g. with containers) or
>>> can be considered as a side effect which can be ignored.
>>>
>>>
>>> Option 4 (not tested): add a sid field to struct ns_common and make
>>> every namespace labeled from the process which creates it, maybe with a
>>> type transition mechanism. This would be quite heavy to handle.
>>>
>>>
>>> How should nsfs be handled in the kernel and in SELinux policy?
>>
>> Only option 1 makes sense to me.
>
> I don't understand the usage of nsfs which makes this confusing, but why
> doesn't option 3 make sense?  Since it's under a particular /proc/pid
> entry, doesn't it make sense to label the object as the domain's type?

The symlink is under a particular /proc/pid directory, but the target is 
per-namespace, not per-process.
