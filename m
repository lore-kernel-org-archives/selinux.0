Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7KMvQUF000944
	for <selinux@tycho.nsa.gov>; Wed, 20 Aug 2008 18:57:26 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m7KMuoCU012759
	for <selinux@tycho.nsa.gov>; Wed, 20 Aug 2008 22:56:51 GMT
Message-ID: <48ACA140.6000804@manicmethod.com>
Date: Wed, 20 Aug 2008 18:57:04 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [ANN] SELinux userland repository, wiki and bug tracking on oss.tresys.com
References: <48A5C1F2.3080002@manicmethod.com>
In-Reply-To: <48A5C1F2.3080002@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> We have finished migrating the SELinux userland repository and bug tracking, it is available at http://oss.tresys.com/projects/selinux. 
> 
> The source code repository for read access is available via git:
> 
> git clone http://oss.tresys.com/git/selinux.git
> 
> or you can browse the source via:
> 
> http://oss.tresys.com/projects/selinux/browser
> 
> All users following trunk should switch over to git, subversion access on sourceforge will be turned off in the near future.
> 
> Anyone who wants to follow commits to the git repo are encouraged to add themselves to the selinux-commit mailing list by going to http://oss.tresys.com/mailman/listinfo/selinux-commits.
> 
> The page is a trac wiki so anyone interested in updating or writing new pages for the site can make an account and request access to modify.
> 
> In addition to moving to a more modern SCM and having more control over the content this move also provides additional resources to SELinux developers.
> 
> Please let me know if there are any questions concerning this migration.
> 

Ok, following some issues with the git repo generated from git-svn we've decided to leave all of the old repo data in a historical repository, clonable via:

git clone http://oss.tresys.com/git/selinux-historical.git

and the main repository which contains the master branch (previously trunk) and the stable_1_0 branch (previously branches/stable/1_0)

git clone http://oss.tresys.com/git/selinux.git

I have started merging queued patches to the gitr repository now so please consider it the authoritative repository.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
