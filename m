Message-ID: <20050112194047.55536.qmail@web51509.mail.yahoo.com>
Date: Wed, 12 Jan 2005 11:40:47 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: Add a new class
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 2004-10-05 at 12:32, Stephen Smalley wrote:
> On Mon, 2004-10-04 at 20:40, Joshua Brindle wrote:
> > Check the files in policy/flask 
> > 
> > specifically you must add the class to 
> > security_classes and the permissions to 
> > access_vectors and then rebuild the headers with 
> > the Makefile in the flask directory and put them 
> > in linux/security/selinux/include/
> > 
> > then reboot on the new kernel and build a policy 
> > with the new classes and access vectors, it 
> > should be fairly straightforward and no problems 
> > should occur.
> 
> I don't think it is necessary to boot the new 
> kernel before building the updated policy, as you 
> can always load a policy with additional classes
> and permissions even if the existing kernel doesn't 
> use them; you only have a problem if you try to 
> change or remove an existing class or permission 
> (and the kernel will refuse to load such a policy 
> anyway). In fact, it is likely not safe to boot the 
> new kernel without first building and installing 
> the new policy, because the new kernel may try
> to use the new classes and permissions before they 
> are defined in the policy (which would result in 
> denials).

Now, I'm using FC2. I try to add a new class ( also
just for learing ).
I've added a new class to security_classes and the
permissions to access_vectors (In
/etc/security/selinux/src/policy/flask), after that,
rebuilt the headers with the Makefile in the flask
directory and put them in
/usr/src/linux-2.6.5-1.358/security/selinux/include as
Joshua Brindle have mentioned. and then rebooted on
the new kernel.
After I rebooted on the new kernel, I went into
/etc/security/selinux/src/policy, and ran 'make load'.
But this time, the security_load_policy failed!
The following is what appeared on my screen:

[root@lenovo policy]# make load
mkdir -p tmp
 [... snipped ...] 
mkdir -p /etc/security/selinux
/usr/bin/checkpolicy -o
/etc/security/selinux/policy.17 policy.conf
/usr/bin/checkpolicy:  loading policy configuration
from policy.conf
security:  5 users, 7 roles, 1244 types, 1 bools
security:  31 classes, 303377 rules
 [... snipped ...]
/usr/bin/checkpolicy:  writing binary representation
(version 15) to /etc/security/selinux/policy.15
warning: discarding booleans and conditional rules
/usr/bin/checkpolicy -c 16 -o
/etc/security/selinux/policy.16 policy.conf
/usr/bin/checkpolicy:  loading policy configuration
from policy.conf
security:  5 users, 7 roles, 1244 types, 1 bools
security:  31 classes, 303377 rules
/usr/bin/checkpolicy:  policy configuration loaded
/usr/bin/checkpolicy:  writing binary representation
(version 16) to /etc/security/selinux/policy.16
/usr/sbin/load_policy
/etc/security/selinux/policy.`cat /selinux/policyvers`
/usr/sbin/load_policy:  security_load_policy failed
make: *** [tmp/load] Error 3


Then, Is there something wrong? Would you please tell
me what's the matter with 'make load'?

Thank you. 




=====
Best Regards,
Park Lee

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
