Message-ID: <452C1348.6050209@us.ibm.com>
Date: Tue, 10 Oct 2006 16:40:24 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/4] make newrole suid
References: <4526D531.1090409@us.ibm.com> <1160512048.3322.54.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1160512048.3322.54.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-10-06 at 17:14 -0500, Michael C Thompson wrote:
>> This is the 1st of 4 patches.
>> This patch applies against policycoreutils-1.30.30-1.
>>
>> Changes:
>>   * This patch breaks up the operations performed by newrole
>>     into functions. They are called in patch 2/4.
>>   * The following functions do not new functionality:
>>     - extract_pw_data
>>     - relabel_tty
>>     - restore_tty_label
>>     - parse_command_line_arguments
>>   * The following functions do add new functionality:
>>     - xsetenv
>>     - sanitize_environment
>>     - transition_to_caller_uid
>>     - set_signal_handles
>>
>> The new (and existing) functionality should be adequately documented in 
>> the code. If it is not clear, I consider that to be a failure of the 
>> code, and please let me know.
>>
>> Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>
> 
> diff -Naur policycoreutils-1.30.30/newrole/newrole.c policycoreutils-1.30.30.suid/newrole/newrole.c
> --- policycoreutils-1.30.30/newrole/newrole.c	2006-09-29 10:50:27.000000000 -0500
> +++ policycoreutils-1.30.30.suid/newrole/newrole.c	2006-10-06 16:58:06.000000000 -0500
> @@ -101,6 +101,25 @@
>  	return s2;
>  }
>  
> +/**
> + * Returns zero on success, non-zero otherwise
> + */
> +static int xsetenv(char const *name, char const *val)
> +{
> +	size_t namelen = strlen(name);
> +	size_t vallen = strlen(val);
> +	char *string = malloc(namelen + 1 + vallen + 1);
> +
> +	if (!string)
> +		return -1;
> +	strcpy(string, name);
> +	string[namelen] = '=';
> +	strcpy(string + namelen + 1, val);
> +	if (putenv (string) != 0)
> +		return -1;
> 
> Why not just use setenv(name, val, 1)?  Then you also don't have to
> worry about integer overflow in your string allocation.

I was following the source for su. That seems like a much better 
approach though. I will make this change.

> @@ -332,6 +351,115 @@
>  	return found;
>  }
>  
> +/**
> + * Determine the Linux user identity to re-authenticate.
> + * If supported and set, use the login uid, as this should be more stable.
> + * Otherwise, use the real uid.
> + *
> + * This function assigns malloc'd memory into the pw_copy struct.
> + * Returns zero on success, non-zero otherwise
> + */
> +int extract_pw_data(struct passwd *pw_copy)
> +{
> +	uid_t uid;
> +	struct passwd *pw;
> +
> +#ifdef USE_AUDIT
> +	uid = audit_getloginuid();
> +	if (uid == (uid_t) - 1)
> +		uid = getuid();
> +#else
> +	uid = getuid();
> +#endif
> +
> +	setpwent();
> +	pw = getpwuid(uid);
> +	endpwent();
> +	if (!(pw && pw->pw_name && pw->pw_name[0] && pw->pw_shell
> +	      && pw->pw_shell[0] && pw->pw_dir && pw->pw_dir[0])) {
> 
> This seems unnecessary, unless the interface can actually return NULL
> pointers for the individual fields (vs. empty strings, which are
> possible) and unless later code cannot correctly handle the legal cases
> that might be returned by the interface.  Otherwise, we end up
> cluttering the code with lots of tests that might hide a real bug.

We definately need to ensure that pw_name and pw_shell are valid. 
pw_name is used in pam_start and pw_shell is needed for executing the 
shell. It is possible to remove the pw_dir check, although it is used to 
set the HOME environment variable... not sure if that is important enough?

<snip>
> +#ifdef NAMESPACE_PRIV
> +/**
> + * This function will set the uid values to be that of caller's uid, and
> + * will drop any privilages which maybe have been raised.
> + */
> +static int transition_to_caller_uid()
> +{
> +	uid_t uid = getuid();
> +
> +	if (setresuid(uid, uid, uid)) {
> +		fprintf(stderr, _("Error changing uid, aborting.\n"));
> +		return -1;
> +	}
> 
> Note that this will not drop privileges if KEEPCAPS has been set to 1.
> So you might want to explicitly call prctl in this function just prior
> to calling setresuid to make it clear that you are dropping capabilities
> as well.

Right, KEEPCAPS is set to be 0 in all call paths in patch 3. Should it 
still be added / moved to this point for the sake of clarity? or is the 
current form (post 3rd patch) acceptable?

Thanks taking the time to review,
Mike



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
