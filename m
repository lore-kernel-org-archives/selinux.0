Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TH4qrT020559
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 13:04:52 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6TH4LbB003295
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 17:04:21 GMT
Date: Thu, 29 Jul 2004 13:04:45 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, Joshua Brindle <method@gentoo.org>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: temporary hack to use udev in selinux
In-Reply-To: <20040729143549.GI8858@lkcl.net>
Message-ID: <Xine.LNX.4.44.0407291303140.16390-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 29 Jul 2004, Luke Kenneth Casson Leighton wrote:

>  p.s. has anyone considered doing a macro for these "pseudo" xattrs?
>       or merging them into one bit of code?

Yes, I was looking at making a library but it didn't work out.  Macros 
may do the job, but I'm not sure how acceptable these would be upstream.

>       there are now THREE identical bits of code for the pseudo
> 	  xattrs, except for the names of the functions.

Some of this code is also identical in ext2/ext3.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
