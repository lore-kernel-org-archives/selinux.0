Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA04429
	for <selinux@tycho.nsa.gov>; Mon, 16 Apr 2001 09:58:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA03253
	for <selinux@tycho.nsa.gov>; Mon, 16 Apr 2001 13:58:29 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id NAA03249
	for <selinux@tycho.nsa.gov>; Mon, 16 Apr 2001 13:58:29 GMT
Date: Mon, 16 Apr 2001 09:57:31 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: gawain.lynch@felicity-consulting.com.au
cc: selinux@tycho.nsa.gov
Subject: Re: Policy configuration errors
In-Reply-To: <OF482CDDC7.7FD39A91-ONCA256A30.00238056@felicity.net.au>
Message-ID: <Pine.SOL.3.95.1010416094433.10460A-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


The same error was reported by Rajan Ravindran in a message to
the mailing list on March 29th.  He sent me a copy of his policy
configuration, and I was unable to reproduce the error on our
systems (running RedHat 6.1 and 6.2).  I suggested that he
make sure that he had installed the gcc and glibc updates
from RedHat for RedHat 7, and then do a clean rebuild of the
checkpolicy program.  I don't know if that solved his problem
or not.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



On Mon, 16 Apr 2001 gawain.lynch@felicity-consulting.com.au wrote:

> I am building an SRPM which is now fully functional, bar the following 
> error received during ``make initpolicy'' 
> 
>         error in the statement ending on line 1054 (token ';'): unknown 
> class filesystem used in rule
>  
>         ../kernel/security/checkpolicy:  error(s) encountered while 
> parsing configuration
>         make: *** [initpolicy] Error 1
> 
>         ...
> 
>         $ rgrep filesystem policy/
> 
>         %{errlog}:error in the statement ending on line 1054 (token ';'): 
> unknown class filesystem used in rule
>         access_vectors:class filesystem
>         domains/every.te:allow domain fs_type:filesystem getattr;
>         init.te:allow initial_boot_t fs_type:filesystem *;
>         macros.te:allow $1_devpts_t devpts_t:filesystem associate;
>         mls:class filesystem
>         security_classes:class filesystem
>         types/file.te:allow file_type fs_t:filesystem associate;
>         types/nfs.te:allow nfs_t nfs_t:filesystem associate;
>         types/nfs.te:allow nfs_clipper_t nfs_clipper_t:filesystem 
> associate;
> 
> Can someone please point me in some sort of direction as I am very close 
> to finishing and this is just plain annoying.
> 
> Thanks,
> 
> Gawain


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
