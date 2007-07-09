Subject: Re: getfilecon return code
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "John D. Ramsdell" <ramsdell@mitre.org>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <ogtmyy5lacd.fsf@oolong.mitre.org>
References: <ogtmyy5lacd.fsf@oolong.mitre.org>
Content-Type: text/plain
Date: Mon, 09 Jul 2007 14:30:40 -0400
Message-Id: <1184005840.12430.139.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-07-09 at 14:07 -0400, John D. Ramsdell wrote:
> I hadn't carefully read the manual page for getfilecon until now, but
> I notice it states that a positive number is returned indicating the
> number of bytes malloc'd for the context, and -1 is returned
> indicating failure and that errno is set.  I would have guessed from
> the description that zero is never an allowed return value.  In fact,
> I wrote code that freecon'd a context whenever the return value was
> not -1.

freecon(NULL) is perfectly legal and harmless, like free(NULL), so that
part is ok.

It is possible to set extended attributes with no values, e.g. 
	$ setfattr -n user.foo /path/to/foo
	$ getfattr -n user.foo /path/to/foo
and directly calling getxattr() on that file will return 0.

So technically this is a possible case, even if it is unusual and was
introduced in this case by the proc sysctl rewrite in the kernel leaving
us with "private" /proc/sys inodes.

I'd be inclined to change security_inode_getsecurity() in the kernel to
return -EOPNOTSUPP in the IS_PRIVATE(inode) case.  But that won't help
with current kernels, of course.

libselinux could remap a zero return from getxattr to a -1 return with
errno EOPNOTSUPP in the meantime if we want to present this behavior to
applications now.

> In the example below, when checking out a file in /proc/sys, zero is
> returned and the result is a NULL context, something that need not be
> free'd.  To me, failure to allocate a context feels like a failure
> condition.
> 
> Perhaps the best strategy is to assume success when the context produced
> in non-null, and not worry about the return code.
> 
>   security_context_t con = NULL;
>   int rc = getfilecon(MP, &con);
>   if (!con) /* Handle failure here */        
>   else /* do something and then freecon(con) */
> 
> Is the following expression always true?
> 
>   (con != NULL) == (rc > 0)

I don't think ignoring the return value is the right approach.  With the
libselinux patch I posted, there is no bug here; freecon(NULL) is
harmless.  But I can see an argument for making libselinux return -1
with errno EOPNOTSUPP in this case, and ultimately making the kernel do
that too.

> John
> 
> [ramsdell@goo selinux]$ make
> cc     mygetfilecon.c  /home/ramsdell/src/libselinux-2.0.8/src/libselinux.a -o mygetfilecon
> [ramsdell@goo selinux]$ ./mygetfilecon
> getfilecon("/proc/sys/kernel/pid_max", &con) = 0
> con = NULL
> [ramsdell@goo selinux]$ cat mygetfilecon.c
> #include <stdio.h>
> #include <selinux/selinux.h>
> 
> #define MP "/proc/sys/kernel/pid_max"
> 
> int
> main(int argc, char **argv)
> {
>   security_context_t con;
>   int rc = getfilecon(MP, &con);
>   printf("getfilecon(\"%s\", &con) = %d\n", MP, rc);
>   if (rc < 0)
>     perror("getfilecon");
>   else if (con)
>     printf("con = \"%s\"\n", con);
>   else
>     printf("con = NULL\n", con);
>   return 0;
> }
> [ramsdell@goo selinux]$ 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
