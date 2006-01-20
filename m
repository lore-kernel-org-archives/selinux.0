From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Ivan Gyurdiev <ivg2@cornell.edu>
Subject: Re: [SEMANAGE] Further bugfixes
Date: Fri, 20 Jan 2006 23:20:57 +1100
Cc: SELinux List <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   Stephen Smalley <sds@tycho.nsa.gov>
References: <43D0383C.8010404@cornell.edu>
In-Reply-To: <43D0383C.8010404@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200601202321.07517.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>From a patch to the semanage program:
+semanage fcontext [-admhfrst] CONTEXT_EXPRESSION\n\
+semanage interface [-admtr] INTERFACE_NAME\n\
 semanage login [-admsr] LOGIN_NAME\n\
-semanage port [-admtpr] PORT | PORTRANGE\n\
+semanage port [-admtpr] PORT | PORT_RANGE\n\

I think that all of these should be changed similar to my revised man page 
(which I posted under the subject "semanage patch" on the 14th of Jan).

semanage fcontext -{a|d|m} [-hfrst] CONTEXT_EXPRESSION\n\
semanage interface -{a|d|m} [-tr] INTERFACE_NAME\n\
semanage login -{a|d|m} [-sr] LOGIN_NAME\n\
semanage port -{a|d|m} [-tpr] PORT | PORT_RANGE\n\

The convention is that anything within [] is optional, however it is not 
optional to have one of 'a', 'd', or 'm', it is required to have exactly one 
of them.

Also there should be a line such as the following to indicate the ways in 
which the "-l" option can be used (it can't be used in conjunction with any 
other option):
semanage {login|user|port} -l

Do "interface" and "fcontext" support the "-l" option?

I would offer a patch for this, but I think we have enough unmerged patches 
for the semanage utility floating around at the moment.  Once we get the 
current patches sorted out I'll be happy to write a patch for this.


Finally, when semanage development slows down a bit we will have to put in 
some decent error checking for command-line parameters.  Currently you can 
pass in parameters that are not used to a command without an error or warning 
message.  For example the following command will work even though -R is not a 
valid option to the login management interface.

semanage login -a -s user_u -r s0 -R sysadm_r john

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
