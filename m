Message-ID: <3F7361F8.1080603@tresys.com>
Date: Thu, 25 Sep 2003 17:45:28 -0400
From: David Caplan <dac@tresys.com>
MIME-Version: 1.0
To: "NSA's SELinux" <SELinux@tycho.nsa.gov>
Subject: policy language extensions
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We are currently working on a couple of policy language extensions for 
which we'd like to let the group comment on.  Both grew out of the 
motivations that drove our previous work in developing a binary policy 
patch tool (see 
http://www.ultraviolet.org/mail-archives/selinux.2003/0768.html). We 
expect all changes to be eventually incorporated into the manline SE 
Linux package.

We're working on two enhancements:  conditional policy statements, and 
loadable binary policy modules.  The first is extending the policy 
language to allow conditional blocks of policy depending on the state of 
boolean variables (also defined in the policy).  The booleans are 
defined in a similar fashion to types and the conditional policy 
statements are of the form:

if (expression) then { policy_block } else { policy_block }

where 'expression' is any number of defined boolean variables joined 
with the standard operators (e.g., &&, ||, ==, !=, !, etc.) and the 
policy blocks are made up of any number of AV and Type rules with the 
'else' block being optional.

We've implemented an initial version of the user space portion of this 
(i.e., modifications to checkpolicy) and are porting the data structures 
and functionality to the kernel/security server.  We are planning to use 
  sysctl as the kernel interface to export the booleans.  A patch 
against the current version of checkpolicy is available at 
http://www.tresys.com/selinux/cond_policy_patch.gz for your perusal. 
Please note that policies built with this version of checkpolicy should 
_not_ be used (i.e., loaded) in an SE Linux kernel.  You can examine 
binary conditional policies with 'checkpolicy -d', and there is a test 
directory under the checkpolicy directory as well with a small utility 
that allows the setting of the booleans and displaying various parts of 
a binary policy.

The second extension we are currently designing is a mechanism to allow 
policy modules to be built independant of a base policy.  These modules 
could then be loaded and unloaded into a running policy.  They could be 
integrated into software packages, an rpm for example, so that if the 
software were installed on an selinux system  the appropriate policy 
would also be loaded.

Comments and contributions are welcome.

David
-- 
__________________________________

David Caplan     410 290 1411 x105
dac@tresys.com
Tresys Technology, LLC
8840 Stanford Blvd., Suite 2100
Columbia, MD 21045


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
