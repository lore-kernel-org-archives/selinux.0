Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8GJIY3I001967
	for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2009 15:18:35 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n8GJJwjq010826
	for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2009 19:19:58 GMT
Message-ID: <4AB139E8.50700@manicmethod.com>
Date: Wed, 16 Sep 2009 15:18:00 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Chad Sellers <csellers@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: This patch fixes the exception handling in libselinux-python
 bindings
References: <C6A74D22.A99BD%csellers@tresys.com> <4A830B34.60402@redhat.com>
In-Reply-To: <4A830B34.60402@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Daniel J Walsh wrote:
> What do you think of this one.  Removed excess swig cruft,
>
> You need to run
>
> make swigify to generate those changes.
>

Ok, looking at this now. I don't completely get how it works. I'm trying 
to reproduce what you are doing by hand but nothing comes out of gcc:

[root@localhost src]# echo '#include "../include/selinux/selinux.h"' > 
temp.c
[root@localhost src]# gcc -c temp.c -aux-info temp.aux
[root@localhost src]# ls temp.*
temp.c  temp.o


What is the purpose of the aux-info thing, and why doesn't it work on my 
F11 machine?

also, I'm not sure if the best place for selinuxswig_exception.i is 
swigify or pywrap. In the swigify case it shouldn't be in the clean 
target because if you check out the repo and do make clean; make pywrap 
you'll get an error. (I can make these fixes, I'm just trying to figure 
out how it all works first).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
