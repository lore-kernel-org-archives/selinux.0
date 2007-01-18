Message-ID: <45AFA08F.9080602@tresys.com>
Date: Thu, 18 Jan 2007 11:30:07 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC] 0/4 - Hierarchal apache policy for reference policy
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an RFC for policy allowing management delegation through 
hierarchical types.

Policy management often is handled by different administrators, based on 
the application or applications that are being governed. As a result, 
providing a means to delegate access to manage only certain aspects of 
policy is desirable, and can be accomplished using hierarchical types.

The proof of concept apache policy module illustrates policy management 
delegation through hierarchical types. This example apache policy works 
together with an adds metapolicy to the apache module and adds a policy 
server labeling file (apache.pc) that must be appended to the policy 
context file (the default for policy server is 
/etc/selinux/policy_contexts) to split apache’s policy management 
between different users.

In this policy, for example, management access to apache content is 
broken down hierarchically based on the content owner. Then 
apache_t.user_content is labeled user_apache_policy_t to only allow 
user_t to add new rules for apache_t.user_content type. Similar rules 
prevent user_t from using types like apache_t.staff_content. See the end 
of apache_per_role_template() in apache.if for the rules that govern how 
users change policy.

The enforcement of the metapolicy requires the policy management server, 
which will be released for preview soon.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
