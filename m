Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FGO9L9008509
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 11:24:09 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1FGN0ER005678
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 16:23:01 GMT
Message-ID: <421221C0.20907@redhat.com>
Date: Tue, 15 Feb 2005 11:22:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SE-Linux <selinux@tycho.nsa.gov>, Frank Mayer <mayerf@tresys.com>
Subject: Adding libseuser functionality to libselinux?
References: <20050215155323.GC23765@lkcl.net>
In-Reply-To: <20050215155323.GC23765@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thoughts on moving some of the functions available in setools into 
libselinux.

Basically I want to add the ability to addroles via the adduser command  
(shadow-utils) and thus
make dealing with roles easier in OS.  The problem is that I don't want 
to require setools  in
order to get this functionality (libseuser).   

I need the ability to get the roles that are available via the currently 
running policy and to manipulate
the users defined in the local.users file.  I then need to have 
genpolusers type functions to allow me
to change the running policy.  We don't need the functionality that 
deals with policy-sources.

What do you think of moving these functions into libselinux?

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
