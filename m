Subject: RFC Kernel interface to conditional policy
From: Karl MacMillan <kmacmillan@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1070484482.3774.54.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Wed, 03 Dec 2003 15:48:02 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This email is to get some feedback about the kernel interface to the
booleans in the conditional policy work that we have been doing. This
has been discussed off-list some, but I'd like to bring it up here to
get some public discussion of the issue.

Background

We have added conditional expressions to the selinux policy language.
This allows you to place TE rules in if/else blocks with conditional
expressions. The booleans in the conditional expressions can be
controlled at runtime to allow the addition or removal of rules based on
the value of the booleans/expressions.

Problem

Our initial prototype exports the booleans as files under
/proc/sys/selinux/booleans using the sysctl interface
([un]register_sysctl_table). On each policy reload we call
unregister_sysctl_table and then re-register all of the booleans. The
problem is that if one of the boolean files is in use the file is not
removed and unregister_sysctl_table gives no indication that unregister
was not successful. The solutions to this problem that we see are:

1) Manipulate proc files directly. This allows fine-grained labeling of
the boolean files, but kernel developers seem to be frowning on new uses
of proc.

2) Extend the selinux filesystem. This wouldn't allow fine-grained
labeling and would pollute the policy-neutral security server interface
with type enforcement policy specific functionality.

3) Create a new filesystem. This would be the most work, but otherwise
meet our needs.

Any comments or suggestions are welcome.

Thanks,

Karl


-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
