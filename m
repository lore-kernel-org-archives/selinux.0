Subject: Re: Policy mods in last nights refpolicy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Ivan Gyurdiev <ivg2@cornell.edu>,
   SELinux-dev@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <437A8394.9030507@redhat.com>
References: <437907D7.8090002@cornell.edu>
	 <1132054159.5415.282.camel@moss-spartans.epoch.ncsc.mil>
	 <1132055891.5415.305.camel@moss-spartans.epoch.ncsc.mil>
	 <4379E4D1.2010900@redhat.com>
	 <1132063930.5415.364.camel@moss-spartans.epoch.ncsc.mil>
	 <4379EFBE.8070202@redhat.com> <1132069967.24234.159.camel@sgc>
	 <437A8394.9030507@redhat.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 09:38:44 -0500
Message-Id: <1132151924.7259.15.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-15 at 19:55 -0500, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Tue, 2005-11-15 at 09:25 -0500, Daniel J Walsh wrote:
> > I'm not clear on the rules you added to auth_use_nsswitch():
> >   
> >> --- nsaserefpolicy/policy/modules/system/authlogin.if	2005-11-14 18:24:06.000000000 -0500
> >> +++ serefpolicy-2.0.1/policy/modules/system/authlogin.if	2005-11-15 09:19:21.000000000 -0500
> >> @@ -931,6 +931,9 @@
> >>  	optional_policy(`samba.te',`
> >>  		samba_connect_winbind($1)
> >>  	')
> >> +	allow $1 var_auth_t:dir r_dir_perms;
> >> +	allow $1 var_auth_t:file create_file_perms;
> >> +
> >>  ')
> >>  
> >>  ########################################
> >>     
> >
> > Is this really supposed to be create_file_perms?  It seems like it
> > should just be r_file_perms since the dir access is r_dir_perms.  The
> > interface also needs a gen_require() since it not explicitly refers to
> > types.
> >   
> No apps need to be able to create and delete files in this directory.  
> This pam applet keeps track
> of failed logins or something like that.

In that case, it sounds like these additions need to be an interface by
themselves since not all users of nsswitch users do authentication.
Also the dir perms should be rw_dir_perms.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
