Subject: Re: Does the MLS range in modular file context have to be raw?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <79DD4F6A-4BD4-4FD7-BB00-C4B7705B4EF8@nall.com>
References: <79DD4F6A-4BD4-4FD7-BB00-C4B7705B4EF8@nall.com>
Content-Type: text/plain
Date: Mon, 30 Apr 2007 08:17:06 -0400
Message-Id: <1177935426.16232.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-04-29 at 09:48 -0500, Joe Nall wrote:
> In a modular policy context file
> 
> /var/opt/jcdx/ICM(/.*)?                 gen_context 
> (system_u:object_r:jcdx_icm_var_t,s15:c0.c1023)
> 
> works, but
> 
> /var/opt/jcdx/ICM(/.*)?                 gen_context 
> (system_u:object_r:jcdx_icm_var_t,SystemHigh)
> 
> does not with the following error during installation:
> 
> libsepol.mls_from_string: invalid MLS context SystemHigh
> libsepol.mls_from_string: could not construct mls context structure
> libsepol.context_from_record: could not create context structure
> libsepol.context_from_string: could not create context structure
> libsepol.sepol_context_to_sid: could not convert  
> system_u:object_r:jcdx_icm_var_t:SystemHigh to sid
> /etc/selinux/mls/contexts/files/file_contexts:  line 818 has invalid  
> context system_u:object_r:jcdx_icm_var_t:SystemHigh
> libsemanage.semanage_install_active: setfiles returned error code 1.
> /usr/sbin/semodule:  Failed!
> 
> In both cases the creation of the .pp file works.
> 
> This concerns me because we have a number of daemons that run at  
> labels other than SystemHigh. The raw context for these daemons must  
> be hardcoded in the policy developers environment, which presumes we  
> know the mapping on the target machine, which we don't.
> 
> We can work around this in the RPM spec file, creating the .fc files  
> on the fly using the setrans.conf of the target machine and compiling  
> during the installation, but this is complex and feels like we are  
> working around a bug.
> 
> How can I specify a file context with a human readable label in a  
> modular policy?

IIUC, that isn't specific to modular policy; the same would apply to
monolithic policy, and both setfiles and libselinux matchpathcon expect
file contexts to contain raw contexts.  

I think the error occurs upon the setfiles -c validation of the file
contexts against the policy file, and that checking needs to work on a
non-selinux build host or even on a selinux w/ different policy build
host, so it doesn't use anything from the base system, just the provided
file contexts and binary policy file.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
