Message-ID: <41790999.3080709@redhat.com>
Date: Fri, 22 Oct 2004 09:22:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
Subject: Re: Proposed patch for libselinux
References: <41782BBA.9090101@redhat.com> <1098449318.7614.13.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1098449318.7614.13.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2004-10-21 at 17:35, Daniel J Walsh wrote:
>  
>
>>diff --exclude-from=exclude -N -u -r nsalibselinux/src/getfilecon.c libselinux-1.17.15/src/getfilecon.c
>>--- nsalibselinux/src/getfilecon.c	2004-10-20 16:31:36.000000000 -0400
>>+++ libselinux-1.17.15/src/getfilecon.c	2004-10-20 16:35:52.000000000 -0400
>>@@ -4,7 +4,7 @@
>> #include <selinux/selinux.h>
>> #include <stdlib.h>
>> #include <errno.h>
>>-#include <sys/xattr.h>
>>+#include <attr/xattr.h>
>> #include "policy.h"
>>    
>>
>
>This is wrong; glibc directly provides [gs]etxattr for all modern glibc
>versions built against modern kernel headers; you don't need to use
>libattr.  We originally used attr/xattr.h and then migrated a long time
>ago.
>
>  
>
I originally did this because the man page said to.  I also was looking 
using ENOATTR in a previous
attempt at this patch, described in the man page but only defined in 
attr/xattr, not sys/xattr.  So  I have no problem
removing the change.

>>+int getfileconperm(const char *path, int *perm)
>>+{
>>+	*perm=0;
>>+	return getxattr(path, XATTR_NAME_SELINUX_PERM, perm, sizeof(*perm));
>>+}
>>    
>>
>
>Directly storing an integer in the xattr?  Endianness issues; you need
>to convert to a particular ordering before setting and convert back when
>getting.
>
>  
>
I was looking at this as more of a TRUE/FALSE proposition.  So maybe 
changing it to
three functions

setfileconperm(path)
isfileconperm(path)
clearfileconperm(path)

How about that?

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
