Subject: Re: What policy is the system running?
From: Karl MacMillan <kmacmillan@tresys.com>
To: Daniel Walsh <dwalsh@redhat.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <4187DEA1.8080407@redhat.com>
References: <4187DEA1.8080407@redhat.com>
Content-Type: text/plain
Date: Tue, 02 Nov 2004 17:13:35 -0500
Message-Id: <1099433615.23756.157.camel@pham.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-02 at 14:23 -0500, Daniel J Walsh wrote:
> We have been doing some work on sestatus and selinuxconfig type tools 
> to  be able to tell us about the current running system. 
> We have a problem in that we can not tell which policy is currently 
> running on the system (strict, targeted, mls, ...)  It would be
> usefull if there was a way to identify a name in policy.  Then if there 
> was a way to ask the kernel what name it has loaded. 
> One possible way we have thought about doing this is by defining a 
> boolean for each policy that would define the policytype. 
> So we could define a policytype_targeted boolean in targeted policy and 
> a policytype_strict boolean in strict policy.
> Then we could make scripts and programs smart enough to look for 
> /selinux/booleans/policytype_* to determine it.
> This is admittedly a hack but would solve our problem without having to 
> modify the kernel.  One potential problem with this is
> that the policy writers could define two policytype_ booleans.  Another 
> problem is that there is no requirement to define a
> boolean of this type.  
> 
> Other ideas that have been discussed is modifying load_policy and init 
> to write /var/run/policytype or some such, but init runs
> too early in the boot process to write to the local file system.
> 
> Adding a policyname type to policy, changin checkpolicy to require this 
> field,  and then modifying the kernel to  provide this field
> in the selinux file system, would probably be the ultimate solution. 
> 
> One other thing to think about; When we have loadable  policymodules, it 
> would be nice to identify which modules are currently loaded, via a 
> similar mechanism.
> 

The policy modules have a name defined in the policy language (which is
required). The "loaded" modules is a little harder. You can obtain a
list of installed modules in a similar manner to rpm, but when they are
loaded depends on when the kernel policy that has all of the modules
linked together is loaded. The kernel has no notion of modules, which is
nice because it required no changes to the kernel, but may present a
problem for you in this case.

Karl

> Ideas???
> 
> Dan
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
