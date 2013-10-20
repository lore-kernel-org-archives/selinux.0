Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9KMnsKD021942
	for <selinux@tycho.nsa.gov>; Sun, 20 Oct 2013 18:49:54 -0400
Date: Mon, 21 Oct 2013 09:49:54 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] SELinux updates for 3.12
In-Reply-To: <2307607.HXDCGv9Ccf@sifl>
Message-ID: <alpine.LRH.2.02.1310210947360.24529@tundra.namei.org>
References: <2307607.HXDCGv9Ccf@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 17 Oct 2013, Paul Moore wrote:

> Hi James,
> 
> Here are a collection of SELinux updates that should be included in 3.12.  
> This request contains mostly various cleanup patches with a few bugfixes and 
> performance improvements thrown in for good measure.  The bulk of these 
> patches were inherited from Eric's old tree, hence the merge/pull in the log.
> 
> Lastly, all of these patches have been in linux-next for some time now, and 
> they all pass the SELinux testsuite with flying colors.
> 
> Enjoy,
> -Paul
> 
> ---
> The following changes since commit 6e4664525b1db28f8c4e1130957f70a94c19213e:
> 
>   Linux 3.11 (2013-09-02 13:46:10 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/pcmoore/selinux
> 

Why is no branch specified?

git-pull fails in any case.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
