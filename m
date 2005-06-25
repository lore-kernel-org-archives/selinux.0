Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5PJYOgA014999
	for <selinux@tycho.nsa.gov>; Sat, 25 Jun 2005 15:34:25 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5PJYBN4029046
	for <selinux@tycho.nsa.gov>; Sat, 25 Jun 2005 19:34:11 GMT
Subject: Re: Alternative user management approach
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <42BD7A43.909@tresys.com>
References: <20050624225217.97028.qmail@web31614.mail.mud.yahoo.com>
	 <42BD31CE.9090908@redhat.com>  <42BD7A43.909@tresys.com>
Content-Type: text/plain
Date: Sat, 25 Jun 2005 15:37:08 -0400
Message-Id: <1119728228.13078.34.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> The biggest challenge after this is labeling, how to label home 
> directories 

How to label the home directories?
Will directories keep their role-dependent contexts?

Sounds like:

useradd---->
(add a linux user)
	-------> security_create_policydb_default()	
		(map file, load bools, load users, create policydb)

	-------> sepol_user_suser_map_file()
	(writes to user->suser map (file backend))

		--------> sepol_suser_get_defrole_file(suser)
		(gets def. context (and thus ROLE) for user's suser)

		--------> sepol_fscon_user_add()
		(writes user's file contexts based on this)
		(uses template...)

	-------> security_destroy_policydb();

suseradd----> 
(add a selinux user/class)
	
	-------> security_create_policydb_default()
		(map file, load bools, load users, create policydb)

	-------> sepol_suser_add_file()
	(sepol function to do that using file backend)
	(writes to suser->roles map)

		----------> sepol_suser_add_policy()
		(add suser to binary policy)

	-------> security_load_policydb();

	-------> security_destroy_policydb();


Please note that none of this addresses the speed issue.
A policydb still needs to be constructed for validation purposes.

However, it does address the scalability concern of not
loading every user into the kernel policy.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
