Subject: Selinux Testsuite changes
From: Joy Latten <latten@austin.ibm.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 27 Mar 2006 13:30:04 -0600
Message-Id: <1143487805.2462.274.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The Selinux testsuite policy has been converted to use refpolicy.
You can download the converted policy and test suite from LTP's CVS tree
on sourceforge.
 
I left the old-style policy just in case, and put the new policy in 
testcases/kernel/security/selinux-testsuite/refpolicy directory.
The test_selinux.sh script will only work with the refpolicy for now.
Also, in the refpolicy directory I created a "TODO" file which lists
a few tests that fail because they require additional policy work.
Please feel free to help out or post a solution.

You will also need interface patches I sent out last week to modify base
policy. Chris PeBenito has merged them. 

Let me know if there are any problems.

Regards,
Joy Latten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
