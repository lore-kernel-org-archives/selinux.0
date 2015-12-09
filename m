MIME-Version: 1.0
In-Reply-To: <CAFJ0LnHx-BdUTYMDQCExksrZL5f2nw-=mL7kQh345OCyM1s3ww@mail.gmail.com>
References: <CAFJ0LnHx-BdUTYMDQCExksrZL5f2nw-=mL7kQh345OCyM1s3ww@mail.gmail.com>
Date: Tue, 8 Dec 2015 16:56:39 -0800
Message-ID: <CAFJ0LnFD8_Bx1xew-Jnip6+HNaAKgWM9GYfhQtoFcd58P8HRhA@mail.gmail.com>
Subject: Re: Behavior of mmap()ed files on setcon()?
From: Nick Kralevich <nnk@google.com>
To: SELinux <Selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Dec 8, 2015 at 4:44 PM, Nick Kralevich <nnk@google.com> wrote:
> When a process performs a setcon() call, SELinux revalidates any open file
> descriptors. Any file descriptors not allowed by the new context are
> invalidated at setcon time.
>
> Does the invalidation also occur for files which are mapped into memory, but
> for which the file descriptor is no longer open? For example, if I make the
> following sequence of calls
>
>   int fd = open("/some/file", O_RDWR);
>   char *memory = (char *) mmap(NULL, length, PROT_READ | PROT_WRITE,
> MAP_PRIVATE, fd, 0);

This should be MAP_SHARED, not MAP_PRIVATE. Not sure if it's relevant...

>   close(fd);
>   setcon("u:r:new_domain:s0");
>   printf("%s", memory);
>
> and new_domain isn't permitted to access /some/file, what will be the
> behavior of the program above?
>
> I was told (but haven't verified) that access to the region of memory will
> continued to be allowed even though the policy of new_domain doesn't permit
> access.
>
> Expected? Should I be digging more?
>
> --
> Nick Kralevich | Android Security | nnk@google.com | 650.214.4037



-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
