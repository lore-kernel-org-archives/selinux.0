Message-ID: <4187DEA1.8080407@redhat.com>
Date: Tue, 02 Nov 2004 14:23:13 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: What policy is the system running?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We have been doing some work on sestatus and selinuxconfig type tools 
to  be able to tell us about the current running system. 
We have a problem in that we can not tell which policy is currently 
running on the system (strict, targeted, mls, ...)  It would be
usefull if there was a way to identify a name in policy.  Then if there 
was a way to ask the kernel what name it has loaded. 
One possible way we have thought about doing this is by defining a 
boolean for each policy that would define the policytype. 
So we could define a policytype_targeted boolean in targeted policy and 
a policytype_strict boolean in strict policy.
Then we could make scripts and programs smart enough to look for 
/selinux/booleans/policytype_* to determine it.
This is admittedly a hack but would solve our problem without having to 
modify the kernel.  One potential problem with this is
that the policy writers could define two policytype_ booleans.  Another 
problem is that there is no requirement to define a
boolean of this type.  

Other ideas that have been discussed is modifying load_policy and init 
to write /var/run/policytype or some such, but init runs
too early in the boot process to write to the local file system.

Adding a policyname type to policy, changin checkpolicy to require this 
field,  and then modifying the kernel to  provide this field
in the selinux file system, would probably be the ultimate solution. 

One other thing to think about; When we have loadable  policymodules, it 
would be nice to identify which modules are currently loaded, via a 
similar mechanism.

Ideas???

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
