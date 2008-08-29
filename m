Subject: Re: semodule -i error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: shaunak saha <reach.shaunak@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <d74d42a50808290333u4e73b7abo1a24762b74e47659@mail.gmail.com>
References: <d74d42a50808290333u4e73b7abo1a24762b74e47659@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 29 Aug 2008 09:22:18 -0400
Message-Id: <1220016138.5708.289.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-08-29 at 16:03 +0530, shaunak saha wrote:
> Hi all,
>  
> When i m trying to install a module using semodule -i <name of the
> module> i m geting the following error:
>  
> libsepol.print_missing_requirements: dbus_rpc_example_server's global
> requirements were not met: type/attribute resmgrd_var_run_t

So your module has a require on that type (presumably by using an
interface that depends on it), and you don't have that type defined in
your policy.

> libsemanage.semanage_link_sandbox: Link packages failed
> semodule:  Failed!
>  
> Also when i do "semodule -l" i could not see any module resmgr.

So that's the problem - you didn't install it?  Or you didn't include it
in your base?

> I m actually trying to insert a new class gconf (making gconf-daemon
> an userspace object manager).
> For this i have downloaded the refpolicy
>   
> refpolicy-20080702.tar.bz2 from
> http://oss.tresys.com/projects/refpolicy/wiki/DownloadRelease and
> installed it. 
>  
> Then from  /etc/selinux/refpolicy/src/policy/policy/flask directory i
> m editing the security_classes and access_vectors files to add my new
> gconf class and permissions, then rebuilding and installing the
> policy.
> The whenever i m giving the class gconf in my module .te file and
> trying to install it i m getting this error.I guess i m missing
> something.PLease help.

I think we'd have to see your module .te file.
And maybe your modules.conf.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
