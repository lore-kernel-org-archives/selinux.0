Subject: Re: Behavior of mmap()ed files on setcon()?
To: Nick Kralevich <nnk@google.com>, SELinux <Selinux@tycho.nsa.gov>
References: <CAFJ0LnHx-BdUTYMDQCExksrZL5f2nw-=mL7kQh345OCyM1s3ww@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56684178.4040409@tycho.nsa.gov>
Date: Wed, 9 Dec 2015 09:58:00 -0500
MIME-Version: 1.0
In-Reply-To: <CAFJ0LnHx-BdUTYMDQCExksrZL5f2nw-=mL7kQh345OCyM1s3ww@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/08/2015 07:44 PM, Nick Kralevich wrote:
> When a process performs a setcon() call, SELinux revalidates any open
> file descriptors. Any file descriptors not allowed by the new context
> are invalidated at setcon time.

Not quite right.  SELinux does file descriptor revalidation on:
a) use (e.g. read(), write(), etc),
b) context-changing execve(),
c) transfer (via local socket or binder).

So for setcon(), there is no revalidation or invalidation at setcon 
time, but subsequent read()/write() may fail if the descriptor is no 
longer authorized for the new context.

> Does the invalidation also occur for files which are mapped into memory,
> but for which the file descriptor is no longer open? For example, if I
> make the following sequence of calls
>
>    int fd = open("/some/file", O_RDWR);
>    char *memory = (char *) mmap(NULL, length, PROT_READ |
> PROT_WRITE, MAP_PRIVATE, fd, 0);
>    close(fd);
>    setcon("u:r:new_domain:s0");
>    printf("%s", memory);
>
> and new_domain isn't permitted to access /some/file, what will be the
> behavior of the program above?
>
> I was told (but haven't verified) that access to the region of memory
> will continued to be allowed even though the policy of new_domain
> doesn't permit access.
>
> Expected? Should I be digging more?

Yes, that's expected.  First, SELinux does not in general implement 
revocation of access to memory-mapped files; that was always a desired 
TODO but problematic given the complete lack of support in Linux even 
for revoke(2) semantics (despite repeated efforts on lkml).  Second, in 
the case of setcon(), the caller is necessarily trusted to maintain 
separation between the contexts (as noted in the man page); if you don't 
trust it to properly sanitize its state prior to setcon(), you ought to 
be using setexecon() + execve() instead.
