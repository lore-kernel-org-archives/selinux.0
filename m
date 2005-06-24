Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OIZCgA009168
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 14:35:12 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OIZ9UD029885
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 18:35:09 GMT
Subject: Re: Alternative user management approach
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: "Brian T. Sniffen" <bsniffen@mitre.org>
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <d284qbn8w5a.fsf@jon-strange.mitre.org>
References: <200506241602.j5OG2Gqc016513@gotham.columbia.tresys.com>
	 <d284qbn8w5a.fsf@jon-strange.mitre.org>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 14:32:40 -0400
Message-Id: <1119637960.31852.51.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-24 at 14:09 -0400, Brian T. Sniffen wrote:
> "Karl MacMillan" <kmacmillan@tresys.com> writes:
> 
> > This makes the SELinux user more what we are calling a 'user
> > role'. For example, the policy could create 3 user roles with
> > different role authorizations (which become 'role capabilities'):
> 
> This seems like a great innovation.  But it does inherit one problem
> of generic user_u: there's no longer any MAC separating users.  If I'm
> a normal user, my shell has exactly the same security context as your
> shell---right?

Is the user info used for anything besides rbac?
I don't think it is...




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
