Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2T5oqPs012801
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2007 01:50:52 -0400
Received: from web86908.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2T5oo5B007395
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2007 05:50:51 GMT
Date: Thu, 29 Mar 2007 06:50:35 +0100 (BST)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Conditional Policy using Reference Policy
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <20070327140452.56698.qmail@web86904.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <321794.33448.qm@web86908.mail.ukl.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi every one,

I am trying to configure SELinux conditional policy
using the Reference policy mechanism. Unfortunately,
it does not take effect but, the module compiled
successfuly. Which means that there was no boolean
variable in the /selinux/booleans/. Plus, i wanted to
ask, is this the correct way to enforce a conditional
policy. The objective of this simple policy is that
"any application can read/write but cannot delete this
file, provided the boolean variable is set"

Secondly, there are some commands given in the
litrature for committing the values of the booleans to
make them effective like change_bool variable 1, and
echo 1 > /selinux/commit_pending_bools. The question
is that whether these commands are not avialable any
more?

The module files are as follows:
Thanks,
JG

myapp.te:

policy_module(myapp,1.0)
type myapp_t;
domain_type(myapp_t)


myapp.if:
interface(`myapp_open_cond',`
	gen_requires(`
		type myapp_t; bool test;
	')

	
        if (test) {
	allow $1 myapp_t:file rw_file_perms;
	}
')

myapp.fc:

/root/testfile   -- gen_context(system_u:object_r:myapp_t,s0)


		
___________________________________________________________ 
The all-new Yahoo! Mail goes wherever you go - free your email address from your Internet provider. http://uk.docs.yahoo.com/nowyoucan.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
