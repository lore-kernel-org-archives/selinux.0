Subject: RE: Policy writing philosophy...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D07CF68FD@de01exm68.ds.mot.com>
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
	 <1260460494.3025.22.camel@moss-pluto.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D07CF6350@de01exm68.ds.mot.com>
	 <1260975517.19290.7.camel@moss-pluto.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D07CF68FD@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Wed, 16 Dec 2009 10:47:57 -0500
Message-Id: <1260978477.19290.34.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-12-16 at 10:30 -0500, Hasan Rezaul-CHR010 wrote:
> Thanks as always Stephen. 
> 
> >> Also can SELinux mappings be created for a Unix Group, as opposed to 
> >> mapping to individual Linux Users ?
> 
> > Yes - just use %groupname in the seusers configuration.
> 
> Would you kindly give me some more details / examples, or point me to a
> URL or document that I can learn more about how to achieve this ?
> Thanks again.

groupadd research
useradd -g research johndoe
semanage login -a -s user_u %research
ssh -l johndoe localhost
id

> Also, I have a Fedora 12 machine now. I was wondering, where can I get
> all the  ***.te  files for the corresponding ***.pp files that exist ? 

yumdownloader --source selinux-policy
rpm -ivh selinux-policy*.src.rpm

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
