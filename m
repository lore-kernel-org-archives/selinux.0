Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA03554
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 05:22:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA08724
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 09:20:18 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id JAA08720
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 09:20:17 GMT
Date: Thu, 18 Apr 2002 11:22:38 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policy question
Message-ID: <20020418112238.A1788@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After the 3rd reading, I think I finally "got it" - the policy part,
that is. Objects, Domains, Types, Roles, you name it.

So, I'm now at the "learning by example" stage. I'm looking through the
example policy files, trying to understand what they do. I use that
apol tool to analyse it as well as looking through the raw files.


Now a question: One thing I'd like to write a policy about is a
seperated webserver. I *think* it can be done.

Scenario: Webhosting with PHP, multiple users (possibly many)
Danger: PHP runs as a module, i.e. with apache's user and permissions.
that means it is trivial for every user to acess other user's files,
including .php files that may include things like database passwords.

Solution: domain transition to individual user's domain when reading a
file of that user. something like
domain_auto_trans(httpd_t, user_webdata_t, user_t)
should do the trick (I say "something like" because this macro expands
to include only execution, but I see no reason why the same can't be
done for file open or read).

The tricky part is that the apache will have to revert BACK to its
original domain once the operation is done, i.e. something like "on
socket close, domain transition to httpd_t". however, the user_t domain
should not have the general ability to make a transition to httpd_t.

Am I making any sense? Or do I need to read the papers again? :)


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
