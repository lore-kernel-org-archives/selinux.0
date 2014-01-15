Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0FICl6x020295
 for <selinux@tycho.nsa.gov>; Wed, 15 Jan 2014 13:12:47 -0500
Message-ID: <52D6CF7C.8010107@redhat.com>
Date: Wed, 15 Jan 2014 13:12:12 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Tawfiq Shah <tawfiqshah@gmail.com>, russell@coker.com.au
Subject: Re: question about basic selinux concept
References: <2a7b84d3.10951.143524a4a81.Coremail.bigclouds@163.com>
 <201401022053.56630.russell@coker.com.au>
 <CAP_GsaSW3yBooy8m18eD2UcHP-KTddVyZ23xCRQK_TbDoVOzSA@mail.gmail.com>
In-Reply-To: <CAP_GsaSW3yBooy8m18eD2UcHP-KTddVyZ23xCRQK_TbDoVOzSA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/15/2014 01:00 AM, Tawfiq Shah wrote:
> Hi I am new to selinux and i have a couple basic questions regarding
> selinux 1.regarding the policy Are the permissions flexible or rigid like
> DAC 3 bit rwx allocated to each group or can we add to. I can see per the
> common permission we have things like read write getattr but if i wanted to
> add an additional permission like have read permission when the system is
> at a state X (assuming the system has a measured state)  or allow read only
> when time is x & y is it possible?? or would i have to set a conditional
> policy with the use of boolean values or extended the common permission or
> the class specific permission
> 
Well if you modified the kernel you could write policy for you, but you need
code in either userspace or the kernel to check access to make your new policy
work.
> 2. regarding security contexts for example fire fox wants to read a file
> the lookup inode will query the SID of the source and the targeted files.
> The LSM hook will relay the SIDs to the security server. which will in-turn
> map the SID to the security context which will then be crossed checked with
> the policy rules. my question is so where are the security context actually
> stored?or accessed by the security server? and how does the xattr help in
> getting info on the security context.
> 
The security context is stored on the xattr of the file system with the inode.
 When the access happens the SID for the  security context is looked up and
then the kernel checks if the policy allowed the SID of the source process the
access on the target file system object.
> Thanx
> 
> 
> 
> 
> 
> 
> On Thu, Jan 2, 2014 at 3:53 AM, Russell Coker <russell@coker.com.au 
> <mailto:russell@coker.com.au>> wrote:
> 
> On Thu, 2 Jan 2014, bigclouds <bigclouds@163.com
> <mailto:bigclouds@163.com>> wrote:
>> there are not many document  about internal of selinux on the internet. 
>> could you answer my  questions, thanks # ps -eZ | grep qemu-kvm 
>> system_u:system_r:svirt_t:s0:c87,c520 27950 ? 00:00:17 qemu-kvm
>> 
>> 1.there, svirt_t is a domain or a type? how to create a new type , just
>> a sample is ok
> 
> In the way that SE Linux works internally there isn't a difference.  With
> the way the policy is written the attribute "domain" is applied to any type
> that can be used for labelling a process.
> 
> # # init_t is the domain of the init process. # type init_t,
> initrc_transition_domain; type init_exec_t; domain_type(init_t) 
> domain_entry_file(init_t, init_exec_t) kernel_domtrans_to(init_t,
> init_exec_t) role system_r types init_t;
> 
> Above is a snippet from init.te.  It creates the "type" (where the word 
> applies to a policy language keyword) init_t and then uses the interface 
> "domain_type" to give it the attribute "domain".
> 
>> 2.how to know   how much authority  , on how many files,dirs,sockets.... 
>> the process of qemu-kvm  has? is there a command to show that?
> 
> The commands "apol" and "sesearch" allow you to discover that.
> 
>> 3. s0, if it can be s1,s2....(images have the same s*), if i do so , any 
>> other requirement? if  type is targeted, if targeted has only one level, 
>> s0?   in targeted case, s1,s2...is not valid?
> 
> s1 only exists if you use the MLS (Multi Level Security) policy, which you 
> almost certainly aren't using (it's an advanced feature and not enabled by 
> default in any distribution you are likely to use).
> 
> That level field in the label is also used by MCS (Multi Category
> Security) which allows values such as "s0:c0" and "s0:c0,c3".  Feel free to
> experiment with that, you can use the command "runcon" to launch a process
> with a different level and see what access it is permitted to have to files
> of different level.
> 
>> 4.what does s(sensitive) and c(class) mean?
> 
> For MCS it's only s0 so it means nothing for you.  MLS is more complex,
> master MCS first.
> 
>> 5. there are two class, c520,c87.   what is the upper limit of class 
>> amount.
> 
> The categories (not classes) are numbered from c0 to c1023, there are 1024
> of them but this is a policy compilation choice, you could rebuild the
> policy and use more or less.  In MCS to read a file a process needs to have
> every category that the file has (or it needs to be in a domain that can
> override the MCS controls).
> 
> -- My Main Blog         http://etbe.coker.com.au/ My Documents Blog
> http://doc.coker.com.au/ _______________________________________________ 
> Selinux mailing list Selinux@tycho.nsa.gov <mailto:Selinux@tycho.nsa.gov> 
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov 
> <mailto:Selinux-leave@tycho.nsa.gov>. To get help, send an email containing
> "help" to Selinux-request@tycho.nsa.gov
> <mailto:Selinux-request@tycho.nsa.gov>.
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

iEYEARECAAYFAlLWz3wACgkQrlYvE4MpobOCuACfZKPWCqqq1+RemhTeOhB3xGoU
SyQAoJ4DPVbJGrRud/EtrtKFGkv+NbZ+
=mtlq
-----END PGP SIGNATURE-----
