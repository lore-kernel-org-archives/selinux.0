Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9MBKGpp013956
	for <selinux@tycho.nsa.gov>; Tue, 22 Oct 2013 07:20:17 -0400
Date: Tue, 22 Oct 2013 22:20:38 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] SELinux updates for 3.12
In-Reply-To: <1587641.zEKSTAkKTO@sifl>
Message-ID: <alpine.LRH.2.02.1310222220050.5947@tundra.namei.org>
References: <2307607.HXDCGv9Ccf@sifl> <alpine.LRH.2.02.1310210947360.24529@tundra.namei.org> <1587641.zEKSTAkKTO@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 21 Oct 2013, Paul Moore wrote:

> Why does a branch need to be specified?  The changes live in master and my 
> understanding was that if a branch was not explicitly listed then master 
> should be used.
> 

Ok, I'll do that.  I'm not going to assume it.

> > git-pull fails in any case.
> 
> Can you be more explicit?  It works for me ...

$ git pull git://git.infradead.org/users/pcmoore/selinux
You asked to pull from the remote 
'git://git.infradead.org/users/pcmoore/selinux', but did not specify
a branch. Because this is not the default configured remote
for your current branch, you must specify a branch on the command line.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
