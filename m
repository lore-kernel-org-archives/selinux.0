Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4BJ4bgA020812
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 15:04:38 -0400 (EDT)
Received: from web31613.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j4BJ243Y022857
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 19:02:04 GMT
Message-ID: <20050511190205.83556.qmail@web31613.mail.mud.yahoo.com>
Date: Wed, 11 May 2005 12:02:05 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC]{Patch 0/5] Polyinstantation
To: "Timothy R. Chavez" <tinytim@us.ibm.com>, selinux@tycho.nsa.gov
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- "Timothy R. Chavez" <tinytim@us.ibm.com> wrote:

> I'm not too familiar with MLS, but is it really
> necessary to audit every thing 
> the user is  accessing?

In the usual case accessing files in /tmp
will be completely uninteresting to any
sane security officer. In unusual cases,
or in the presence of an insane security
officer it must be possible to do so.
Polyinstantiated directories have driven
any number of otherwise rational admins
over the edge.

> What if /tmp/foo maps to
> something uninteresting in 
> both SECRET and UNCLASSIFIED, do we really care?

Nope. We don't care. The user who is being watched
may care a lot if difficulty in differentiation
lands her in jail. It can happen.

> If
> /tmp/foo maps to 
> something security-critical and interesting, I'd
> suspect it will be audited 
> (irrespective of namespace, at the inode level), in
> which case a record will 
> be generated with a security context, loginuid, etc.

This is only going to be true if it's known in
advance by the admins that /tmp/foo will contain
important stuff, and which /tmp/foo that's going
to be.


Unix MLS systems address polyinstantiated
directories in the pathname resolution code
rather than remapping process mount spaces.


Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Yahoo! Mail Mobile 
Take Yahoo! Mail with you! Check email on your mobile phone. 
http://mobile.yahoo.com/learn/mail 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
