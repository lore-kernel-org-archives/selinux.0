Message-ID: <3EDB7585.8050308@redhat.com>
Date: Mon, 02 Jun 2003 12:04:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Default Policy question?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Has anyone discussed the problem of having root be a member of the 
sysadm_r role.  Is there a way to define policy such that you could
allow a sysadmin to manipulate configuration without allowing them to
effect policy?  Ie, does the default policy allow someone the ability to
change the /etc/printcap file but not run load_policy?  Should we have 
three levels of user by default.  My problem with this is that 
sysadmin's are going to become root and run newrole to sysadm_r to 
manipulate configuration.  If they stay newrole and run a trojaned app,
security is compromized.

user_r    - Very little privs for general users
sysadm_r  - Ability to manipulate all standard Linux config files.
policy_r  - Ability to change the way the kernel handles policy. 
(/etc/security/selinux/*, /etc/grup.conf, chsid, avc_toggle ...)

policy_r should not be defaulted to the root user but garnered in some 
other way.

Anyone have any ideas on this?


Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
