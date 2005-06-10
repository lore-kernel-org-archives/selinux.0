Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5AL6BgA022787
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 17:06:11 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5AKwWfM012919
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 20:58:32 GMT
Subject: RE: Restorecon script
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'SELinux'" <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
In-Reply-To: <200506101945.j5AJjo5F002174@gotham.columbia.tresys.com>
References: <200506101945.j5AJjo5F002174@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 16:57:54 -0400
Message-Id: <1118437074.4812.24.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Maybe - doesn't mean that blindly relabeling them won't cause problems or
> confusion. It is a large change to reset permissions on home directories on
> login. Seems like this is better done at installation time or on specific admin
> / user request.

Why should blindly relabeling internal files cause problems or 
confusion? I am assuming that policy has the correct context, and
anything else is wrong - after all those are _internal_ files,
not to be directly manipulated by the user, but handled
automatically.

The script does not reset permissions on home directories, it
resets permissions on specific subfolders. More importantly,
it does not reset the top level directory.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
