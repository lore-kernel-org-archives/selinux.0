Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: default user role
Date: Tue, 15 Oct 2002 21:15:45 +0200
MIME-Version: 1.0
Message-Id: <200210152115.45180.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I believe that the identity "user_u" should not be permitted any roles but the 
least priviledged.  So that means that the "user_r" role should not be the 
one for typical logins that matter.

I propose that we change the default policy to have the following:
full_user_role(user_unpriv)

And then change the in_user_role() macro in macros/user_macros.te to use 
user_unpriv_r.

Then the users file needs to have:
user user_u roles user_unpriv_r;

The default contexts and cron_contexts files also need to be modified 
accordingly.


I have some good reasons for this that I don't want to discuss right now...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
