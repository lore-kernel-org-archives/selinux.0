Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5TJNMgA015858
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 15:23:22 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5TJMS79024961
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 19:22:28 GMT
Subject: RE: file contexts and modularity
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <200506291904.j5TJ447f019254@gotham.columbia.tresys.com>
References: <200506291904.j5TJ447f019254@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 15:20:10 -0400
Message-Id: <1120072810.20484.66.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> If there was no expectation that the user home directories would not be
> relabeled (e.g., via restorecon) as a normal part of running a system then there
> would be no reason to generate the file contexts.

Context inheritance combined with automated transitions are not 
sufficient... this becomes clear as you try to label directories
with mixed-type content....but this is another discussion.

>  The home directory would be labeled upon creation.

It still has to query policy for the type to use for labeling.
Currently that's accomplished by mathpatchcon..unless you
are suggesting that we write a special interface specifically
to get the home type for a user, bypassing the matching.

> As for the general concept of runtime labeling - I mean labeling other than at
> initialization time (system installation, user addition, etc.). I have often
> argued against runtime labeling - maybe not in this thread but other places. It
> is often unsafe and leads towards discretionary access control.

Unsafe? This is all audited by the policy (relabelto relabelfrom)
I don't see what's discretionary about it.

> I'm not certain this is possible in the real world, but I think it is the
> correct 

I think selinux's dependence on fixed organization scheme and static
labeling is one of its major weaknesses. I'm not sure whether
it's good from a security standpoint, but practically, users
just like to put things wherever they like...




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
