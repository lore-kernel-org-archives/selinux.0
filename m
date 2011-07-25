Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6PEVkgY028117
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2011 10:31:46 -0400
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p6PEVjte004705
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2011 14:31:45 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.5/8.14.5) with ESMTP id p6PEVhIk007314
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2011 10:31:43 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.5/8.14.5/Submit) id p6PEVhnR007313
	for selinux@tycho.nsa.gov; Mon, 25 Jul 2011 10:31:43 -0400
Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6PD8Xpl022189
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2011 09:08:33 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p6PD8V3a027725
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2011 13:08:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: apol and active modules
Date: Mon, 25 Jul 2011 23:08:28 +1000
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <201107242126.19144.russell@coker.com.au> <201107252248.55086.russell@coker.com.au> <4E2D67D7.3070402@tresys.com>
In-Reply-To: <4E2D67D7.3070402@tresys.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201107252308.28529.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 25 Jul 2011, "Christopher J. PeBenito" <cpebenito@tresys.com> wrote:
> > The files are not just a copy.
> 
> It sounds like there might be some corruption.  I did the same diff on 
> my system and came up with no changes.

On Debian/Squeeze and Debian/Unstable I can reliably rebuild the policy (via 
the selinux-policy-upgrade script that runs semodule to reinsert all modules 
from the original policy tree) and get the same result.  Every time it results 
in different files in the active tree and apol not liking them.

It must be an issue of which versions of the libraries etc are being used.  
The systems work quite well like this, I just have to use the original .pp 
files for apol.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
