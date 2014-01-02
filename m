Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s02EZmaE001919
 for <selinux@tycho.nsa.gov>; Thu, 2 Jan 2014 09:35:48 -0500
Message-ID: <52C57934.70200@redhat.com>
Date: Thu, 02 Jan 2014 09:35:32 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: bigclouds <bigclouds@163.com>, russell@coker.com.au
Subject: Re: question about basic selinux concept
References: <2a7b84d3.10951.143524a4a81.Coremail.bigclouds@163.com>
 <201401022053.56630.russell@coker.com.au>
 <7d555483.13261.143534c56ee.Coremail.bigclouds@163.com>
In-Reply-To: <7d555483.13261.143534c56ee.Coremail.bigclouds@163.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/02/2014 09:12 AM, bigclouds wrote:
> hi, thanks Russell Coker: my last question is  confusing 1. there are two
> categoryies,c520 and c87,at most how many categories can  exist in a label?
> c520,c87,c1,c2,c*....
> 
In most policies we set this up to 1024.  But distributions could change this.

> 2. you said  " In MCS to read a file a process needs to have every category
> that the file has (or it needs to be in a domain that can override the MCS
> controls)." as for a file, a process with same MCS must be a spicific type
> ?    not all processes labeled any type with the same MCS can access the
> file?  if i am right? 
> https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Security-Enhanced_Linux/ch07s02.html
>
> 
Only processes labeled  /svirt_t/ with the same MCS fields are able to
> read/write these image files and devices.
> 
> 
For some simple descriptions of the different enforcements (Type, MCS, MLS)
read http://opensource.com/business/13/11/selinux-policy-guide, includes cartoons.

One thing to understand from a policy point of view is MCS Separation only
effects domains(types) that opt into it, at least for Red Hat Based Policies.

In fedora 21 I get.

seinfo -amcs_constrained_type -x
   mcs_constrained_type
      svirt_kvm_net_t
      svirt_lxc_net_t
      openshift_app_t
      openshift_min_t
      openshift_net_t
      openshift_min_app_t
      openshift_net_app_t
      svirt_tcg_t
      netlabel_peer_t
      sandbox_x_t
      svirt_t
      sandbox_min_t
      sandbox_net_t
      sandbox_web_t
      openshift_t
      svirt_qemu_net_t

This means most domains like unconfined_t are not effected.  For sVirt
separations we default to picking two unique categories for each domain
launched by libvirt.  (We do the same for sandbox, openshift, and containers).
 Then MCS separation requires that the MCS Categories of the process dominate
the target.  This means a label of s0:c1,c2 can access files labeled s0,
s0:c1, s0:c2, s0:c1,c2.  Note a process labeled s0:c1,c2 would not be allowed
access to a file labeled s0:c1,c3. since the calling process does not contain
c3.  By convention we never use a single category, which means we usually have
files labeled s0 and s0:c1,c2.

Secondarily we control access based on the type enforcement.  svirt_t would
only be allowed to write svirt_image_t.  It would be allowed to read usr_t but
not write usr_t.  svirt_t is not allowed to read shadow_t, even if shadow_t
had an MCS Label of s0, or s0:c1,c2 ..In the end a process running as
svirt_t:s0:c1,c2 could write to a file labeled svirt_image_t:s0:c1,c2.  We
rely on libvirt to make sure we don't have images labeled svirt_image_t:s0.

This video on openshift shows the enforcement in action.

http://people.fedoraproject.org/~dwalsh/SELinux/Presentations/openshift_selinux.ogv
> thanks
> 
> 
> 
> 
> 
> 
> 
> At 2014-01-02 17:53:56,"Russell Coker" <russell@coker.com.au> wrote:
>> On Thu, 2 Jan 2014, bigclouds <bigclouds@163.com> wrote:
>>> there are not many document  about internal of selinux on the
>>> internet. could you answer my  questions, thanks # ps -eZ | grep
>>> qemu-kvm system_u:system_r:svirt_t:s0:c87,c520 27950 ? 00:00:17
>>> qemu-kvm
>>> 
>>> 1.there, svirt_t is a domain or a type? how to create a new type , just
>>> a sample is ok
>> 
>> In the way that SE Linux works internally there isn't a difference.  With
>> the way the policy is written the attribute "domain" is applied to any
>> type that can be used for labelling a process.
>> 
>> # # init_t is the domain of the init process. # type init_t,
>> initrc_transition_domain; type init_exec_t; domain_type(init_t) 
>> domain_entry_file(init_t, init_exec_t) kernel_domtrans_to(init_t,
>> init_exec_t) role system_r types init_t;
>> 
>> Above is a snippet from init.te.  It creates the "type" (where the word 
>> applies to a policy language keyword) init_t and then uses the interface
>>  "domain_type" to give it the attribute "domain".
>> 
>>> 2.how to know   how much authority  , on how many
>>> files,dirs,sockets.... the process of qemu-kvm  has? is there a command
>>> to show that?
>> 
>> The commands "apol" and "sesearch" allow you to discover that.
>> 
>>> 3. s0, if it can be s1,s2....(images have the same s*), if i do so ,
>>> any other requirement? if  type is targeted, if targeted has only one
>>> level, s0?   in targeted case, s1,s2...is not valid?
>> 
>> s1 only exists if you use the MLS (Multi Level Security) policy, which
>> you almost certainly aren't using (it's an advanced feature and not
>> enabled by default in any distribution you are likely to use).
>> 
>> That level field in the label is also used by MCS (Multi Category
>> Security) which allows values such as "s0:c0" and "s0:c0,c3".  Feel free
>> to experiment with that, you can use the command "runcon" to launch a
>> process with a different level and see what access it is permitted to
>> have to files of different level.
>> 
>>> 4.what does s(sensitive) and c(class) mean?
>> 
>> For MCS it's only s0 so it means nothing for you.  MLS is more complex,
>> master MCS first.
>> 
>>> 5. there are two class, c520,c87.   what is the upper limit of class 
>>> amount.
>> 
>> The categories (not classes) are numbered from c0 to c1023, there are
>> 1024 of them but this is a policy compilation choice, you could rebuild
>> the policy and use more or less.  In MCS to read a file a process needs
>> to have every category that the file has (or it needs to be in a domain
>> that can override the MCS controls).
>> 
>> -- My Main Blog         http://etbe.coker.com.au/ My Documents Blog
>> http://doc.coker.com.au/
> 
> 
> 
> 
> 
> _______________________________________________ Selinux mailing list 
> Selinux@tycho.nsa.gov To unsubscribe, send email to
> Selinux-leave@tycho.nsa.gov. To get help, send an email containing "help"
> to Selinux-request@tycho.nsa.gov.
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLFeTQACgkQrlYvE4MpobOq7wCgv7OB/W9Zs1kK7+giZKB0OBHd
sOUAn3uEkYE9e5zqJ/XH1zF9LPKQ0Xbz
=/A8Y
-----END PGP SIGNATURE-----
