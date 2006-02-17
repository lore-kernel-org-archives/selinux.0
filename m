Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by localhost.localdomain (8.13.1/8.13.1) with ESMTP id k1H5fSP9007842
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 00:41:28 -0500
Received: from authusersmtp.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1H5e31d015895
	for <selinux@tycho.nsa.gov>; Fri, 17 Feb 2006 05:40:03 GMT
Message-ID: <43F561F3.4080200@cornell.edu>
Date: Fri, 17 Feb 2006 00:41:07 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Chris PeBenito <pebenito@gentoo.org>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: semanage non MLS breakage
References: <1140150258.13377.15.camel@gorn.pebenito.net>
In-Reply-To: <1140150258.13377.15.camel@gorn.pebenito.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.ncsc.mil
List-Id: selinux@tycho.nsa.gov


> # semanage login -l
>
> Login Name                SELinux User              MLS/MCS Range
>
> root                      root                      __default__:user_u
>
> # semanage login -a -s staff_u pebenito
> Segmentation fault
>
>   
PeBenito, can you provide a trace with line numbers (i.e. 
libsemanage-debuginfo, and libsepol-debuginfo installed)?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
