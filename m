Message-ID: <43471239.3050407@tresys.com>
Date: Fri, 07 Oct 2005 20:26:33 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Jeremy Katz <katzj@redhat.com>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux-dev@tresys.com, James Morris <jmorris@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Loadable Modules and RPM
References: <4346D351.3070202@redhat.com>	<1128720632.1450.130.camel@moss-spartans.epoch.ncsc.mil> <1128721870.8393.33.camel@bree.local.net>
In-Reply-To: <1128721870.8393.33.camel@bree.local.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jeremy Katz wrote:
> On Fri, 2005-10-07 at 17:30 -0400, Stephen Smalley wrote:
> 
>>On Fri, 2005-10-07 at 15:58 -0400, Daniel J Walsh wrote:
>>
>>>Two problems have always existed with this:
>>>First it eliminates the possibility of having different policies for 
>>>different policy types.  IE it makes it harder to have a apache_targeted 
>>>policy or apache_mls policy.  In practice this is not such a big thing 
>>>since the "Targeted" or server based
>>>policies are mostly common across the currently defined policies.  We 
>>>have one apache policy for Targeted, Strict and MLS with minor tweaks.  
>>>The new policy language has the ability to divine optional sections to 
>>>take care of these differences.
>>
>>What about introducing a level of indirection by having apache (httpd)
>>depend on a separate httpd-policy package, and likewise for other
>>packages that have associated policy modules?  I think Hardened Gentoo
>>did something along those lines.
> 
> 
> And then you end up with separate packages with the policy for every
> package shipped in the distribution.  Which is just absurd.  The
> problems with keeping things in sync get massively more complicated in
> addition to the cost of adding lots of packages
> 
you mean potentially for every target, which is around 100 at this 
point, but maybe less than that, from what dan has shown us he only has 
around 30 policy modules building as loadable modules, this will no 
doubt increase.
> 
>>>The Second problem involves file context.  Basically the kernel has to 
>>>know the file_context before rpm lays the files down on disk.  Because 
>>>it verifies that system_u:object_r:httpd_exec_t exists.  So applications 
>>>need to install/reload policy before the files get put on disk.  What 
>>>would happen if we changed the kernel to allow certain privileged 
>>>applications to write security context onto disk, which the kernel does 
>>>not understand.  The kernel could just treat these files as 
>>>unlabeled_t.  Then the RPM package could contain the file_context to 
>>>place on disk, install the files with the correct context.  In the post 
>>>install script it could add its policy  and load it into the kernel.  At 
>>>which point the kernel would understand the file context.
>>
>>That makes it more difficult to ever confine rpm in any way.  
> 
> 
> FWIW, I think there are cases where this behavior is desirable for
> things other than just rpm.  Think about diskless systems which may be
> booting a different kernel with a different policy and range of types
> than their server -- this makes it so you can't set the context when
> creating a chroot for them.
> 

Right now rpm isn't confined but surely that is desirable in the future, 
  but like Steve said, allowing apps to set unknown security attributes 
on files makes it essentially unconfinable.

> 
>>It also is
>>problematic on the kernel side even if we wanted this behavior; the
>>kernel doesn't presently recheck the security contexts of already incore
>>inodes upon a policy reload.  If they have a SID that is invalidated by
>>the policy load, then they will subsequently be treated as unlabeled,
>>but if they start as unlabeled and then you add the type via a policy
>>reload, the incore inode label won't be reset until they are evicted
>>from memory and re-acquired by a lookup.
> 
> 
> When you put it like that, it sounds more and more like a bug which
> should be fixed.  If you load a new policy, then I'd think that anything
> which was unlabeled should definitely be re-evaluated.  Otherwise, you
> have a large potential for problems if you boot with a "wrong" policy
> and try to fix without a reboot.
> 

this is problematic anyway, it is difficult to start with the wrong 
policy and then fix every processes type (not just files are affected by 
this) without a reboot.

IMO having policy packages has many more advantages, having to reinstall 
  apache for a policy change doesn't seem desirable, and having 
disparate policies will make it difficult to package them with the 
application.

Further, switching policies altogether is very difficult if you package 
the policies with the applications, consider switching from targeted to 
strict. For now (we don't know how this we play out) assert that there 
will be a different loadable module for apache for strict and targeted. 
To switch from targeted to strict you'd have to switch the base module, 
and then switch each target to the strict version.

Basically what would happen is that every target would have to be 
removed, the strict base would have to be installed, and then each 
application would have to be reinstalled, rebuilding and reloading the 
policy each time. However, if the policy modules were seperate packages 
you could install them all ahead of time, start a transaction where you 
remove all targeted modules (including base), and then install the 
strict base and all associated modules. This provides a single, 
transactional policy switch.

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
