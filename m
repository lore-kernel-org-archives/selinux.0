Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OI98gA008815
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 14:09:08 -0400 (EDT)
Received: from smtp-bedford.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OI95UD028046
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 18:09:05 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with SMTP id j5OI96w21221
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 14:09:06 -0400
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (Postfix) with ESMTP id 34A9EBF7E
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 14:09:06 -0400 (EDT)
From: bsniffen@mitre.org (Brian T. Sniffen)
To: "Karl MacMillan" <kmacmillan@tresys.com>
Cc: <selinux@tycho.nsa.gov>
Subject: Re: Alternative user management approach
References: <200506241602.j5OG2Gqc016513@gotham.columbia.tresys.com>
Date: Fri, 24 Jun 2005 14:09:05 -0400
In-Reply-To: <200506241602.j5OG2Gqc016513@gotham.columbia.tresys.com> (Karl
	MacMillan's message of "Fri, 24 Jun 2005 12:02:17 -0400")
Message-ID: <d284qbn8w5a.fsf@jon-strange.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

"Karl MacMillan" <kmacmillan@tresys.com> writes:

> This makes the SELinux user more what we are calling a 'user
> role'. For example, the policy could create 3 user roles with
> different role authorizations (which become 'role capabilities'):

This seems like a great innovation.  But it does inherit one problem
of generic user_u: there's no longer any MAC separating users.  If I'm
a normal user, my shell has exactly the same security context as your
shell---right?

-Brian


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
