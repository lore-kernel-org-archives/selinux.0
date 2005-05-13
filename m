Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4DCKCgA002368
	for <selinux@tycho.nsa.gov>; Fri, 13 May 2005 08:20:13 -0400 (EDT)
Received: from web60414.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j4DCHM6j004032
	for <selinux@tycho.nsa.gov>; Fri, 13 May 2005 12:17:22 GMT
Message-ID: <20050513121723.1202.qmail@web60414.mail.yahoo.com>
Date: Fri, 13 May 2005 05:17:22 -0700 (PDT)
From: Roger Brunell <rog_brunell@yahoo.com>
Subject: Policy 1.22 Presentation?
To: SELinux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Folks;
  This may seem to be a rather mundane question, but
some guidance would be appreciated. I *think* I have
selinux running on a Debian derived OS (2.6.11-3). I
installed the NSA 1.22 policy. 

?1? There were messages during the policy 'install'
about undefined things:

------
install -m 644 local.users
/etc/selinux/strict/users/local.users

Validating file_contexts ...

/usr/sbin/setfiles -q -c
/etc/selinux/strict/policy/policy.19
/etc/selinux/strict/contexts/files/file_contexts

/etc/selinux/strict/contexts/files/file_contexts.homedirs:
 line 28 has invalid file type /etc/default/useradd:
-----

  Something left a bunch of error messages in that
file.

----
#
# Context for user user_u
#

grep: /etc/default/useradd: No such file or
directory/[^/]*             -d     
user_u:object_r:user_home_dir_t
grep: /etc/default/useradd: No such file or
directory/[^/]*/.+                 
user_u:object_r:user_home_t
grep: /etc/default/useradd: No such file or
directory/[^/]*/\.ssh(/.*)?        
user_u:object_r:user_home_ssh_t
----
 Is this a "RedHatism"? 
 What should be here?
 Does it pose a problem in Debian?
 I don't have the /etc/default/useradd file.

?2? The policy makefile does 'MLS' or 'strict'; what
about 'targeted'? How is that installed? I think that
is the model I need. Guard the door; but let the
customers do what they want to each other.




Roger Brunell

Infosec Engineer (retired)
"Born 20 years too early"

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
