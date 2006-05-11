Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4BJ6lIw018566
	for <selinux@tycho.nsa.gov>; Thu, 11 May 2006 15:06:47 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4BJ6kk1015995
	for <selinux@tycho.nsa.gov>; Thu, 11 May 2006 19:06:46 GMT
Message-ID: <44638B97.8080009@redhat.com>
Date: Thu, 11 May 2006 15:08:07 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: selinux@tycho.nsa.gov
Subject: Re: textrel_shlib_t
References: <200605111730.k4BHUc13006509@turing-police.cc.vt.edu>
In-Reply-To: <200605111730.k4BHUc13006509@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Valdis.Kletnieks@vt.edu wrote:
> (And yes, I *know* I can just chcon the sucker into submission...)
>
> I have a 3rd-party shared library, for which I have source. It's
> throwing a execmod AVC that can be worked around with textrel_shlib_t.
>
> What in the source code causes this, and what's a good fix?  I'd
> like to create a patch and push it upstream so it will Just Work for
> others....
>
>   
Ulrich explains it.

http://people.redhat.com/~drepper/selinux-mem.html

http://people.redhat.com/~drepper/dsohowto.pdf

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
