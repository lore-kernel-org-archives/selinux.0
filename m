Message-ID: <3B740922.1B1A497@ksni.net>
Date: Fri, 10 Aug 2001 11:17:38 -0500
From: Ryan Senior <slax@ksni.net>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: problems with checkpolicy.conf and make initinstall
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When I execute the command make initinstall I recieve this error.

./checkpolicy:  loading policy configuration from
/usr/src/slinux/policy/initpolicy.conf
error in the statement ending on line 1054 (token ';'): unknown class
filesystem used in rule

I think that the following code is the code it is having difficulty with

#
# Allow each file type to be associated with
# the default file system type.
#
allow file_type fs_t:filesystem associate;


Is this a known error?  Is there an easy way to fix it?
I'm running Red Hat 7.1.

Thanks,
Ryan



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
