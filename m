MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Policy writing philosophy...
Date: Wed, 16 Dec 2009 10:30:26 -0500
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D07CF68FD@de01exm68.ds.mot.com>
In-Reply-To: <1260975517.19290.7.camel@moss-pluto.epoch.ncsc.mil>
References: <81092d890910161715n12f3f523n16e02e08a3834b97@mail.gmail.com> <4AD9AD06.9030309@redhat.com> <81092d890910171117i71b699cete972bd9ae4b8834f@mail.gmail.com> <1255960382.3099.5.camel@moss-pluto.epoch.ncsc.mil> <81092d890910190949t537c00e8t3d7633c9f56a4800@mail.gmail.com> <1255972389.3099.70.camel@moss-pluto.epoch.ncsc.mil> <81092d890910191843q4aa20f6ep877f8e739b52ce43@mail.gmail.com> <1256037508.4061.3.camel@moss-pluto.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D077A087F@de01exm68.ds.mot.com> <1256633374.3090.13.camel@localhost> <D06FE0A2807BC145B0D38744789D4F5D07909698@de01exm68.ds.mot.com> <D06FE0A2807BC145B0D38744789D4F5D07B9501F@de01exm68.ds.mot.com> <1260460494.3025.22.camel@moss-pluto.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D07CF6350@de01exm68.ds.mot.com> <1260975517.19290.7.camel@moss-pluto.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Daniel J Walsh" <dwalsh@redhat.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks as always Stephen. 

>> Also can SELinux mappings be created for a Unix Group, as opposed to 
>> mapping to individual Linux Users ?

> Yes - just use %groupname in the seusers configuration.

Would you kindly give me some more details / examples, or point me to a
URL or document that I can learn more about how to achieve this ?
Thanks again.

Also, I have a Fedora 12 machine now. I was wondering, where can I get
all the  ***.te  files for the corresponding ***.pp files that exist ? 

Thanks again.


-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Wednesday, December 16, 2009 8:59 AM
To: Hasan Rezaul-CHR010
Cc: selinux@tycho.nsa.gov
Subject: Re: Policy writing philosophy...

On Tue, 2009-12-15 at 12:43 -0500, Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> I have Linux 2.6.27 on a non-popular Linux distro, and I have the 
> following SELinux package versions :
>   
> >  checkpolicy-2.0.19
> >  libselinux-2.0.85
> >  libsemanage-2.0.33
> >  libsepol-2.0.37
> >  policycoreutils-2.0.69
> >  sepolgen-1.0.17
> 
> I know SELinux's is governing framework is that by default everything 
> is DENIED, except all accesses that are explicitly allowed in the
policy...
> 
> Is there anyway whatsoever to reverse that philosophy ?  In other 
> words, is it possible to configure things and write policy in a way
such that:
> 
> Only explicit things are disallowed... So whenever no explicit policy 
> exists for an access request it is actually ALLOWED. This way, if I 
> write a new task or process, I don't have to write new policy for it 
> to allow all the things it needs. By default things will just be 
> allowed, unless some of those accesses have been explicitly disallowed

> in policy ?
> 
> My guess is that this CANT be done... But thought I would ask anyway ?

Not from a mechanism point of view, no.  But from a policy point of
view, you can achieve your end by initially declaring a domain as an
unconfined domain and then removing rules, or by declaring a domain as a
permissive domain and generating rules for it via audit2allow.

> Also can SELinux mappings be created for a Unix Group, as opposed to 
> mapping to individual Linux Users ?

Yes - just use %groupname in the seusers configuration.

--
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
