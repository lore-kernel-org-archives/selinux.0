Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8CGOpCc007353
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 12:24:51 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8CGOmIv023526
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 16:24:48 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8CGOlVX005929
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 12:24:47 -0400
Subject: Inherited tpe definition
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SE Linux <selinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Date: Wed, 12 Sep 2007 12:24:41 -0400
Message-Id: <1189614281.4270.39.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was thinking about two of the long-standing complications to writing
selinux policy: type splitting and creating new types similar to old
types. (these problems were pointed out to me in some private
discussions with Dan and Steve). It occurred to me that on old
suggestion from KaiGai helped with these problems if we could overcome
some of the concerns. So I wanted to start that discussion again. First
- the problems.

Type splitting refers to what happens when you have an existing type
that isn't specific enough and you want to split it into two or more
types. As an example, take some log files:

/var/log/messages -> var_log_t
/var/log/secure -> var_log_t
/var/log/spooler -> var_log_t
/var/log/maillog -> var_log_t

Say I want to create a new domain that can only read /var/log/messages
but shouldn't be able to read the other log files (no idea if there is
security advantage there - this is a made up example). I can create a
new log type (var_messages_t), but I must carefully track down all
domains that currently have/need access to /var/log/messages and allow
them access to the new type. This is somewhat possible - but difficult
and error prone - and fails if there are third party modules of which I
am unaware. And this is a simple example - more complicated examples
require re-factoring certain access as attributes and changing existing
policy.

The second problem is if I want to create a new domain based on an
existing domain (this is what Dan is doing with guest_t and xguest_t).
Basically, now there is no language support for this and you end up
defining lots of templates. Works fine if you plan for it ahead of time,
but fails miserably if the templates weren't created.

KaiGai suggested these problems (and some others) could be solved via
inheritance - his suggestion is discussed starting at
http://marc.info/?l=selinux&m=111073215428407&w=2. Looking at that
again, it seems to solve the splitting problem _very_ well and provides
a basis for solving the second problem.

The main objections were (that I can remember - there may be more):

1) Extending an existing type often means understanding a set of related
types. For example, creating a new domain based on httpd_t probably
requires a new httpd_log_t and httpd_conf_t (again - made up example).
Straight inheritance doesn't capture this relationship and makes it
difficult to define the related types, give the correct inter-set
access, and (most importantly) maintain the right separation between the
old set and new set. There were some suggestions to address this but no
consensus.

2) Extending often has two incompatible goals - extending to add access
and extending to remove access. The inheritance proposal only addressed
the first (though there was some discussion about the second). It is
very hard to address access removal without adding deny rules (or some
such) which is a path with _many_ potential problems.

3) I had suggested in that thread that reference policy interfaces /
templates was a better solution to these problems. I think that I was
wrong - these problems seem to still exist and haven't been adequately
addressed via interfaces.

So - I'd like to consider this proposal again and see if anyone has any
ideas on solving the objections.

Thanks,

Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
