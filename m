Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i83DZQrT007320
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 09:35:26 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i83DZPUQ019342
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 13:35:25 GMT
Subject: Re: Proposed Hardware File Context file.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Colin Walters <walters@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20040903131751.GC30562@lkcl.net>
References: <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil>
	 <413741A3.3070305@redhat.com>
	 <1094153919.17265.375.camel@moss-spartans.epoch.ncsc.mil>
	 <41377927.3080703@redhat.com>
	 <1094155198.17265.389.camel@moss-spartans.epoch.ncsc.mil>
	 <41377DD5.8010500@redhat.com>
	 <1094155749.17265.392.camel@moss-spartans.epoch.ncsc.mil>
	 <41377F4B.3010608@redhat.com>
	 <1094167821.24091.25.camel@nexus.verbum.private>
	 <1094210883.19206.2.camel@moss-spartans.epoch.ncsc.mil>
	 <20040903131751.GC30562@lkcl.net>
Content-Type: text/plain
Message-Id: <1094218416.19206.116.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 03 Sep 2004 09:33:36 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-09-03 at 09:17, Luke Kenneth Casson Leighton wrote:
>  ironically, it's scripted - with regexps matching nodes :)
> 
>  and then the owner, group and permissions are specified.
> 
>  there's also a system for dealing with classes of devices.
> 
>  so ide and scsi and also cd symbolic links are dealt with separately,
>  with scripts.

It seems desirable to keep the SELinux context mapping approach for udev
consistent with the base udev permissions approach.  Using a separate
config file is reasonable (and allows us to keep it as part of the
policy package), but the syntax should mirror the existing udev
permission syntax as much as possible, I think, and we may even want
udev itself to directly interpret it, just as dbusd is handling its
service->context mapping (iirc).  How does that sound?  Not sure how to
integrate SELinux labeling with the scripts.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
