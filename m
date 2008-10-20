Message-ID: <48FCDE95.9070705@redhat.com>
Date: Mon, 20 Oct 2008 15:40:05 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, jmorris@namei.org,
        sgrubb@redhat.com
Subject: Re: [PATCH] selinux: new permission for chmod on suid or sgid files
References: <1224258034.3189.25.camel@paris-laptop>	 <1224262355.19562.78.camel@moss-spartans.epoch.ncsc.mil>	 <1224264294.19562.92.camel@moss-spartans.epoch.ncsc.mil>	 <48F8DCE3.3000805@redhat.com>	 <1224269637.19562.115.camel@moss-spartans.epoch.ncsc.mil>	 <48F8FAA1.7080405@redhat.com> <1224505589.7428.3.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1224505589.7428.3.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Fri, 2008-10-17 at 16:50 -0400, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Stephen Smalley wrote:
>>> On Fri, 2008-10-17 at 14:43 -0400, Daniel J Walsh wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA1
>>>>
>>>> Stephen Smalley wrote:
>>>>> On Fri, 2008-10-17 at 12:52 -0400, Stephen Smalley wrote:
>>>>>> On Fri, 2008-10-17 at 11:40 -0400, Eric Paris wrote:
>>>>>>> This patch adds a new permission, setsuid, to the file class.  This
>>>>>>> permission is checked any time a file has its attributes modified
>>>>>>> (setattr) and the setuid or setgid bits are involved.  The purpose for
>>>>>>> this change is to further allow selinux to confine administrative
>>>>>>> duties.  The example explains when the permission is needed and when it
>>>>>>> is not:
>>>>>>>
>>>>>>> Start with a file with chmod 0644.
>>>>>>> chmod u+s  (0644 -> 4644) { setattr setsuid }
>>>>>>> chmod u-r  (4644 -> 4244) { setattr setsuid }
>>>>>>> chmod u-s  (4244 -> 0244) { setattr setsuid }
>>>>>>> chmod u+r  (0244 -> 0644) { setattr }
>>>>>>>
>>>>>>> If either the starting or the final attributes will have the setuid or
>>>>>>> setgid bits set you need this permission.
>>>>>> I'd like to understand better how this would be used.
>>>>>>
>>>>>> Suppose that I want to control the ability to create/modify privileged
>>>>>> executables on the system.  Given that SELinux already controls
>>>>>> capability usage, I can already do that by labeling privileged
>>>>>> executable with an appropriate type and controlling the ability to
>>>>>> create/modify/relabelto that type, without being concerned about the
>>>>>> suid bit.  Why do I need this check?  And if I need this check, then
>>>>>> don't I need a similar check on setting/clearing file capabilities on a
>>>>>> given file?
>>>>> One other tidbit: I don't believe that this check will get applied in
>>>>> the case where a suid/sgid binary is overwritten and the suid/sgid bits
>>>>> are forcibly cleared (ATTR_FORCE), as the selinux_inode_setattr() hook
>>>>> returns immediately in that case as it must not fail.
>>>>>
>>>>>> Last concern I have is with this check not being adequately granular
>>>>>> since it is a single check for setting or clearing the suid or sgid bit
>>>>>> of a file owned by any user, whereas it seems more security-relevant to
>>>>>> be setting the suid bit on a root-owned executable than to be clearing
>>>>>> it or to be setting the suid bit on a sds-owned executable.  I'm not
>>>>>> sure how to write a useful policy that lets users do things that are
>>>>>> harmless or of no interest while still enforcing a useful goal.
>>>>>>
>>>>>>> Signed-off-by: Eric Paris <eparis@redhat.com>
>>>>>>>
>>>>>>> ---
>>>>>>>
>>>>>>>  security/selinux/hooks.c                     |   22 ++++++++++++++++++++--
>>>>>>>  security/selinux/include/av_perm_to_string.h |    1 +
>>>>>>>  security/selinux/include/av_permissions.h    |    1 +
>>>>>>>  security/selinux/include/class_to_string.h   |    4 ++++
>>>>>>>  security/selinux/include/security.h          |    2 ++
>>>>>>>  security/selinux/selinuxfs.c                 |    3 ++-
>>>>>>>  security/selinux/ss/services.c               |    3 +++
>>>>>>>  7 files changed, 33 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>>>>>> index 576e511..58af86a 100644
>>>>>>> --- a/security/selinux/hooks.c
>>>>>>> +++ b/security/selinux/hooks.c
>>>>>>> @@ -2659,6 +2659,8 @@ static int selinux_inode_permission(struct inode *inode, int mask)
>>>>>>>  static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
>>>>>>>  {
>>>>>>>  	int rc;
>>>>>>> +	unsigned int mode = dentry->d_inode->i_mode;
>>>>>>> +	u32 av = 0;
>>>>>>>  
>>>>>>>  	rc = secondary_ops->inode_setattr(dentry, iattr);
>>>>>>>  	if (rc)
>>>>>>> @@ -2667,11 +2669,27 @@ static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
>>>>>>>  	if (iattr->ia_valid & ATTR_FORCE)
>>>>>>>  		return 0;
>>>>>>>  
>>>>>>> +	/*
>>>>>>> +	 * are we changing mode?
>>>>>>> +	 * does policy support seperate suid/sgid checks?
>>>>>>> +	 * is this a regular file?
>>>>>>> +	 * do either the old inode->i_mode or the new iattr->i_mode have the
>>>>>>> +	 * suid/sgid bits set?
>>>>>>> +	 */
>>>>>>> +	if ((iattr->ia_valid & ATTR_MODE) &&
>>>>>>> +	    selinux_policycap_setsuidperm &&
>>>>>>> +	    (S_ISREG(mode)) &&
>>>>>>> +	    ((iattr->ia_mode & (S_ISUID | S_ISGID)) ||
>>>>>>> +	     (mode & (S_ISUID | S_ISGID))))
>>>>>>> +			av |= FILE__SETSUID;
>>>>>>> +
>>>>>>>  	if (iattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID |
>>>>>>>  			       ATTR_ATIME_SET | ATTR_MTIME_SET))
>>>>>>> -		return dentry_has_perm(current, NULL, dentry, FILE__SETATTR);
>>>>>>> +		av |= FILE__SETATTR;
>>>>>>> +	else
>>>>>>> +		av = FILE__WRITE;
>>>>>>>  
>>>>>>> -	return dentry_has_perm(current, NULL, dentry, FILE__WRITE);
>>>>>>> +	return dentry_has_perm(current, NULL, dentry, av);
>>>>>>>  }
>>>>>>>  
>>>>>>>  static int selinux_inode_getattr(struct vfsmount *mnt, struct dentry *dentry)
>>>>>>> diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
>>>>>>> index 1223b4f..c6c5c0e 100644
>>>>>>> --- a/security/selinux/include/av_perm_to_string.h
>>>>>>> +++ b/security/selinux/include/av_perm_to_string.h
>>>>>>> @@ -19,6 +19,7 @@
>>>>>>>     S_(SECCLASS_FILE, FILE__ENTRYPOINT, "entrypoint")
>>>>>>>     S_(SECCLASS_FILE, FILE__EXECMOD, "execmod")
>>>>>>>     S_(SECCLASS_FILE, FILE__OPEN, "open")
>>>>>>> +   S_(SECCLASS_FILE, FILE__SETSUID, "setsuid")
>>>>>>>     S_(SECCLASS_CHR_FILE, CHR_FILE__EXECUTE_NO_TRANS, "execute_no_trans")
>>>>>>>     S_(SECCLASS_CHR_FILE, CHR_FILE__ENTRYPOINT, "entrypoint")
>>>>>>>     S_(SECCLASS_CHR_FILE, CHR_FILE__EXECMOD, "execmod")
>>>>>>> diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
>>>>>>> index c4c5116..cd6d566 100644
>>>>>>> --- a/security/selinux/include/av_permissions.h
>>>>>>> +++ b/security/selinux/include/av_permissions.h
>>>>>>> @@ -101,6 +101,7 @@
>>>>>>>  #define FILE__ENTRYPOINT                          0x00040000UL
>>>>>>>  #define FILE__EXECMOD                             0x00080000UL
>>>>>>>  #define FILE__OPEN                                0x00100000UL
>>>>>>> +#define FILE__SETSUID                             0x00200000UL
>>>>>>>  #define LNK_FILE__IOCTL                           0x00000001UL
>>>>>>>  #define LNK_FILE__READ                            0x00000002UL
>>>>>>>  #define LNK_FILE__WRITE                           0x00000004UL
>>>>>>> diff --git a/security/selinux/include/class_to_string.h b/security/selinux/include/class_to_string.h
>>>>>>> index bd813c3..0d11270 100644
>>>>>>> --- a/security/selinux/include/class_to_string.h
>>>>>>> +++ b/security/selinux/include/class_to_string.h
>>>>>>> @@ -72,3 +72,7 @@
>>>>>>>      S_(NULL)
>>>>>>>      S_("peer")
>>>>>>>      S_("capability2")
>>>>>>> +    S_(NULL)
>>>>>>> +    S_(NULL)
>>>>>>> +    S_(NULL)
>>>>>>> +    S_(NULL)
>>>>>>> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
>>>>>>> index 7244737..a604f05 100644
>>>>>>> --- a/security/selinux/include/security.h
>>>>>>> +++ b/security/selinux/include/security.h
>>>>>>> @@ -56,12 +56,14 @@ extern int selinux_mls_enabled;
>>>>>>>  enum {
>>>>>>>  	POLICYDB_CAPABILITY_NETPEER,
>>>>>>>  	POLICYDB_CAPABILITY_OPENPERM,
>>>>>>> +	POLICYDB_CAPABILITY_SETSUIDPERM,
>>>>>>>  	__POLICYDB_CAPABILITY_MAX
>>>>>>>  };
>>>>>>>  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
>>>>>>>  
>>>>>>>  extern int selinux_policycap_netpeer;
>>>>>>>  extern int selinux_policycap_openperm;
>>>>>>> +extern int selinux_policycap_setsuidperm;
>>>>>>>  
>>>>>>>  /*
>>>>>>>   * type_datum properties
>>>>>>> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
>>>>>>> index 69c9dcc..26ef62f 100644
>>>>>>> --- a/security/selinux/selinuxfs.c
>>>>>>> +++ b/security/selinux/selinuxfs.c
>>>>>>> @@ -42,7 +42,8 @@
>>>>>>>  /* Policy capability filenames */
>>>>>>>  static char *policycap_names[] = {
>>>>>>>  	"network_peer_controls",
>>>>>>> -	"open_perms"
>>>>>>> +	"open_perms",
>>>>>>> +	"setsuid_perms",
>>>>>>>  };
>>>>>>>  
>>>>>>>  unsigned int selinux_checkreqprot = CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
>>>>>>> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>>>>>>> index 343c8ab..9ecd8e7 100644
>>>>>>> --- a/security/selinux/ss/services.c
>>>>>>> +++ b/security/selinux/ss/services.c
>>>>>>> @@ -64,6 +64,7 @@ unsigned int policydb_loaded_version;
>>>>>>>  
>>>>>>>  int selinux_policycap_netpeer;
>>>>>>>  int selinux_policycap_openperm;
>>>>>>> +int selinux_policycap_setsuidperm;
>>>>>>>  
>>>>>>>  /*
>>>>>>>   * This is declared in avc.c
>>>>>>> @@ -1615,6 +1616,8 @@ static void security_load_policycaps(void)
>>>>>>>  						  POLICYDB_CAPABILITY_NETPEER);
>>>>>>>  	selinux_policycap_openperm = ebitmap_get_bit(&policydb.policycaps,
>>>>>>>  						  POLICYDB_CAPABILITY_OPENPERM);
>>>>>>> +	selinux_policycap_setsuidperm = ebitmap_get_bit(&policydb.policycaps,
>>>>>>> +						  POLICYDB_CAPABILITY_SETSUIDPERM);
>>>>>>>  }
>>>>>>>  
>>>>>>>  extern void selinux_complete_init(void);
>>>>>>>
>>>> The reason I asked for this is for the confined administrator user.
>>>>
>>>> Say I am webadmin of a system.  I can run sudo to become
>>>> webadm_r:webadmin_t as UID 0.  I now want to change the permissions on a
>>>> cgi script to be executable.  If I can change it to setuid, or setgid, I
>>>> might be able to find an alternate root to executing the app with raised
>>>> privs.
>>>>
>>>> I just see this as a risk, and I see little reason why a confined
>>>> administrator would even need to setuid/setgid an application.
>>> Well, as I noted when this came up as an RFC a year ago, the fact that
>>> they can create a setuid program doesn't mean that they can exercise any
>>> capabilities since we control that based on domain.  And rather than
>>> preventing them from setting the suid bit, it might be more useful to
>>> prevent them from executing a setuid program (regardless of who made it
>>> setuid) or letting it execute but not changing its uid in that case
>>> (just as we do under ptrace).
>>>
>>> http://marc.info/?l=selinux&m=119013530120434&w=2
>>>
>> Lets take another path to this.
>>
>> nsplugin executes programs that want to setattr to
>> /home/dwalsh/.recently-used.xbel
>>
>> Why I don't know.  But audit2allow tells me to add a rule
>>
>> allow nsplugin_t user_home_t:file setattr;
>>
>> Which I might just allow, since maybe changing the ownership on a file
>> is required.  (I am dont auditing it.)  If nsplugin_t was allowed
>> setattr, it could be used to chmod 4755 ~/myexe, and now another user on
>> the system would be able to run ~dwalsh/myexe as dwalsh.  (If they had
>> the same user type.)
> 
> Ok, so what you want to do is control the ability to create additional
> "entrypoints" into a user identity.  In which case you want to control
> the following actions:
> - making an executable suid (chmod with suid bit set),
> - adding further execute access to an existing suid executable (chmod +x
> of a suid executable _or_ modifying the ACL of a suid executable).
> 
> But I don't see the benefit to you of controlling the ability to clear
> the suid bit or modifying the rw mode bits on a suid executable (writing
> to a suid executable forcibly clears the suid bit, so you end up with a
> program that is no longer suid at all).  Using the same permission for
> all of the actions covered in Eric's patch just increases the likelihood
> that you'll have to grant it in some cases where you don't want to allow
> the particular two actions above.
> 
Fine, I don't care about this either.  So setting the setuid bit on
would be the only thing we watch.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkj83pUACgkQrlYvE4MpobNCngCfbIO9itGMvOEu/00rTZMEuPif
98sAniARbXki0BBJgTPRijUA3c46HamM
=4Cwo
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
