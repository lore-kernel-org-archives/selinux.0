Message-ID: <553E3942.5020800@tycho.nsa.gov>
Date: Mon, 27 Apr 2015 09:27:30 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Florian Weimer <fweimer@redhat.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Impersonating a process for file creation purposes
References: <552F80C8.9060809@redhat.com> <552FA882.7030604@tycho.nsa.gov>
 <553DFC22.3050006@redhat.com>
In-Reply-To: <553DFC22.3050006@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/27/2015 05:06 AM, Florian Weimer wrote:
> On 04/16/2015 02:18 PM, Stephen Smalley wrote:
> 
>> It could also compute the context in which the file would be created by
>> the zombie by calling security_compute_create() with the context of the
>> zombie process, the context of the directory into which it is writing
>> the core dump file, and string_to_security_class("file") as its
>> arguments, and then pass the resulting context returned by that call to
>> setfscreatecon() prior to creating the core dump file and then call
>> setfscreatecon(NULL) afterward; this will create the core dump file in
>> that context.  That seems more suited to your scenario.
> 
> We tried this, and strace shows a lot of activity behind the scenes:
> 
> 3449  open("/sys/fs/selinux/mls", O_RDONLY) = 4
> 3449  read(4, "1", 19)                  = 1
> 3449  close(4)                          = 0
> 3449  futex(0x7fefa9b34820, FUTEX_WAKE_PRIVATE, 2147483647) = 0
> 3449  socket(PF_LOCAL, SOCK_STREAM|SOCK_CLOEXEC, 0) = 4
> 3449  connect(4, {sa_family=AF_LOCAL,
> sun_path="/var/run/setrans/.setrans-unix"}, 110) = -1 ENOENT (No such
> file or directory)
> 3449  close(4)                          = 0
> 3449  fgetxattr(3, "security.selinux",
> "unconfined_u:object_r:user_home_dir_t:s0", 255) = 41
> 3449  socket(PF_LOCAL, SOCK_STREAM|SOCK_CLOEXEC, 0) = 4
> 3449  connect(4, {sa_family=AF_LOCAL,
> sun_path="/var/run/setrans/.setrans-unix"}, 110) = -1 ENOENT (No such
> file or directory)
> 3449  close(4)                          = 0
> 3449  stat("/sys/fs/selinux/class", {st_mode=S_IFDIR|0555, st_size=0,
> ...}) = 0
> 3449  futex(0x7fefa9b3375c, FUTEX_WAKE_PRIVATE, 2147483647) = 0
> 3449  open("/sys/fs/selinux/class/file/index", O_RDONLY) = 4
> 3449  read(4, "6", 19)                  = 1
> 3449  close(4)                          = 0
> 3449  openat(AT_FDCWD, "/sys/fs/selinux/class/file/perms",
> O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 4
> 3449  getdents(4, /* 24 entries */, 32768) = 728
> 3449  open("/sys/fs/selinux/class/file/perms/.", O_RDONLY|O_CLOEXEC) = 5
> 3449  fstat(5, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
> 3449  close(5)                          = 0
> 3449  open("/sys/fs/selinux/class/file/perms/..", O_RDONLY|O_CLOEXEC) = 5
> 3449  fstat(5, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
> 3449  close(5)                          = 0
> 3449  open("/sys/fs/selinux/class/file/perms/audit_access",
> O_RDONLY|O_CLOEXEC) = 5
> 3449  fstat(5, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> 3449  read(5, "22", 19)                 = 2
> 3449  close(5)                          = 0
> 3449  open("/sys/fs/selinux/class/file/perms/open", O_RDONLY|O_CLOEXEC) = 5
> 3449  fstat(5, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> 3449  read(5, "21", 19)                 = 2
> 3449  close(5)                          = 0
> 
> And so on.
> 
> We use this code sequence:
> 
>     if (getpidcon(pid, &srccon) < 0)
>     {
>         perror_msg("getpidcon(%d)", pid);
>         return -1;
>     }
> 
>     if (fgetfilecon(dirfd(proc_cwd), &dstcon) < 0)
>     {
>         perror_msg("getfilecon(%s)", user_pwd);
>         return -1;
>     }
> 
>     if (security_compute_create(srccon, dstcon,
> string_to_security_class("file"), &newcon) < 0)
>     {
>         perror_msg("security_compute_create()");
>         return -1;
>     }
> 
>     if (setfscreatecon(newcon) < 0)
>     {
>         perror_msg("setfscreatecon(newcon)");
>         return -1;
>     }
> 
> This happens after switching to the other user ID (not root), and I
> think we should run the preparatory steps (everything before the call to
> setfscreatecon) as root.
> 
> Is there are supported way to get something leaner?  Is it really
> necessary to get setrans involved?  Can't we just copy the kernel
> context without translating it back and forth?

You can use the _raw interfaces to avoid the context translation.
