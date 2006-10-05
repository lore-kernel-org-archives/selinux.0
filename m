Message-ID: <45251C15.6020506@redhat.com>
Date: Thu, 05 Oct 2006 10:52:05 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        jdesai@us.ibm.com
Subject: Re: [RFC PATCH] newrole suid breakdown
References: <452432FA.1060009@us.ibm.com> <45250F35.6030204@redhat.com> <452519BC.1060204@us.ibm.com>
In-Reply-To: <452519BC.1060204@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael C Thompson wrote:
> Daniel J Walsh wrote:
>> Michael C Thompson wrote:
>>> Hey all,
>>>
>>> So, in light of the concerns regarding making newrole suid, I have 
>>> taken some steps to break up the functionality of newrole. I am 
>>> sending this out for some feedback on this approach, I think it is a 
>>> step in the right direction. This note has become rather lengthy, 
>>> but seeing as we're working on avoiding a "root hole", I hope people 
>>> can take the time to look at it :)
>>>
>>> This patch applies against the policycoreutils-1.30.30-1 package.
>>>
>>> Changes from 1.30.30-1:
>>> Makefile
>>>  * Took Janak's patch, and broke LSPP_PRIV into two
>>>    subparts, AUDIT_LOG_PRIV and NAMESPACE_PRIV. newrole
>>>    can be built with none, either or both sets of functionality.
>>>  * Included the newrole-lspp.pamd install step from Janak's patch
>>>
>>> newrole-lspp.pamd
>>>  * Taken straight from Janak's patch
>>>
>>> newrole.c
>>>  * NAMESPACE_PRIV requires USE_PAM
>>>  * Updated authenticate_via_pam as per Janak's patch
>>>  * drop_capabilities has three flavors: AUDIT_LOG_PRIV, NAMESPACE_PRIV
>>>    and neither. AUDIT_LOG_PRIV is a subset of the capabilities of
>>>    NAMESPACE_PRIV
>>>  * drop_capabilities has been restructured to return an int
>>>  * New function transition_to_caller_uid()
>>>  * pam usage changes as per Janak's patch
>>>  * change_pns_effective_caps() (from Janak's patches) is removed in
>>>    favor of retaining euid of 0 until shell exec
>>>
>>> A few comments:
>>> Most of this work is based off of Janak's patches, so there will be 
>>> a decent amount of familiar code. The most notable difference is the 
>>> existence of two separate drop_capabilities() functions and 
>>> change_pns_effective_caps() has been removed. I added a new 
>>> drop_capabilities so that the capabilities needed to do only 
>>> auditing and handling namespaces are clearly differentiated.
>>>
>>> The new drop_capabilities retains in the EFFECTIVE set all of the 
>>> capabilities it will need to affect namespaces. I don't really see 
>>> the value gained from raising and lowering the capabilities 
>>> mid-execution, if someone is able to attack newrole and execute 
>>> arbitrary code, they can simply raise those capabilities from the 
>>> PERMITTED set. If you would like this changed to be more paranoid, 
>>> let me know.
>>>
>>> The removal of change_pns_effective_caps() was done in favor of 
>>> maintaining the euid of 0 for nearly the lifetime of the 
>>> application, only switching to the caller uid before the shell exec. 
>>> This is functionally permissible since we retain CAP_DAC_OVERRIDE 
>>> (otherwise being euid 0 without this cap breaks opening the tty). 
>>> For the same reasons as above, I don't see the reason to be non-euid 
>>> 0 for the lifetime of the app since it is desired to be able to 
>>> change euid to 0 for the pam_namespace actions, and it should be 
>>> changed to the caller's uid prior to the exec.
>>>
>>>
>>> From what I have seen, the points of possible attack (i.e. input) to 
>>> newrole include:
>>> * command line options
>>> * reading the password from stdin
>>> * reading the contents of /etc/passwd and /etc/shell
>>>
>>> I doubt this is an exhaustive list. Since /etc/passwd and /etc/shell 
>>> are restricted to root-only write, I've discounted these. Since we 
>>> require PAM to do namespaces, which will cause PAM to handle the 
>>> password check, we should be able to defer any vulnerabilities to 
>>> PAM, and I would hope that PAM is secure.
>>>
>>> This leaves command line options. These are parsed with getopt_long, 
>>> and are currently passed into libselinux without any scrubbing. 
>>> Since SELinux doesn't apply a limit on the length of its context 
>>> strings, is there any checks that need to be done before handing 
>>> these strings into libselinux?
>>>
>>>
>>> The cleanup process for errors within newrole currently does not 
>>> make a call to pam_end (after pam_start). Is this an issue? There 
>>> are also other cases where cleanup isn't really handled as nicely as 
>>> it could. Since this is a user-space app, a lot of cleanup is 
>>> handled by the kernel, but I do have some patches that go a ways to 
>>> begin cleaning this sort of thing up. Are they desirable?
>>>
>>>
>>> I have tested all 4 ways of compiling newrole (no priv, 
>>> AUDIT_LOG_PRIV, NAMESPACE_PRIV, LSPP_PRIV (both)), and it functions 
>>> as expected. As for code quality and security, if this is to be 
>>> suid, I would like to see it be as clean and tight as possible :)
>>>
>> Does the code continue to work correctly if I compile in 
>> AUDIT_LOG_PRIV and NAMESPACE_PRIV but run it without the setuid bit 
>> and as a normal user.  IE, We want the option to only set this setuid 
>> when in an MLS environment.  This is not required for targeted or 
>> strict policy machines.
>
> What happens (currently), is it attempts to drop capabilities and if 
> it can't do that, newrole fails and exists. The reason I chose this 
> behavior is, as I figured, if you have compiled newrole with 
> AUDIT_LOG_PRIV or NAMESPACE_PRIV, you requiring that behaviour.
>
> It should be easy to change this behavior, as I expect RH will want a 
> single compiled binary that can do it all, right? :)
>
> Suggested patch attached. If you have a more elegant solution, feel 
> free to let me know.
>
> Thanks,
> Mike
>
>
> ------------------------------------------------------------------------
>
> diff -Naur policycoreutils-1.30.30.dev/newrole/newrole.c policycoreutils-1.30.30.dev.rh/newrole/newrole.c
> --- policycoreutils-1.30.30.dev/newrole/newrole.c	2006-10-04 17:01:17.000000000 -0500
> +++ policycoreutils-1.30.30.dev.rh/newrole/newrole.c	2006-10-05 09:39:14.000000000 -0500
> @@ -548,6 +548,7 @@
>  	uid_t uid;
>  	int fd;
>  	int enforcing;
> +	int ignore_privilage_actions = 0;
>  	sigset_t empty;
>  #ifdef USE_PAM
>  	int rc;			/* pam return code */
> @@ -562,8 +563,11 @@
>  	};
>  #endif
>  
> -	if (drop_capabilities())
> -		return -1;
> +	if (geteuid())
> +		ignore_privilage_actions = 1;
> +	else
> +		if (drop_capabilities())
> +			return -1;
>  
>   
I think this is all you need.  Audit can handle the fact that it can't 
send a message by sending it to /var/log/messages.  And if You use 
pam_namespace.so you should fail if you are not setuid and you are not root.
>  	/* Empty the signal mask in case someone is blocking a signal */
>  	sigemptyset(&empty);
> @@ -662,7 +666,9 @@
>  	if (role_s && !type_s) {
>  		if (get_default_type(role_s, &type_s)) {
>  			fprintf(stderr, _("Couldn't get default type.\n"));
> -			send_audit_message(0, old_context, new_context, ttyn);
> +			if (!ignore_privilage_actions)
> +				send_audit_message(0, old_context, new_context,
> +						   ttyn);
>  			exit(-1);
>  		}
>  #ifdef CANTSPELLGDB
> @@ -851,7 +857,8 @@
>  
>  	if (security_check_context(new_context) < 0) {
>  		fprintf(stderr, _("%s is not a valid context\n"), new_context);
> -		send_audit_message(0, old_context, new_context, ttyn);
> +		if (!ignore_privilage_actions)
> +			send_audit_message(0, old_context, new_context, ttyn);
>  		exit(-1);
>  	}
>  
> @@ -960,12 +967,15 @@
>  
>  #ifdef USE_PAM
>  #ifdef NAMESPACE_PRIV
> -		rc = pam_close_session(pam_handle,0);
> -		if(rc != PAM_SUCCESS) {
> -			fprintf(stderr, "pam_close_session failed with %s\n",
> -				pam_strerror(pam_handle, rc));
> -			pam_end(pam_handle, rc);
> -			exit(-1);
> +		if (!ignore_privilage_actions) {
> +			rc = pam_close_session(pam_handle,0);
> +			if(rc != PAM_SUCCESS) {
> +				fprintf(stderr,
> +					"pam_close_session failed with %s\n",
> +					pam_strerror(pam_handle, rc));
> +				pam_end(pam_handle, rc);
> +				exit(-1);
> +			}
>  		}
>  #endif
>  
> @@ -1026,21 +1036,24 @@
>  		exit(-1);
>  	}
>  #ifdef NAMESPACE_PRIV
> -	/* Ask PAM to setup session for user running this program */
> -	rc = pam_open_session(pam_handle,0);
> -	if(rc != PAM_SUCCESS) {
> -		fprintf(stderr, "pam_open_session failed with %s\n",
> -			pam_strerror(pam_handle, rc));
> -		exit(-1);
> +	if (!ignore_privilage_actions) {
> +		/* Ask PAM to setup session for user running this program */
> +		rc = pam_open_session(pam_handle,0);
> +		if(rc != PAM_SUCCESS) {
> +			fprintf(stderr, "pam_open_session failed with %s\n",
> +				pam_strerror(pam_handle, rc));
> +			exit(-1);
> +		}
>  	}
>  #endif
> -
> -	if (send_audit_message(1, old_context, new_context, ttyn))
> -		exit(-1);
> +	if (!ignore_privilage_actions)
> +		if (send_audit_message(1, old_context, new_context, ttyn))
> +			exit(-1);
>  	freecon(old_context);
>  #ifdef NAMESPACE_PRIV
> -	if (transition_to_caller_uid())
> -		exit(-1);
> +	if (!ignore_privilage_actions)
> +		if (transition_to_caller_uid())
> +			exit(-1);
>  #endif
>  	execv(pw->pw_shell, argv + optind - 1);
>  
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
