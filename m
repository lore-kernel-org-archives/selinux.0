Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB1KMDSX017729
	for <selinux@tycho.nsa.gov>; Fri, 1 Dec 2006 15:22:13 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB1KKTIW028031
	for <selinux@tycho.nsa.gov>; Fri, 1 Dec 2006 20:20:29 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id kB1KMbVZ025733
	for <selinux@tycho.nsa.gov>; Fri, 1 Dec 2006 15:22:37 -0500
Message-ID: <45708F0B.6080405@mentalrootkit.com>
Date: Fri, 01 Dec 2006 15:22:35 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: James Antill <jantill@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: User home directory creation with useradd (rhbz#217441)
References: <1165003691.18588.103.camel@code.and.org>
In-Reply-To: <1165003691.18588.103.camel@code.and.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Antill wrote:
>  As some of you know, there's an open BZ about the fact that in a
> strict/MLS environment useradd doesn't create the user's homedir with
> the correct context[1].
>  The problem is that matchpathcon() needs semanage to have run, so we
> know what SELinux user the unix user is associated with, but that runs
> separately and after useradd. The four obvious solutions are:
> 
> 1. Have an option for useradd to call semanage to add the selinux user,
> and then do the restorecon.
> 

I think this is the best option, though there needs to be additional 
flags to useradd added to allow the setting or roles.

> 2. Have semanage do the equivalent of a restorecon when doing an
> add/modify (or just add) of SELinux user information.
> 

I think this is needed in addition to one for changes to users. Should 
be optional (but perhaps on by default) since the operating is 
potentially expensive.

> 3. Have some kind of wrapper that does:
> 	i. useradd
> 	ii. semanage
> 	iii. restorecon
> 

Setools used to include something like this - didn't get much use that I 
am aware of because no one knew it was there. I would prefer patching 
the default tools.

> 4. Document that you need to call the list of programs in #3.
> 

Nobody reads documentation - this isn't viable.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
