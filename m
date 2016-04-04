Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u34JFmu8029056
 for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2016 15:15:48 -0400
Received: by mail-lb0-f176.google.com with SMTP id u8so175751681lbk.0
 for <selinux@tycho.nsa.gov>; Mon, 04 Apr 2016 12:15:43 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id r8sm30601867wjz.34.2016.04.04.12.15.41
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Mon, 04 Apr 2016 12:15:41 -0700 (PDT)
Subject: Re: On Fedora 24 I am seeing something strange with CIL
To: selinux@tycho.nsa.gov
References: <56FA96D5.4010806@redhat.com> <56FAC2BB.1070202@redhat.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <5702BD5D.50104@gmail.com>
Date: Mon, 4 Apr 2016 21:15:41 +0200
MIME-Version: 1.0
In-Reply-To: <56FAC2BB.1070202@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 03/29/2016 08:00 PM, Daniel J Walsh wrote:
> I investigated this a little further.
> 

manage_chr_files_pattern(svirt_sandbox_domain, svirt_sandbox_file_t,
svirt_sandbox_file_t)

define(`manage_chr_files_pattern',`
	allow $1 self:capability mknod;
	allow $1 $2:dir rw_dir_perms;
	allow $1 $3:chr_file manage_chr_file_perms;
')





> If I write a policy file like
> 
> =============================================== 
> policy_module(container, 1.0) gen_require(` attribute
> svirt_sandbox_domain; ')
> 
> type foobar_t; domain_type(foobar_t) typeattribute foobar_t
> svirt_sandbox_domain; 
> ===============================================
> 
> I get
> 
> 
> sesearch -A -s foobar_t  | grep capa allow foobar_t foobar_t :
> capability mknod ;
> 
> If I remove the typeattribute line foobar_t no longer has mknod.
> 
> I think this is a compiler problem.
> 
> On 03/29/2016 10:53 AM, Daniel J Walsh wrote:
>> When I compile and install this policy
>> 
>> --------------------------------------------------------------- #
>> cat /tmp/container.te policy_module(container, 1.0)
>> 
>> virt_sandbox_domain_template(container)
>> 
>> ---------------------------------------------------------------- 
>> I end up with mknod capability.
>> 
>> sesearch -A -s container_t -t container_t  -c capability Found 1
>> semantic av rules: allow container_t container_t : capability
>> mknod ;
>> 
>> But I didn't add mknod to the policy.
>> 
>> grep mknod tmp/container.tmp class capability { chown
>> dac_override dac_read_search fowner fsetid kill setgid setuid
>> setpcap linux_immutable net_bind_service net_broadcast net_admin
>> net_raw ipc_lock ipc_owner sys_module sys_rawio sys_chroot
>> sys_ptrace sys_pacct sys_admin sys_boot sys_nice sys_resource
>> sys_time sys_tty_config mknod lease audit_write audit_control
>> setfcap };
>> 
>> Any ideas?
> 
> _______________________________________________ Selinux mailing
> list Selinux@tycho.nsa.gov To unsubscribe, send email to
> Selinux-leave@tycho.nsa.gov. To get help, send an email containing
> "help" to Selinux-request@tycho.nsa.gov.


- -- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXAr1YAAoJECV0jlU3+Udp15kL/igUkHF8kUkSzGaEVnFbArtR
l63tgknNlnzoRF+s0bjSFYuYBRTefQpa/G23j/sIEQmKvVkRz8DlGQERqtSpPLZ2
sRNRlA3UA3vLqhk+RhGwxoEjdm8/MA/weU9VGhSHWsd0XrhYtOnI3metotgm422Q
YuQEtib+YQ/ldnEZ/2987DJy6Pg3leOBMn1JE+e7v3mFZDyzEfYI6IGR6VR+WEau
MooO6slYI7ftac4YnqzvUdTeANhYG4h2wfNA0qVxNVty4jS4mT3uCOhu/UmssnX/
fMviLYA2YJAkg0g6rvUnJJqFe0uCHMiVsMDwmR03I324BakxWCDpqnRhj5vxmYfx
ZW8gh3Xg+ZPyVoC5njgm9KkD0/6pgzwGEB3ayBIVgIVi8sVsNvzhJM2dILphT46K
OhFcSWX98xQY4G5P3/vOXx86nN4leP+Uw25eyZbStOFNscBK2LnZArQq65y4i6he
Qqv4V6xwCBRT+3u8VbjtgGzByeKEvkWvk7GMC17tgA==
=28BA
-----END PGP SIGNATURE-----
