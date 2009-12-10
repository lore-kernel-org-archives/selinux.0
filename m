Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBAHBpDC017906
	for <selinux@tycho.nsa.gov>; Thu, 10 Dec 2009 12:11:51 -0500
Received: from cp-out11.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nBAHAfwl019206
	for <selinux@tycho.nsa.gov>; Thu, 10 Dec 2009 17:10:42 GMT
Subject: RE: How to use sepolgen VS. policygentool
From: Guido Trentalancia <guido@trentalancia.com>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D07B95030@de01exm68.ds.mot.com>
References: <81092d890910161715n12f3f523n16e02e08a3834b97@mail.gmail.com>
	 <4AD9AD06.9030309@redhat.com>
	 <81092d890910171117i71b699cete972bd9ae4b8834f@mail.gmail.com>
	 <1255960382.3099.5.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890910190949t537c00e8t3d7633c9f56a4800@mail.gmail.com>
	 <1255972389.3099.70.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890910191843q4aa20f6ep877f8e739b52ce43@mail.gmail.com>
	 <1256037508.4061.3.camel@moss-pluto.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D077A087F@de01exm68.ds.mot.com>
	 <1256633374.3090.13.camel@localhost>
	 <D06FE0A2807BC145B0D38744789D4F5D07909698@de01exm68.ds.mot.com>
	 <D06FE0A2807BC145B0D38744789D4F5D07B9501F@de01exm68.ds.mot.com>
	 <D06FE0A2807BC145B0D38744789D4F5D07B95030@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Thu, 10 Dec 2009 18:11:44 +0100
Message-Id: <1260465104.2868.11.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

You can compile the policy module as follows in two steps:

checkmodule -M -m mymodule.te -o mymodule.mod
semodule_package -o mymodule.pp -m mymodule.mod

semodule_package also accepts the optional "-f" parameter for specifying
file contexts.

However, I recommend that you use the Makefile provided
in /usr/share/selinux/devel and /usr/share/selinux/include.

You don't specify which distribution you are using. Just refer to your
distribution packager for further information on how to get the full
SELinux development tree mentioned above.

I hope this helps (it should answer both of your messages).

Regards,

Guido

On Wed, 2009-12-09 at 21:50 -0500, Hasan Rezaul-CHR010 wrote:
> One more question...
> 
> Lets say I used audit2allow to create a custom policy as follows:
> 
>   cat deny.log | audit2allow -M test
>   -- this will create test.te, and test.pp for me
> 
> If I wanted to make additional modifications to test.te, how can I
> compile this new test.te to come up with the new test.pp ??
> 
> Note: I don't seem to have the  /usr/share/selinux/devel/Makefile  file
> present on my setup !?! Is there some alternative way to compile the
> *.te  files ??  Thanks.
> 
>  
> 
> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
> On Behalf Of Hasan Rezaul-CHR010
> Sent: Wednesday, December 09, 2009 8:18 PM
> To: Daniel J Walsh
> Cc: selinux@tycho.nsa.gov
> Subject: How to use sepolgen VS. policygentool
> 
>  
> Hi All,
> 
> I used to have the following SELinux related package versions on my
> Linux (2.6.18) system:
>  
> checkpolicy      - 1.33.1
> libselinux       - 2.0.13
> libsemanage      - 2.0.1
> libsepol         - 2.0.3
> libsetrans       - 0.1.18
> policycoreutils  - 2.0.16
>  
> On that machine, I used to use  /usr/share/selinux/devel/policygentool
> to create new custom policy templates, and modified them as necessary,
> and used to run
> 
>  make -f /usr/share/selinux/devel/Makefile  to compile my  custom.te
> policies to create custom.pp.
> 
> I now have upgraded to Linux 2.6.27 on a non-popular Linux distro, and
> as part of this upgrade, we also migrated to much newer versions of the
> SELinux packages. They are:
>  
>  checkpolicy-2.0.19
>  libselinux-2.0.85
>  libsemanage-2.0.33
>  libsepol-2.0.37
>  policycoreutils-2.0.69
>  sepolgen-1.0.17
> 
> My questions are :
> 
> 1. On this new system, I don't see policygentool anymore ! Infact, I am
> missing the whole  /usr/share/selinux/devel/* directory.  Can I install
> the  selinux-policy-devel  package on this machine ? If so, where should
> I get it from ? Is policygentool still supported ?
> 
> 2. I do see this new package "sepolgen", which I am guessing is the
> newer replacement ? I do see that sepolgen is infact installed on my
> system:
> 
> 	root@unknown:/root> rpm -q sepolgen
> 	sepolgen-1.0.17-1_WR3.0.2as.ppc_e500v2
> 	root@unknown:/root>
> 	root@unknown:/root> which sepolgen
> 	which: no sepolgen in
> (/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/root/bin)
> 	root@unknown:/root>
> 	root@unknown:/root>
> 	root@unknown:/root> cd /usr/lib/sepolgen/
> 	root@unknown:/usr/lib/sepolgen> ls
> 	perm_map
> 	root@unknown:/usr/lib/sepolgen>
> 
> How do I use this sepolgen thing ?  I thought I could run an sepolgen
> executable as follows: "sepolgen -t <program>"
> But I don't see where the sepolgen executable is ??? Do I need to
> install any other packages to use sepolgen ?
> 
> 3. Finally, it seems that sepolgen will create a template policy based
> on a particular process, e.g. /usr/bin/ssh
> 
>    What if I wanted to write more generic policy for restricting selinux
> users. For example:
> 
>    neverallow user_t etc_t:file write;
>    neverallow user_t bin_t:file write;
>    neverallow user_t proc_t:file write;
>    neverallow staff_t bin_t:file write;
>    :
>    :
> 
>    what <program_name> should I supply in the sepolgen command, to
> create a custom policy template for this purpose ?
> 
> 
> Thanks in advance for all your help  :-)
>    
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with the words "unsubscribe selinux" without quotes as the message.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
