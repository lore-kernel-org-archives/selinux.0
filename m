Subject: RE: How to use sepolgen VS. policygentool
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
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
Date: Thu, 10 Dec 2009 11:02:38 -0500
Message-Id: <1260460958.3025.30.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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

Same sequence of commands that are run by audit2allow or the Makefile:
checkmodule -M -m test.te -o test.mod
semodule_package -o test.pp -m test.mod

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
