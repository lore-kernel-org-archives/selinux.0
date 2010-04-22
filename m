Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3MJH273008289
	for <selinux@tycho.nsa.gov>; Thu, 22 Apr 2010 15:17:02 -0400
Received: from mail-gy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3MJI1Cx002387
	for <selinux@tycho.nsa.gov>; Thu, 22 Apr 2010 19:18:01 GMT
Received: by gyg8 with SMTP id 8so5004222gyg.12
        for <selinux@tycho.nsa.gov>; Thu, 22 Apr 2010 12:17:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <q2s10143821004220729z2e39b1fdqe16997df0cee0574@mail.gmail.com>
References: <4BCC69C0.5040502@redhat.com>
	 <t2s10143821004190853r1a114b33q7c9416e43b8b5433@mail.gmail.com>
	 <l2s10143821004200737t683832efu28214c95b3e156c@mail.gmail.com>
	 <4BCF05D3.5090700@redhat.com>
	 <u2q10143821004211853jea20406bz355fc111cd449c47@mail.gmail.com>
	 <4BD0513C.40403@redhat.com>
	 <q2s10143821004220729z2e39b1fdqe16997df0cee0574@mail.gmail.com>
Date: Thu, 22 Apr 2010 15:16:58 -0400
Message-ID: <w2q10143821004221216j96faf709w8b702c67835197d6@mail.gmail.com>
Subject: Re: refpolicy is missing on lots of hits with audit2allow -R.
From: Karl MacMillan <kmacmillan@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 22, 2010 at 10:29 AM, Karl MacMillan <kmacmillan@tresys.com> wrote:
> On Thu, Apr 22, 2010 at 9:38 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>>
>> I have not fully examined this patch but I don't believe it will do what
>> I need.
>>
>> If I define an interface that ends up looking like this:
>>
>>
>> [InterfaceVector files_read_etc_files $1:source ]
>> $1,configfile,dir,ioctl,search,read,lock,open,getattr
>> $1,configfile,file,read,lock,getattr,open,ioctl
>> $1,configfile,lnk_file,read,getattr
>>
>>
>> And have and avc that looks like this:
>>
>> node=(removed) type=AVC msg=audit(1271587735.632:422): avc:  denied  {
>> getattr } for  pid=13239 comm="openvpn"
>> path="/home/bbaetz/.pki/vpn01_cacert.pem" dev=dm-3 ino=565334
>> scontext=system_u:system_r:openvpn_t:s0
>> tcontext=unconfined_u:object_r:etc_t:s0 tclass=file
>>
>>
>> This will never match.
>>
>> What we need is a way to expand out configfile into etc_t, or to realize
>> that etc_t is a configfile.
>>
>> The tool you added does not do the equivalent of
>>
>> seinfo -aconfigfile -x
>
> No, it doesn't do that yet, but I'll get to that soon. Now that I have
> the infrastructure for digging through the binary policy for attribute
> information it won't be too hard.
>

So it wasn't hard - I built a version that gets all of the attributes
out of the binary policy and expands them in the interfaces. Running
your denial now gives:

#============= openvpn_t ==============
# audit(1271587735.632:422):
#  scontext="system_u:system_r:openvpn_t:s0"
tcontext="unconfined_u:object_r:etc_t:s0"
#  class="file" perms="getattr"
#  comm="openvpn" exe="" path=""
#  message=" node=(removed) type=AVC msg=audit(1271587735.632:422): avc:  denied
#   { getattr } for  pid=13239 comm="openvpn"
#   path="/home/bbaetz/.pki/vpn01_cacert.pem" dev=dm-3 ino=565334
#   scontext=system_u:system_r:openvpn_t:s0
#   tcontext=unconfined_u:object_r:etc_t:s0 tclass=file  "
# Interface options:
#   automount_exec_config(openvpn_t) # [51]
#   files_exec_etc_files(openvpn_t) # [51]
#   files_delete_etc_files(openvpn_t) # [118]
#   files_relabel_etc_files(openvpn_t) # [136]
#   files_rw_etc_files(openvpn_t) # [161]
#   files_manage_etc_files(openvpn_t) # [179]
#   files_read_etc_files(openvpn_t) # [1702]
#   auth_use_nsswitch(openvpn_t) # [2893]
#   auth_login_pgm_domain(openvpn_t) # [32016]
#   seutil_semanage_policy(openvpn_t) # [41089]
#   portage_compile_domain(openvpn_t) # [59755]
automount_exec_config(openvpn_t)

I was surprised by the 1702 distance for files_read_etc_files, but
because of calling files_read_config_files and the configfile
attribute this interface now allows access to ~60 additional types. So
the distance calculation here is right I think (Chris mentioned that
the upstream refpol does not have this interface call in
files_read_config_files).

So I'm at a loss for what to do here. Adding the attribute expansion
for rules makes audit2allow _very_ slow and it seems that it will only
allow us to match very broad interfaces. I'm not convinced we really
want that. Eventually it might be nice to notice that we got denials
for many types and coalesce those into one broad interface call, but
that will be hard (I do some of that already but this case would be
harder) and doesn't seem worth it.

What do you think? Any chance you can just revert your change to
files_read_etc_files?

Karl

> Karl
>
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v2.0.14 (GNU/Linux)
>> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>>
>> iEYEARECAAYFAkvQUTwACgkQrlYvE4MpobMfWwCfbg6t/396jHWHCpasqosqf8Mw
>> 7qkAoNiXMi8+RK5/4mBu8WbnGLvxlb7+
>> =EDEY
>> -----END PGP SIGNATURE-----
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
>>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
