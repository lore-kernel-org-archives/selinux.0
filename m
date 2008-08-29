Subject: Re: semodule -i error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: shaunak saha <reach.shaunak@gmail.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <d74d42a50808290743y15209c53jda0f3cf1b2805d23@mail.gmail.com>
References: <d74d42a50808290333u4e73b7abo1a24762b74e47659@mail.gmail.com>
	 <1220016138.5708.289.camel@moss-spartans.epoch.ncsc.mil>
	 <d74d42a50808290648m6a5ff5fch67e9b374ed57ecd3@mail.gmail.com>
	 <1220018351.5708.297.camel@moss-spartans.epoch.ncsc.mil>
	 <d74d42a50808290714l53ed8c4et2f51ddde98681124@mail.gmail.com>
	 <1220019856.5708.304.camel@moss-spartans.epoch.ncsc.mil>
	 <d74d42a50808290743y15209c53jda0f3cf1b2805d23@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 29 Aug 2008 10:53:04 -0400
Message-Id: <1220021584.5708.307.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-08-29 at 20:13 +0530, shaunak saha wrote:
> >Hmmm...ok, can you also show the tmp/dbus_exe.tmp file that was
> >generated from your .te file during the build?
>  
> Attached is the dbus_exe.tmp file 
> 
> >You add the definitions to the policy/flask files and rebuild the
> entire
> >refpolicy.
>  
> I did that i guess.I added this
>  
> class gconf
> {
>         set_value
>         set_scheme
>         unset_value
>         remove_dir
> }
>  
> in /etc/selinux/refpolicy/src/policy/policy/flask/access_vectors file
> 
> and 
>  
> class gconf
>  
> in /etc/selinux/refpolicy/src/policy/policy/flask/security_classes
> file
> and then did a 
>  
> make load
> from /etc/selinux/refpolicy/src/policy directory.
> 
> Is this the right thing?or i m missing something?

And did you then set SELINUXTYPE=refpolicy in /etc/selinux/config,
touch /.autorelabel and reboot the system to bring it up under your
newly built policy rather than the targeted one?

Or alternatively when you ran semodule, did you specify -s refpolicy to
cause it act on refpolicy rather than the default targeted policy?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
