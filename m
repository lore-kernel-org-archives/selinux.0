Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i69GMTrT020396
	for <selinux@tycho.nsa.gov>; Fri, 9 Jul 2004 12:22:29 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i69GMSNR011277
	for <selinux@tycho.nsa.gov>; Fri, 9 Jul 2004 16:22:28 GMT
Subject: Re: An SELinux policy for Red Hat 9
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bradley Chapman <kakadu@gmail.com>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <e294b46e0407090752b199eeb@mail.gmail.com>
References: <e294b46e040708131736c57b6@mail.gmail.com>
	 <200407092111.55045.russell@coker.com.au>
	 <e294b46e0407090443663d55c4@mail.gmail.com>
	 <1089375253.11726.34.camel@moss-spartans.epoch.ncsc.mil>
	 <e294b46e0407090752b199eeb@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1089390138.11726.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 09 Jul 2004 12:22:18 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-07-09 at 10:52, Bradley Chapman wrote:
> Well, in light of your recommendations, I will certainly consider such
> a move now.
> If I do decide to move to FC2, how difficult will it then become to
> adapt the SELinux policy
> to my needs?

No more difficult than usual; you just install the policy-sources RPM
and then customize and rebuild as desired.  You also likely want setools
and setools-gui.  However, in general, you may want to do some selective
updating of SELinux-related packages from the Fedora development tree
after installing FC2 in order to pick up the latest policy, which has
been reorganized and partitioned to support multiple policies.  This
also requires pulling in the SysVinit, libselinux, and policycoreutils
from the development tree.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
