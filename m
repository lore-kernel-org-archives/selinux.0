Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0GERsoF015841
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2008 09:27:54 -0500
Received: from g5t0006.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0GERsx1025893
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2008 14:27:54 GMT
From: Paul Moore <paul.moore@hp.com>
To: w.chimiak@ieee.org
Subject: Re: MCS/MLS
Date: Wed, 16 Jan 2008 09:27:45 -0500
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200801160852.25646.w.chimiak@ieee.org>
In-Reply-To: <200801160852.25646.w.chimiak@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200801160927.45811.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 16 January 2008 8:52:25 am Bill Chimiak wrote:
> I was fooling about with MCS/MLS with FC6, the move to FC8 created
> kernel messages on the screen when doing any network activity as a user.

Can you post the messages here?

> I traced it back to some MCS statements I had made.

So this was not the default configuration?  What changes did you make?

> I brute-forced the distro by doing a yum erase selinux (policies, etc)
> and reinstalled them and then all worked well.

Just to clarify, networking using the default SELinux configuration is working 
for you?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
