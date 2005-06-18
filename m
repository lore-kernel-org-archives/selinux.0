Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5IMnGgA016606
	for <selinux@tycho.nsa.gov>; Sat, 18 Jun 2005 18:49:16 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5IMeEQ1010730
	for <selinux@tycho.nsa.gov>; Sat, 18 Jun 2005 22:40:14 GMT
Subject: Re: Useradd Integration (v. 2)
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: SELinux <selinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1119132219.26988.14.camel@localhost.localdomain>
References: <1119132219.26988.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 18 Jun 2005 18:41:59 -0400
Message-Id: <1119134520.27489.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Next, I will work on writing C functions for manipulating the
> homedir_template file. They will be analogous to users_file.c,
> and basically move genhomedircon's job into the libsepol library.

Actually, I think it would be better if I pulled out 
iterate, mod_user, add... into a more generic thing I can reuse
for net_contexts, and homedir... 

So: a method for iterating records in a file... 
for modifying records in a file.

Then the structure of the record would be specified for each
thing I want to iterate over - instead of user_config_t, it would
be something else, with a different parse function.

I haven't actually seen the checkpolicy parsing code, and how
modular it is - I used the genusers parsing code... If the
checkpolicy code is sufficiently modular, I should be able to 
reuse that...

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
