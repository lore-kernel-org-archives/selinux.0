Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA10537
	for <selinux@tycho.nsa.gov>; Thu, 5 Jul 2001 16:00:50 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA02528
	for <selinux@tycho.nsa.gov>; Thu, 5 Jul 2001 20:00:38 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id UAA02524
	for <selinux@tycho.nsa.gov>; Thu, 5 Jul 2001 20:00:38 GMT
Date: Thu, 5 Jul 2001 15:59:48 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Steve Eckmann <eckmann@computer.org>
cc: selinux@tycho.nsa.gov
Subject: Re: how to add new user roles
In-Reply-To: <4.3.2.7.2.20010705115300.00aed870@mail1.abac.com>
Message-ID: <Pine.SOL.3.95.1010705154016.16955B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 5 Jul 2001, Steve Eckmann wrote:

>I guess I need to create a file like user.te for each new domain,
>possibly containing just a new type definition and a user_domain()
>"call", plus whatever new rules apply to each new domain.

Yes, although you need to ensure that the user_domain macro definition
is read prior to the first attempt to use it.  Right now, if you
simply create some additional *.te files in domains/user, there 
isn't any guarantee that user.te will be read first.  So you might
need to rearrange things a little or tweak the Makefile.  Or you
could just add your new domains to the end of the existing user.te file.

> Can someone share a simple new user domain they've developed, or at 
>least the steps needed to add a new domain and role? For example, suppose
>I want two new domains A and B just like user except that A can read and
>execute B files, and B can read but not execute A files.

Sorry, I don't have an example, but I can describe what I think will
be necessary.  In addition to defining the domains as you mentioned 
above, you'll need to:
1) Authorize login to enter the domains by adding a domain_trans
   rule to domains/system/login.te, e.g.

   domain_trans(local_login_t, shell_exec_t, a_t)

2) Define rules for the newrole_t domain so that it will relabel
terminals properly for the new domains.  See the existing rules
for user_*_t in domains/program/newrole.te.  These rules actually
should be moved into the user_domain macro using the parameter
as with the login rules.

3) Define the role in the rbac file.  Same as user_t, but
replace 'user' with your domain.  You could define a macro
based on the current user_r definition and then reuse for
each of the user domains if you want.

4) Authorize users for the role in the users file.

5) Relabel the home directories of the users who will use
one of the new roles to the corresponding *_home_t type
using the chcon program.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
