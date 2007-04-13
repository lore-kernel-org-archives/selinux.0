Message-ID: <461F9EC8.9030705@redhat.com>
Date: Fri, 13 Apr 2007 11:16:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: Additional swig interfaces for selinux
References: <461E91D0.8010107@redhat.com> <1176473943.3986.227.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1176473943.3986.227.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-04-12 at 16:08 -0400, Daniel J Walsh wrote:
>   
>> Also removed access checks since they don't currently work.
>> plain text document attachment (diff)
>> diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig.i libselinux-2.0.12/src/selinuxswig.i
>> --- nsalibselinux/src/selinuxswig.i	2007-04-12 16:02:48.000000000 -0400
>> +++ libselinux-2.0.12/src/selinuxswig.i	2007-04-12 12:39:51.000000000 -0400
>> @@ -44,6 +44,8 @@
>>  
>>  extern int is_selinux_enabled(void);
>>  extern int is_selinux_mls_enabled(void);
>> +extern void freecon(security_context_t con);
>> +extern void freeconary(security_context_t * con);
>>  extern int getcon(security_context_t *con);
>>  extern int setcon(security_context_t con);
>>  extern int getpidcon(int pid, security_context_t *con);
>> @@ -90,6 +92,11 @@
>>  			mode_t mode,
>>  			security_context_t *con);
>>  
>> +extern int matchpathcon_init_prefix(const char *path,
>> +				    const char *prefix);
>> +extern void matchpathcon_fini(void);
>> +
>> +
>>  extern int matchmediacon(const char *media,
>>  		 security_context_t *con);
>>  
>> @@ -106,6 +113,7 @@
>>  extern const char *selinux_homedir_context_path(void);
>>  extern const char *selinux_media_context_path(void);
>>  extern const char *selinux_contexts_path(void);
>> +extern const char *selinux_securetty_types_path(void);
>>  extern const char *selinux_booleans_path(void);
>>  extern const char *selinux_customizable_types_path(void);
>>  extern const char *selinux_users_path(void);
>> @@ -113,8 +121,11 @@
>>  extern const char *selinux_translations_path(void);
>>  extern const char *selinux_netfilter_context_path(void);
>>  extern const char *selinux_path(void);
>> -extern int selinux_check_passwd_access(access_vector_t requested);
>> -extern int checkPasswdAccess(access_vector_t requested);
>> +#extern int selinux_check_passwd_access(access_vector_t requested);
>> +#extern int checkPasswdAccess(access_vector_t requested);
>> +
>> +extern int selinux_check_securetty_context(security_context_t tty_context);
>> +void set_selinuxmnt(char *mnt);
>>  
>>  // This tells SWIG to treat char ** as a special case
>>  %typemap(python,in) char ** {
>> @@ -164,3 +175,7 @@
>>  }
>>  extern int selinux_getpolicytype(char **enforce);
>>  extern int getseuserbyname(const char *linuxuser, char **seuser, char **level);
>> +
>> +int selinux_file_context_cmp(const security_context_t a, const security_context_t b);
>> +int selinux_file_context_verify(const char *path, mode_t mode);
>> +int selinux_lsetfilecon_default(const char *path);
>>     
>
> Why do we need to duplicate definitions in the swig file from the C
> headers?  Seems divergent from the swig interface files for libsemanage,
> which merely %include's the main C headers in semanageswig.i and defines
> the typemaps in semanageswig_python.i.  Any reason to not do the same
> for libselinux?
>
>   
Mainly trying to avoid interfaces we do not want to support, or that 
just do not work.  Not ideal.

semanage has a lot more complicated interfaces than selinux has and 
unless someone else wants to go through the process of porting them... 

Now if swig has a include < >  except these interfaces ...
THat would be ideal.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
