Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA13654
	for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 20:15:08 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA13667
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 01:13:44 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id BAA13663
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 01:13:42 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 8EDF092457
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 12:15:01 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 2C7042397A
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 02:14:47 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: macros for UID lookups and login
Date: Sun, 24 Mar 2002 20:51:37 +0100
MIME-Version: 1.0
Message-Id: <20020325011447.2C7042397A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think that we need to have macros to contain all the permissions necessary 
for uid lookups (IE "ls -al") and for login.

For uid lookups read access is needed for /etc/nsswitch.conf, /etc/passwd, 
and /etc/group (presumably the policy for the domain in question will also 
have uses_shlibs() so including it again would be redundant).

Then to add support for another authentication method (pwdb, database access, 
LDAP, etc) all that needs to be done is to change the macro file.

The macro for login access must be different to that for UID lookup.  When 
using nscd and ldap or postgres the access needed for getpwnam() etc is 
totally different to that needed for PAM access (for straight /etc/passwd and 
/etc/shadow access it's the same).

Some of the sample policy files I have posted here will probably grant 
unwanted permissions due to my machines using LDAP for authentication.  I 
will have to review them all and send changes after we get some new macros 
for UID lookup.

Then we need a different macro for password change, but that's an issue that 
I haven't considered in detail so I can't comment much on it yet.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
