Subject: Re: semodule -i error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: shaunak saha <reach.shaunak@gmail.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <d74d42a50808290714l53ed8c4et2f51ddde98681124@mail.gmail.com>
References: <d74d42a50808290333u4e73b7abo1a24762b74e47659@mail.gmail.com>
	 <1220016138.5708.289.camel@moss-spartans.epoch.ncsc.mil>
	 <d74d42a50808290648m6a5ff5fch67e9b374ed57ecd3@mail.gmail.com>
	 <1220018351.5708.297.camel@moss-spartans.epoch.ncsc.mil>
	 <d74d42a50808290714l53ed8c4et2f51ddde98681124@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 29 Aug 2008 10:24:16 -0400
Message-Id: <1220019856.5708.304.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-08-29 at 19:44 +0530, shaunak saha wrote:
> 
> >Wait - the error message you displayed listed
> "dbus_rpc_example_server"
> >as the module name, not dbus_exe - so you aren't showing the module
> that
> >is triggering the error.
>  
> yes.They are different modules but they are giving the same error.This
> one gives:
>  
> [root@localhost shaunak]# semodule -i dbus_exe.pp 
> libsepol.print_missing_requirements: dbus_exe's global requirements
> were not
> met: type/attribute resmgrd_var_run_t
> libsemanage.semanage_link_sandbox: Link packages failed
> semodule:  Failed 

Hmmm...ok, can you also show the tmp/dbus_exe.tmp file that was
generated from your .te file during the build?

> I have given the .te file for this as this is comparitively smaller
> than the other module.I m sorry for that confusion.
>  
> > And I'm not sure what the purpose of this module
>  
> This is a sample program i have written to learn the policy writing.It
> calls some dbus api's.It is working fine with the dbus.But now i want
> to test gconf.I m working on making gconf-daemon an userspace object
> manager.For this i wanted to add gconf class and test it.
>  
> >Just in case it isn't clear though - you cannot add new classes/perms
> in
> >a non-base module; they have to be defined in the base module.  A
> >non-base module can only require them, not declare them.
>  
> How to declare them in base module?Sorry for the ignorance but dont
> really know how to do this

You add the definitions to the policy/flask files and rebuild the entire
refpolicy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
