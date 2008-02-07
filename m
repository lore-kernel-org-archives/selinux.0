Message-ID: <47AB824A.3080309@manicmethod.com>
Date: Thu, 07 Feb 2008 17:12:26 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, "Todd C. Miller" <tmiller@tresys.com>,
        David Quigley <dpquigl@tycho.nsa.gov>,
        Chad Sellers <csellers@tresys.com>
Subject: Re: [patch] libselinux: provide more error reporting on load	policy
 failures
References: <1202412666.27371.294.camel@moss-spartans.epoch.ncsc.mil>	 <47AB6733.9060002@manicmethod.com> <1202418570.27371.296.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1202418570.27371.296.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2008-02-07 at 15:16 -0500, Joshua Brindle wrote:
>   
>> Stephen Smalley wrote:
>>     
>>> Provide more error reporting on load policy failures.  John Reiser has
>>> previously encountered failures where it would have helped to see the
>>> policy file, and David Quigley recently noted that no output is provided
>>> by init in the case where policy cannot be loaded and the system is in
>>> permissive mode.
>>>
>>> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
>>>
>>>   
>>>       
>> Looks good to me. Do you think there is any value to add extra 
>> information as well as error/warnings? One example would be which file 
>> was ultimately loaded and what version it was downgraded to (if it was).
>>     
>
> Possibly, although then we get into whether it should be stderr, syslog,
> or audit.  Also, we have to be careful - it seems that the mere presence
> of any new output (e.g. the information handle_unknown message from the
> kernel at policy load) is enough to raise alarms with some users.
>
>   

Understood. I only asked because of the setools thread where there are 
apparently 2 cases to cover, make it just work for most people and to be 
very specific for analysts. If an analyst (or Dan) can't easily get 
policy load information from a target machine (where it was loaded from, 
if it was downgraded) it may be more error prone to analyze the policy 
or troubleshoot an error

The handle_unknown thing was probably startling because it isn't very 
obvious what it means. Policy loaded from <path> [downgraded to version 
<ver>]. hopefully wouldn't raise alarms (though the downgraded part may).

It was just a thought...

>> Acked-by: Joshua Brindle <method@manicmethod.com>
>>
>>     
>>> ---
>>>
>>>  libselinux/src/load_policy.c |   31 ++++++++++++++++++++++++++-----
>>>  1 file changed, 26 insertions(+), 5 deletions(-)
>>>
>>> Index: trunk/libselinux/src/load_policy.c
>>> ===================================================================
>>> --- trunk/libselinux/src/load_policy.c	(revision 2792)
>>> +++ trunk/libselinux/src/load_policy.c	(working copy)
>>> @@ -46,7 +46,7 @@
>>>  int selinux_mkload_policy(int preservebools)
>>>  {	
>>>  	int kernvers = security_policyvers();
>>> -	int vers = kernvers, minvers = DEFAULT_POLICY_VERSION;
>>> +	int maxvers = kernvers, minvers = DEFAULT_POLICY_VERSION, vers;
>>>  	int setlocaldefs = load_setlocaldefs;
>>>  	char path[PATH_MAX], **names;
>>>  	struct stat sb;
>>> @@ -128,7 +128,7 @@
>>>  #endif
>>>  
>>>  	if (usesepol) {
>>> -		vers = vers_max();
>>> +		maxvers = vers_max();
>>>  		minvers = vers_min();
>>>  	}
>>>  
>>> @@ -157,6 +157,7 @@
>>>  	if (preservebools && uname(&uts) == 0 && strverscmp(uts.release, "2.6.22") >= 0)
>>>  		preservebools = 0;
>>>  
>>> +	vers = maxvers;
>>>        search:
>>>  	snprintf(path, sizeof(path), "%s.%d",
>>>  		 selinux_binary_policy_path(), vers);
>>> @@ -168,11 +169,19 @@
>>>  			 selinux_binary_policy_path(), vers);
>>>  		fd = open(path, O_RDONLY);
>>>  	}
>>> -	if (fd < 0)
>>> +	if (fd < 0) {
>>> +		fprintf(stderr,
>>> +			"SELinux:  Could not open policy file <= %s.%d:  %s\n",
>>> +			selinux_binary_policy_path(), maxvers, strerror(errno));
>>>  		goto dlclose;
>>> +	}
>>>  
>>> -	if (fstat(fd, &sb) < 0)
>>> +	if (fstat(fd, &sb) < 0) {
>>> +		fprintf(stderr,
>>> +			"SELinux:  Could not stat policy file %s:  %s\n",
>>> +			path, strerror(errno));
>>>  		goto close;
>>> +	}
>>>  
>>>  	prot = PROT_READ;
>>>  	if (setlocaldefs || preservebools)
>>> @@ -180,8 +189,12 @@
>>>  
>>>  	size = sb.st_size;
>>>  	data = map = mmap(NULL, size, prot, MAP_PRIVATE, fd, 0);
>>> -	if (map == MAP_FAILED)
>>> +	if (map == MAP_FAILED) {
>>> +		fprintf(stderr,
>>> +			"SELinux:  Could not map policy file %s:  %s\n",
>>> +			path, strerror(errno));
>>>  		goto close;
>>> +	}
>>>  
>>>  	if (vers > kernvers && usesepol) {
>>>  		/* Need to downgrade to kernel-supported version. */
>>> @@ -200,6 +213,9 @@
>>>  		if (policydb_set_vers(policydb, kernvers) ||
>>>  		    policydb_to_image(NULL, policydb, &data, &size)) {
>>>  			/* Downgrade failed, keep searching. */
>>> +			fprintf(stderr,
>>> +				"SELinux:  Could not downgrade policy file %s, searching for an older version.\n",
>>> +				path);
>>>  			policy_file_free(pf);
>>>  			policydb_free(policydb);
>>>  			munmap(map, sb.st_size);
>>> @@ -254,6 +270,11 @@
>>>  
>>>  
>>>  	rc = security_load_policy(data, size);
>>> +	
>>> +	if (rc)
>>> +		fprintf(stderr,
>>> +			"SELinux:  Could not load policy file %s:  %s\n",
>>> +			path, strerror(errno));
>>>  
>>>        unmap:
>>>  	if (data != map)
>>>
>>>
>>>   
>>>       



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
