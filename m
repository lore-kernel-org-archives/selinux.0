Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA16217
	for <selinux@tycho.nsa.gov>; Thu, 2 Jan 2003 08:25:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h02DPtI17306
	for <selinux@tycho.nsa.gov>; Thu, 2 Jan 2003 13:25:55 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h02DPtf17302 for <selinux@tycho.nsa.gov>; Thu, 2 Jan 2003 13:25:55 GMT
Message-Id: <200301021330.IAA10038@moss-shockers.ncsc.mil>
Date: Thu, 2 Jan 2003 08:30:03 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: SELinux To Do list
To: selinux@tycho.nsa.gov, kerry@crypt.gen.nz
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I've made a start on a technical-level FAQ, currently at 
> 
> http://www.crypt.gen.nz/selinux/faq.html
> 
> and I'm working on back-tracking through the list archives for more material. 
> Any comments or corrections are most welcome.

Thanks for creating this FAQ.  I've made a few comments below.

1) Some of your questions and answers are also covered in the Configuring the 
SELinux Policy report, http://www.nsa.gov/selinux/policy2-abs.html, in 
particular the Building and Applying the Policy section and the Customizing the 
Policy section of that report.  Feel free to use it as a resource and to refer 
people to it as well.  Please report any errors in it and feel free to submit 
patches to it (the document source is included in the selinux archive, under 
selinux/doc/policy).  

2) You can relabel a specified list of files via the -s option to setfiles 
rather than rechecking the entire filesystem.  This option was added by Russell 
Coker.

3) If you want to deny avc_toggle permission, you need to change 'allow' rules 
in the configuration, not 'auditallow' rules.  'auditallow' rules specify what 
permissions should be audited when they are allowed (granted) to a process.  By 
default, permissions are only audited when they are denied to a process (unless 
they are suppressed via 'dontaudit' rules).  You can enable auditing of allowed 
permissions via auditallow in order to maintain a record of all uses of a given 
permission, e.g. to provide accountability for a highly privileged operation.  
Removing the 'auditallow' rules merely turns off auditing when the permission is 
granted; it has no effect on allowing the permission.

To remove avc_toggle permission in the example policy, you would need to edit 
macros/admin_macros.te and replace the 'allow $1_t kernel_t:system *;' with 
'allow $1_t kernel_t:system ~avc_toggle;'.  You would also need to edit 
domains/program/initrc.te and replace the 'allow initrc_t kernel_t:system *;' 
rule with 'allow initrc_t kernel_t:system ~avc_toggle;'.  To ensure that you 
have removed all such instances, you can edit assert.te and replace 'neverallow 
~{ admin initrc_t } kernel_t:system avc_toggle;' with 'neverallow domain 
kernel_t:system avc_toggle;'.  The policy compiler (checkpolicy) will then 
verify that no domain is granted this permission and report any violations of 
this assertion when it compiles the policy.

To remove the ability to reload the policy on a running system, you would remove 
load_policy permission from all domains, and completely remove the load_policy 
domain.   As above, you can define an assertion so that checkpolicy will catch 
any exceptions to this, e.g. 'neverallow domain security_t:security 
load_policy;'.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
