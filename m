Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2F5LiDo027325
	for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2005 00:21:44 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2F5FvNq000114
	for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2005 05:15:57 GMT
Subject: make install fails if any users are in local.users
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1110838214.19525.1.camel@cobra.ivg2.net>
References: <1110672353.29153.2.camel@cobra.ivg2.net>
	 <4235BE2F.8020009@redhat.com> <1110821742.16850.14.camel@cobra.ivg2.net>
	 <42360347.1030105@redhat.com>  <1110838214.19525.1.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 00:20:46 -0500
Message-Id: <1110864047.30167.8.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > genhomedircon reads your local.users file and creates the 
> > file_contexts.homedirs from it.  If
> > you don't have a user phantom in local.users then file_contexts.homedirs 
> > will cause load_policy to fail.

It seems to me that the problem is that setfiles -c, calls
sepol_set_policydb_from_file, which loads the policy, does
not call sepol_genusers, and as a result fails when it sees 
the homedir contexts. 

Also, sepol_genusers is undocumented, and the -c option of setfiles
is also not documented in the man pages.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
