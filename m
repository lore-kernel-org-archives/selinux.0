Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6ODlS6M029369
	for <selinux@tycho.nsa.gov>; Mon, 24 Jul 2006 09:47:28 -0400
Subject: Re: Existence of "helper" functions (specifcally MLS)
From: David Quigley <dpquigl@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <44BFECE8.80501@us.ibm.com>
References: <44BFECE8.80501@us.ibm.com>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 09:45:47 -0400
Message-Id: <1153748747.1641.18.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-07-20 at 15:51 -0500, Michael C Thompson wrote:
> Hey all,
> 
> I haven't looked extensively, but I was wondering if there exist any 
> funcitons (probably in libselinux?) which would do comparisons on MLS 
> labels and would return back whether or not one dominates another, or if 
> the categories are equal (or a subset), etc.
> 
> Thanks much,
> Mike
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

Hello,
	Sorry for the late reply but I was at OLS all of last week. I currently
have this implemented but it is not upstreamed yet. It required changes
in both libselinux and in the kernel. I can generate a set of patches
for you if you need it before I can get it upstream however they are
currently against 2.6.18-rc1.

-- 
David Quigley <dpquigl@tycho.nsa.gov>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
