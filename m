Message-ID: <4179179B.30204@redhat.com>
Date: Fri, 22 Oct 2004 10:22:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
Subject: Re: Proposed patch for libselinux
References: <41782BBA.9090101@redhat.com>	 <1098449318.7614.13.camel@moss-spartans.epoch.ncsc.mil>	 <41790999.3080709@redhat.com> <1098452654.7614.63.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1098452654.7614.63.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Fri, 2004-10-22 at 09:22, Daniel J Walsh wrote:
>  
>
>>I originally did this because the man page said to.  I also was looking 
>>using ENOATTR in a previous
>>attempt at this patch, described in the man page but only defined in 
>>attr/xattr, not sys/xattr.  So  I have no problem
>>removing the change.
>>    
>>
>
>Ok, the man page is out of date.  ENOATTR doesn't exist anyway as a
>separate error code; the kernel returns ENODATA.
>
>  
>
>>I was looking at this as more of a TRUE/FALSE proposition.  So maybe 
>>changing it to
>>three functions
>>
>>setfileconperm(path)
>>isfileconperm(path)
>>clearfileconperm(path)
>>    
>>
>
>Possibly, with "fileconperm" replaced by "customcon" or similar, but
>don't you still want the stored "true" value to be consistent regardless
>of local cpu endianness?  You could setxattr on a single byte I suppose
>to avoid the issue entirely.
>
>  
>
Fine, single byte seems like a good idea.

so
setcustomcon(path)
lsetcustomcon(path)
Return < 0 on error, 0 on success
getcustomcon(path)
lgetcustomcom(path)
returns <0 on error, 0 means not customcon, >0 means customcon
clearcustompath(path)
lclearcustompath(path)
Return <0 on error, 0 on success



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
