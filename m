MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Policy writing philosophy...
Date: Tue, 15 Dec 2009 12:43:37 -0500
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D07CF6350@de01exm68.ds.mot.com>
In-Reply-To: <1260460494.3025.22.camel@moss-pluto.epoch.ncsc.mil>
References: <81092d890910161715n12f3f523n16e02e08a3834b97@mail.gmail.com> <4AD9AD06.9030309@redhat.com> <81092d890910171117i71b699cete972bd9ae4b8834f@mail.gmail.com> <1255960382.3099.5.camel@moss-pluto.epoch.ncsc.mil> <81092d890910190949t537c00e8t3d7633c9f56a4800@mail.gmail.com> <1255972389.3099.70.camel@moss-pluto.epoch.ncsc.mil> <81092d890910191843q4aa20f6ep877f8e739b52ce43@mail.gmail.com> <1256037508.4061.3.camel@moss-pluto.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D077A087F@de01exm68.ds.mot.com> <1256633374.3090.13.camel@localhost> <D06FE0A2807BC145B0D38744789D4F5D07909698@de01exm68.ds.mot.com> <D06FE0A2807BC145B0D38744789D4F5D07B9501F@de01exm68.ds.mot.com> <1260460494.3025.22.camel@moss-pluto.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

I have Linux 2.6.27 on a non-popular Linux distro, and I have the
following SELinux package versions :
  
>  checkpolicy-2.0.19
>  libselinux-2.0.85
>  libsemanage-2.0.33
>  libsepol-2.0.37
>  policycoreutils-2.0.69
>  sepolgen-1.0.17

I know SELinux's is governing framework is that by default everything is
DENIED, except all accesses that are explicitly allowed in the policy...

Is there anyway whatsoever to reverse that philosophy ?  In other words,
is it possible to configure things and write policy in a way such that:

Only explicit things are disallowed... So whenever no explicit policy
exists for an access request it is actually ALLOWED. This way, if I
write a new task or process, I don't have to write new policy for it to
allow all the things it needs. By default things will just be allowed,
unless some of those accesses have been explicitly disallowed in policy
?

My guess is that this CANT be done... But thought I would ask anyway ?

Also can SELinux mappings be created for a Unix Group, as opposed to
mapping to individual Linux Users ?

Thanks.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
