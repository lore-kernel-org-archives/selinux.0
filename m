Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB5Ia6Rb006797
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 13:36:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB5Ia5RV007971
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 18:36:05 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id hB5Ia4ta007967 for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 18:36:04 GMT
Date: Fri, 5 Dec 2003 18:36:01 +0000
From: Dale Amon <amon@vnl.com>
To: Stephen <mridion@hotmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Problems loading policy
Message-ID: <20031205183601.GB32487@vnl.com>
References: <BAY1-DAV25idcOHuICu0000353b@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BAY1-DAV25idcOHuICu0000353b@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Dec 06, 2003 at 01:57:47AM +1100, Stephen wrote:
> I have compiled my kernel with ROMFS, capabilities and SELinux. Here is my
> kernel dmesg

You haven't actually given the info showing whether
the initrd loaded or not.

One item to be wary of though. Make sure cramfs is
deselected in the kernel build if you are using romfs.
For some reason initrd will try cramfs first and not
even look at romfs in that case.

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
