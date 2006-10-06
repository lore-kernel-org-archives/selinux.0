Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96JJmXn005630
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 15:19:48 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96JIZQW014935
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 19:18:35 GMT
Message-ID: <4526AC45.5090104@redhat.com>
Date: Fri, 06 Oct 2006 15:19:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: MMCS patch against subversion policy
References: <200610062109.51031.russell@coker.com.au>
In-Reply-To: <200610062109.51031.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> I have attached two patches for MMCS support.
>
> The first one is fairly uncontroversial, it's been discussed before and no-one 
> had any major problem with it.  As the default range in targeted and strict 
> policies is SystemLow-SystemHigh it won't affect users with a default 
> configuration.  What it does do is prevent processes (apart from certain 
> system domains) from lowering their low level or writing to files with a 
> lower level.  This makes MCS a fully mandatory policy.  For example if your 
> low level is s0:c1 then you can not write to a file that lacks the c1 
> category or spawn, or debug a process that can do so.
>
>   
This is fine.  The only problem we have seen with MMCS is when an 
administrator logs in at SystemLow and su to root they have to be able 
to see and kill processes running at different levels.
They should also be able to run the debugger against them.    If I am 
not using MCS I should not be hindered by it.
> It had been previously noted that genhomedircon would not set a level other 
> than s0 for the default home directory labelling, this was the only objection 
> in the past to merging my MMCS policy patch.  I have attached a patch 
> (against the Rawhide version of policycoreutils) for genhomedircon to make it 
> use the default level (as specified in the -L parameter to semanage) for 
> labeling the home directories.  I believe that this is needed for ideal MLS 
> support regardless of MMCS.
>
>   
This seems fine.
> The controversial patch is relabelling certain files under /selinux to 
> SystemHigh (it also needs restorecon run from /etc/rc.sysinit).  I know that 
> Steve won't like this and anticipate that others might not either.  That's 
> OK, the other two patches are useful without it.
>
>   
Not sure why you want to do this?
> ------------------------------------------------------------------------
>
> diff -ru policy/mcs policy.mmcs/mcs
> --- policy/mcs	2006-10-05 22:31:12.000000000 +1000
> +++ policy.mmcs/mcs	2006-10-06 14:24:18.000000000 +1000
> @@ -66,16 +66,21 @@
>  #
>  # Note that getattr on files is always permitted.
>  #
> -mlsconstrain file { write setattr append unlink link rename ioctl lock execute relabelfrom }
> +mlsconstrain file { ioctl lock execute relabelfrom }
>  	( h1 dom h2 );
>  
> +mlsconstrain file { write setattr append unlink link rename }
> +	(( h1 dom h2 ) and ((l1 domby l2) or (t2 == mcstrustedobject)));
> +
>  mlsconstrain dir { create getattr setattr read write link unlink rename search add_name remove_name reparent rmdir lock ioctl }
>  	(( h1 dom h2 ) or ( t2 == domain ) or ( t1 == mlsfileread ));
>  
>  # New filesystem object labels must be dominated by the relabeling subject
>  # clearance, also the objects are single-level.
> +# Also file can not be created at a lower level than the process.
>  mlsconstrain file { create relabelto }
> -	(( h1 dom h2 ) and ( l2 eq h2 ));
> +	(( l2 eq h2 ) and ( h1 dom h2 ) and
> +	((l1 domby h2) or (t2 == mcstrustedobject)));
>  
>  # At this time we do not restrict "ps" type operations via MCS.  This
>  # will probably change in future.
> @@ -86,14 +91,15 @@
>  mlsconstrain { dir lnk_file chr_file blk_file sock_file fifo_file } { relabelfrom }
>  	( h1 dom h2 );
>  
> +# not mandatory at this time
>  mlsconstrain { dir lnk_file chr_file blk_file sock_file fifo_file } { create relabelto }
>  	(( h1 dom h2 ) and ( l2 eq h2 ));
>  
>  mlsconstrain process { transition dyntransition }
> -	(( h1 dom h2 ) or ( t1 == mcssetcats ));
> +	((( h1 dom h2 ) and ((l1 domby l2) or (t1 == mcssetlow))) or ( t1 == mcssetcats ));
>  
>  mlsconstrain process { ptrace }
> -	(( h1 dom h2) or ( t1 == mcsptraceall ));
> +	((( h1 dom h2) and (l1 domby l2)) or ( t1 == mcsptraceall ));
>  
>  mlsconstrain process { sigkill sigstop }
>  	(( h1 dom h2 ) or ( t1 == mcskillall ));
> diff -ru policy/modules/kernel/selinux.if policy.mmcs/modules/kernel/selinux.if
> --- policy/modules/kernel/selinux.if	2006-10-05 22:30:53.000000000 +1000
> +++ policy.mmcs/modules/kernel/selinux.if	2006-10-06 16:21:13.000000000 +1000
> @@ -417,3 +417,33 @@
>  
>  	typeattribute $1 selinux_unconfined_type;
>  ')
> +
> +########################################
> +## <summary>
> +##     Allow caller to relabel files under /selinux
> +## </summary>
> +## <desc>
> +##     <p>
> +##     Allow caller to relabel files under /selinux
> +##     </p>
> +##     <p>
> +##     Since this is a security event, this action is
> +##     always audited.
> +##     </p>
> +## </desc>
> +## <param name="domain">
> +##     <summary>
> +##     The process type allowed to set the Boolean.
> +##     </summary>
> +## </param>
> +#
> +interface(`relabel_security_files',`
> +       gen_require(`
> +               type security_t;
> +       ')
> +
> +       allow $1 security_t:dir search;
> +       allow $1 security_t:dir { getattr search read };
> +       allow $1 security_t:file { getattr relabelfrom relabelto };
> +')
> +
> diff -ru policy/modules/system/selinuxutil.te policy.mmcs/modules/system/selinuxutil.te
> --- policy/modules/system/selinuxutil.te	2006-10-05 22:31:10.000000000 +1000
> +++ policy.mmcs/modules/system/selinuxutil.te	2006-10-06 15:48:58.000000000 +1000
> @@ -82,7 +82,12 @@
>  type restorecon_t, can_relabelto_binary_policy;
>  type restorecon_exec_t;
>  domain_obj_id_change_exemption(restorecon_t)
> +relabel_security_files(restorecon_t)
> +ifdef(`enable_mcs',`
> +init_ranged_system_domain(restorecon_t,restorecon_exec_t,s0 - mcs_systemhigh)
> +', `
>  init_system_domain(restorecon_t,restorecon_exec_t)
> +')
>  role system_r types restorecon_t;
>  
>  type restorecond_t;
> @@ -122,6 +127,7 @@
>  
>  type setfiles_t, can_relabelto_binary_policy;
>  domain_obj_id_change_exemption(setfiles_t)
> +relabel_security_files(setfiles_t)
>  domain_type(setfiles_t)
>  role system_r types setfiles_t;
>  
>   
> ------------------------------------------------------------------------
>
> diff -ru policy/modules/kernel/files.fc policy.mmcs/modules/kernel/files.fc
> --- policy/modules/kernel/files.fc	2006-10-05 22:30:53.000000000 +1000
> +++ policy.mmcs/modules/kernel/files.fc	2006-10-06 15:23:51.000000000 +1000
> @@ -159,6 +159,10 @@
>  # /selinux
>  #
>  /selinux		-d	<<none>>
> +/selinux/commit_pending_bools -- gen_context(system_u:object_r:security_t,s0,c0.c1023)
> +/selinux/booleans/.*   --      gen_context(system_u:object_r:security_t,s0,c0.c1023)
> +/selinux/enforce       --      gen_context(system_u:object_r:security_t,s0,c0.c1023)
> +/selinux/load          --      gen_context(system_u:object_r:security_t,s0,c0.c1023) 
>  /selinux/.*			<<none>>
>  
>  #
> diff -ru policy/modules/kernel/mcs.if policy.mmcs/modules/kernel/mcs.if
> --- policy/modules/kernel/mcs.if	2006-10-05 22:30:53.000000000 +1000
> +++ policy.mmcs/modules/kernel/mcs.if	2006-10-06 09:48:10.000000000 +1000
> @@ -62,3 +62,52 @@
>  
>  	typeattribute $1 mcssetcats;
>  ')
> +
> +########################################
> +## <summary>
> +##     Make specified domain MCS trusted
> +##     for setting the low level of its range for the processes it executes,
> +##      IE MCS will not be mandatory for it.
> +## </summary>
> +## <param name="domain">
> +##     <summary>
> +##     Domain target for user exemption.
> +##     </summary>
> +## </param>
> +#
> +interface(`mcs_process_set_low',`
> +       gen_require(`
> +               attribute mcssetlow;
> +       ')
> +
> +       typeattribute $1 mcssetlow;
> +')
> +
> +#######################################
> +## <summary>
> +##      Make specified object MCS trusted.
> +## </summary>
> +## <desc>
> +##      <p>
> +##      Make specified object MCS trusted.  This
> +##      allows all levels to read and write the
> +##      object.
> +##      </p>
> +##      <p>
> +##      This currently only applies to filesystem
> +##      objects, for example, files and directories.
> +##      </p>
> +## </desc>
> +## <param name="domain">
> +##      <summary>
> +##      The type of the object.
> +##      </summary>
> +## </param>
> +#
> +interface(`mcs_trusted_object',`
> +        gen_require(`
> +                attribute mcstrustedobject;
> +        ')
> +
> +        typeattribute $1 mcstrustedobject;
> +')
> diff -ru policy/modules/kernel/mcs.te policy.mmcs/modules/kernel/mcs.te
> --- policy/modules/kernel/mcs.te	2006-10-05 22:30:53.000000000 +1000
> +++ policy.mmcs/modules/kernel/mcs.te	2006-10-06 09:48:17.000000000 +1000
> @@ -6,6 +6,14 @@
>  # Declarations
>  #
>  
> +# process may kill all processes (init)
>  attribute mcskillall;
> +# process may ptrace processes at higher or lower MCS levels
>  attribute mcsptraceall;
> +# process may run a child in any level
>  attribute mcssetcats;
> +# process may set the low level for a child with no restriction
> +attribute mcssetlow;
> +# object may be accessed by any process at a higher level
> +attribute mcstrustedobject;
> +
> diff -ru policy/modules/kernel/selinux.te policy.mmcs/modules/kernel/selinux.te
> --- policy/modules/kernel/selinux.te	2006-10-05 22:30:53.000000000 +1000
> +++ policy.mmcs/modules/kernel/selinux.te	2006-10-06 09:48:37.000000000 +1000
> @@ -19,6 +19,7 @@
>  type security_t;
>  fs_type(security_t)
>  mls_trusted_object(security_t)
> +mcs_trusted_object(security_t)
>  sid security gen_context(system_u:object_r:security_t,mls_systemhigh)
>  genfscon selinuxfs / gen_context(system_u:object_r:security_t,s0)
>  
>   
> ------------------------------------------------------------------------
>
> --- /root/genhomedircon	2006-10-06 20:49:11.000000000 +1000
> +++ /usr/sbin/genhomedircon	2006-10-06 21:05:22.000000000 +1000
> @@ -183,6 +183,12 @@
>  				return semanage_user_get_prefix(user)
>  		return name
>  
> +	def get_default_level(self, name):
> +		for user in self.ulist:
> +			if semanage_user_get_name(user) == name:
> +				return semanage_user_get_mlslevel(user)
> +		return name
> +
>  	def get_old_prefix(self, user):
>  		rc = grep(self.selinuxdir+self.type+"/users/system.users", "^user %s" % user)
>  		if rc == "":					    
> @@ -196,7 +202,7 @@
>  			prefix = prefix[:-2]
>  		return prefix
>  		
> -	def adduser(self, udict, user, seuser, prefix):
> +	def adduser(self, udict, user, seuser, prefix, level):
>  		if seuser == "user_u" or user == "__default__" or user == "system_u":
>  			return
>  		# !!! chooses first prefix in the list to use in the file context !!!
> @@ -218,6 +224,7 @@
>  		prefs["seuser"] = seuser
>  		prefs["prefix"] = prefix
>  		prefs["home"] = home
> +		prefs["level"] = level
>  		udict[user] = prefs
>  		
>  	def getUsers(self):
> @@ -227,7 +234,7 @@
>  			for seuser in list:
>  				user = []
>  				seusername = semanage_seuser_get_sename(seuser)
> -				self.adduser(udict, semanage_seuser_get_name(seuser), seusername, self.get_default_prefix(seusername))
> +				self.adduser(udict, semanage_seuser_get_name(seuser), seusername, self.get_default_prefix(seusername), self.get_default_level(seusername))
>  				
>  		else:
>  			try:
> @@ -249,7 +256,7 @@
>  
>  		return udict
>  
> -	def getHomeDirContext(self, user, seuser, home, prefix):
> +	def getHomeDirContext(self, user, seuser, home, prefix, level):
>  		ret = "\n\n#\n# Home Context for user %s\n#\n\n" % user
>  		fd = open(self.getHomeDirTemplate(), 'r')
>  		for i in  fd.readlines():
> @@ -257,11 +264,12 @@
>  				i = i.replace("HOME_DIR", home)
>  				i = i.replace("ROLE", prefix)
>  				i = i.replace("system_u", seuser)
> +				i = i.replace(":s0", ":" + level)
>  				ret = ret+i
>  		fd.close()
>  		return ret
>  
> -	def getUserContext(self, user, sel_user, prefix):
> +	def getUserContext(self, user, sel_user, prefix, level):
>  		ret = ""
>  		fd = open(self.getHomeDirTemplate(), 'r')
>  		for i in  fd.readlines():
> @@ -269,6 +277,7 @@
>  				i = i.replace("USER", user)
>  				i = i.replace("ROLE", prefix)
>  				i = i.replace("system_u", sel_user)
> +				i = i.replace(":s0", ":" + level)
>  				ret = ret+i
>  		fd.close()
>  		return ret
> @@ -278,8 +287,8 @@
>  		ret = ""
>  		# Fill in HOME and prefix for users that are defined
>  		for u in users.keys():
> -			ret += self.getHomeDirContext (u, users[u]["seuser"], users[u]["home"], users[u]["prefix"])
> -			ret += self.getUserContext (u, users[u]["seuser"], users[u]["prefix"])
> +			ret += self.getHomeDirContext (u, users[u]["seuser"], users[u]["home"], users[u]["prefix"], users[u]["level"])
> +			ret += self.getUserContext (u, users[u]["seuser"], users[u]["prefix"], users[u]["level"])
>  		return ret+"\n"
>  
>  	def checkExists(self, home):
> @@ -326,9 +335,9 @@
>  	def genoutput(self):
>  		ret = self.heading()
>  		for h in self.getHomeDirs():
> -			ret += self.getHomeDirContext ("user_u", "user_u" , h+'/[^/]*', "user")
> +			ret += self.getHomeDirContext ("user_u", "user_u" , h+'/[^/]*', "user", "s0")
>  			ret += self.getHomeRootContext(h)
> -		ret += self.getUserContext(".*", "user_u", "user") + "\n"
> +		ret += self.getUserContext(".*", "user_u", "user", "s0") + "\n"
>  		ret += self.genHomeDirContext()
>  		return ret
>  
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
