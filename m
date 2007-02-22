Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1MDjHoa026068
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 08:45:17 -0500
Received: from web51504.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1MDkZ8g027588
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 13:46:35 GMT
Date: Thu, 22 Feb 2007 05:46:35 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: libselinux patch
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1172147649.14363.312.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <305125.10227.qm@web51504.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>That was intentional; likely should add a comment.

OK, explanation makes sense. I'll add a comment to the patch.

>Patch looks basically sane;

Something else I was thinking about. When the library starts up, it checks for
the mounts then it checks for enabled. Would there be any situation where an
selinuxfs would be mounted and selinux is considered disabled? If not, we can
short circuit the redundant check for /selinux and assume that if selinux_mnt !=
NULL then selinux is enabled. Does this make sense?

>- Let's move the existing SELINUXMNT definition used by
>src/load_policy.c for mounting selinuxfs for initial policy load to a
>private header (e.g. src/policy.h) and use it in this code rather than
>repeating the "/selinux" string each time.

Sure.

>- SELINUX_MAGIC doesn't need to be exposed outside of the library, so
>I'd put it into src/policy.h too instead of a public header.

I have a feeling that people want this. Almost all filesystems have the magic
exposed or well known. SELINUX_MAGIC isn't even listed in statfs man page while
most other filesystems are. If you search /usr/include for SELINUX_MAGIC, you'll
find it defined in:

/usr/include/sepol/policydb/flask_types.h

So, why not have a definition in libselinux and let other subsystems use it?

>- Why u_int32_t instead of just long (per the statfs man page)?

SELINUX_MAGIC is 0xf97cff8c and the upper bit is 1, so it gets sign extended in
64 bit kernels. Then the direct comparison fails. No other MAGIC has a 1 in the
upper bit so selinux is unique in that way. Try this little program and you'll
see:


#include <stdio.h>
#include <sys/vfs.h>
#include <sys/types.h>
#include <dirent.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>

int main(void)
{
        DIR *d;
        struct dirent *e;

        d = opendir("/");
        while ((e = readdir(d))) {
                char path[PATH_MAX];
                struct stat buf;

                if (e->d_name[0] == '.')
                        continue;

                snprintf(path, sizeof(path), "/%s", e->d_name);
                stat(path, &buf);
                if (S_ISDIR(buf.st_mode)) {
                        struct statfs sfbuf;
                        statfs(path, &sfbuf);
                        printf("%s: 0x%lx\n", path, sfbuf.f_type);
                }
        }
        closedir(d);
        return 0;
}


>And if we need to use a fixed size type, we should use C99 style i.e. uint32_t
>going forward - a recently merged patch converted all occurrences in libselinux
>over to C99 style.

Sure. I discovered this after making the patch and was looking for a built-in
type so I wouldn't have to re-diff the patch. Long term we should probably fix
the sign-extension if possible.

-Steve


 
____________________________________________________________________________________
Do you Yahoo!?
Everyone is raving about the all-new Yahoo! Mail beta.
http://new.mail.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
