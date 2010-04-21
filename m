Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3LE48td006573
	for <selinux@tycho.nsa.gov>; Wed, 21 Apr 2010 10:04:08 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3LE3Zip019264
	for <selinux@tycho.nsa.gov>; Wed, 21 Apr 2010 14:03:36 GMT
Message-ID: <4BCF05D3.5090700@redhat.com>
Date: Wed, 21 Apr 2010 10:04:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: refpolicy is missing on lots of hits with audit2allow -R.
References: <4BCC69C0.5040502@redhat.com>	 <t2s10143821004190853r1a114b33q7c9416e43b8b5433@mail.gmail.com> <l2s10143821004200737t683832efu28214c95b3e156c@mail.gmail.com>
In-Reply-To: <l2s10143821004200737t683832efu28214c95b3e156c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/20/2010 10:37 AM, Karl MacMillan wrote:
> On Mon, Apr 19, 2010 at 11:53 AM, Karl MacMillan
> <karlwmacmillan@gmail.com> wrote:
>> On Mon, Apr 19, 2010 at 10:33 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>>>
>>> If you look at the interface userdom_read_home_certs.
>>>
>>> [InterfaceVector userdom_read_home_certs $1:source ]
>>> $1,home_cert_t,file,read,lock,getattr,open,ioctl
>>> $1,home_cert_t,dir,ioctl,search,read,lock,open,getattr
>>> $1,home_cert_t,lnk_file,read,getattr
>>> $1,home_root_t,dir,getattr,open,search
>>> $1,home_root_t,lnk_file,read,getattr
>>> $1,user_home_dir_t,dir,getattr,open,search
>>> $1,user_home_dir_t,lnk_file,read,getattr
>>>
>>> A domain that is allowed to search the homedir is always going to
>>> generate an AVC that is a long way off.
>>>
>>
>> Seems to me that the problem is that the read / getattr on
>> user_home_dir_t directories and files is adding too much distance.
>>
> 
> I looked at this a bit more - there are a few interesting issues:
> 
> 1. The open permissions have not been added to the perm_map file
> (patch attached to fix that). When there is no perm map then we weight
> the permission at 5 and assume read and write. Since we heavily
> penalize providing a write interface for a read access request, this
> causes the return of a large distance (as I believe that it should).
> I'd like to find a long term home for the perm map file that increases
> it's likelihood of being updated with new permissions (Chris - what do
> you think of including this with reference policy?).
> 
> 2. As I mentioned, the weighting on things like reading a symlink or
> directory contents is fairly high. For this use I don't think that's
> appropriate - the attached perm map patch also reduces these pretty
> drastically.
> 
> 3. The bulk of the rest of the distance comes from the unrelated
> type/object access. We get access to 4 type/object class pairs that
> aren't requested. Unfortunately there is no tracking of the notion of
> related access or scaling of the type penalty based upon how minor the
> related access is. Perhaps we should scale the type penalty with the
> permission weighting?
> 
> 4. The final issue is that this interface is a bit broad for the
> requested access - requesting getattr for the cert files and getting
> read is a pretty significant bump. Once you resolve the perm_map issue
> then the distance is just over the threshold - which is about where I
> was aiming with this algorithm (go me). Now, the reality is likely
> that a read would come right after this getattr - if that had have
> been in the audit log all would be fine. Having said that, I'm not
> against making the threshold a little higher to return these (another
> patch attached).
> 
> Long term, I wonder if we should return interfaces above the threshold
> but commented out with a note explaining that the interface, while
> providing the requested access, is potentially dangerously broad. Dan,
> any chance you want to add that feature?
> 
> Karl
> 
>>> I thing we should either remove the bastards and just add all as childs,
>>> or recode it like the attachment.
>>>
>>
>> I'm against removing the threshold altogether - if we do that then
>> we'll get a match for almost everything including completely wrong
>> interfaces. Can we start with tweaking either the perm weights or the
>> distance calculation? For example, what happens when you drop the
>> weight for dir read down to 5 or 1 and similar for lnk_file (they are
>> both 10 right now)? After that we might need to tweak the threshold.
>>
>> Also - I've been hacking on a patch to add in attribute access to the
>> interface vectors. Any idea how much help we would get from that?
>>
>> Karl
>>
>>> -----BEGIN PGP SIGNATURE-----
>>> Version: GnuPG v2.0.14 (GNU/Linux)
>>> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>>>
>>> iEYEARECAAYFAkvMacAACgkQrlYvE4MpobNeAgCfcoVssEQJ8mfZT/aBvAt0z7+3
>>> CoMAnR1bOcXk7x/jIZ+0i2Kc/faUJAVk
>>> =Uuf7
>>> -----END PGP SIGNATURE-----
>>>
>>
Ok that works, but If we move to a more general case. or openvn_t
getattr on etc_t

#============= openvpn_t ==============
# src="openvpn_t" tgt="etc_t" class="file", perms="getattr"
# comm="openvpn" exe="" path=""
# Interface options:
#   automount_exec_config(openvpn_t) # [51]
#   files_exec_etc_files(openvpn_t) # [51]
#   files_delete_etc_files(openvpn_t) # [118]
#   files_relabel_etc_files(openvpn_t) # [136]
#   files_rw_etc_files(openvpn_t) # [161]
#   files_read_etc_files(openvpn_t) # [171]
#   files_manage_etc_files(openvpn_t) # [179]
#   auth_use_nsswitch(openvpn_t) # [1342]
#   seutil_semanage_policy(openvpn_t) # [3489]
#   auth_login_pgm_domain(openvpn_t) # [3717]
#   portage_compile_domain(openvpn_t) # [4004]

I would have expected files_read_etc_files(openvpn_t)  to be the
closest/best match.

The tool is getting confused by attributes.  Since attributes are not
currently interpretable, they should be eliminated from the calculation.
Best way to do this is just eliminate any types that don't end in a _t.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvPBdMACgkQrlYvE4MpobP9IQCePlmwSbiO94NTCiu1mHwUzdkI
8YsAn3tlgDQljeLLLhJmMaUGRHFkrBVp
=8OfI
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
