Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA14656
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2001 18:47:00 -0400 (EDT)
From: gawain.lynch@felicity-consulting.com.au
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA26216
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2001 22:46:51 GMT
Received: from mel-relay-dmz-01.felicity.net.au ([203.33.108.4])
	by jazzband.ncsc.mil  with ESMTP id WAA26204
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2001 22:46:48 GMT
Received: from oneone00.felicity.net.au (IDENT:notes@oneone00.felicity.net.au [203.33.109.69])
	by mel-relay-dmz-01.felicity.net.au (8.11.0/8.11.0) with ESMTP id f3HBkuo03634
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2001 21:46:56 +1000
To: <selinux@tycho.nsa.gov>
Subject: Re: Policy configuration errors
MIME-Version: 1.0
Message-ID: <OFC332F147.0EA286CA-ONCA256A31.002D6757@felicity.net.au>
Date: Wed, 18 Apr 2001 07:39:48 +1000
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yes I read Rajan's post, but did not see a follow up and I was not sure if 
there was a known problem.

The machine in question had previously compiled everything fine and is 
running kgcc 1.1.2-40 and gcc 2.96-79, neither work.  However I am almost 
100% certain the problem results from actions undertaken here.

I have tried tracing back through the policy files but m4 is not a strong 
point for me and have also shifted fresh tar balls to a _fresh_ RH install 
and still the same result.

So if anyone has some pointers for me I am happy to listen/look, but I am 
at an end here.

Thanks kindly,

Gawain





Stephen Smalley <sds@tislabs.com>
04/16/01 11:57 PM

 
        To:     gawain.lynch@felicity-consulting.com.au
        cc:     selinux@tycho.nsa.gov
        Subject:        Re: Policy configuration errors



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
>         %{errlog}:error in the statement ending on line 1054 (token 
';'): 
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
