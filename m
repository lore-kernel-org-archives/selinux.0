Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i23LLZRb014261
	for <selinux@tycho.nsa.gov>; Wed, 3 Mar 2004 16:21:35 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i23LLY0F001741
	for <selinux@tycho.nsa.gov>; Wed, 3 Mar 2004 21:21:34 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i23LLYgZ001735 for <selinux@tycho.nsa.gov>; Wed, 3 Mar 2004 21:21:34 GMT
Subject: Re: Proposed patch to policy file_contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1078323734.9541.28.camel@colossus.columbia.tresys.com>
References: <403E52AD.5090103@redhat.com>
	 <1077916703.11720.274.camel@colossus.columbia.tresys.com>
	 <4044B7F5.1010302@redhat.com>
	 <1078323734.9541.28.camel@colossus.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1078348887.13948.191.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 03 Mar 2004 16:21:27 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-03-03 at 09:22, Karl MacMillan wrote:
> I have attached a patch. It is against a cvs version from last week, so
> I'm not certain that it is completely current.

It appears that error messages from the script are being written to the
generated file contexts file rather than stderr, e.g. if you have a user
in your policy/users file that is not in /etc/passwd, then you'll get:
User "foo is not present in the passwd file, skipping
in the file contexts configuration.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
