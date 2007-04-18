Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3IK6mWe004680
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 16:06:48 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3IK6lOP015400
	for <selinux@tycho.nsa.gov>; Wed, 18 Apr 2007 20:06:47 GMT
Message-ID: <462679B8.7080600@hp.com>
Date: Wed, 18 Apr 2007 16:04:08 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: directory polyinstantiation failure
References: <cadfc0e40704171107l770c48cak16f504b6b0a0dcc0@mail.gmail.com>	 <46251650.7000509@us.ibm.com>	 <cadfc0e40704171223r5b566441p276426561ec21290@mail.gmail.com>	 <46252BB5.1070407@us.ibm.com> <cadfc0e40704180959i4aad6211r6b66d1433c69a1ee@mail.gmail.com>
In-Reply-To: <cadfc0e40704180959i4aad6211r6b66d1433c69a1ee@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> Here is the patch for to expand $HOME. However as I looked at the code
> I see the reason for behavior that had confused me partly because it
> isn't documented and partly because I don't think it is desired. I'd
> specified some directories to be polyinstantiated by level but then
> I'd see that they might also get polyinstantiated by user. The code as
> described in the following comment is overriding my specified method
> if getexeccon fails.
> /*
> * This function checks if the calling program has requested context
> * change by calling setexeccon(). If context change is not requested
> * then it does not make sense to polyinstantiate based on context.
> * The return value from this function is used when selecting the
> * polyinstantiation method. If context change is not requested then
> * the polyinstantiation method is set to USER, even if the configuration
> * file lists the method as "context" or "both".
> */
> static int ctxt_based_inst_needed(void)
> 
> Why if getexeccon fails doesn't it make sense to polyinstantiate based
> on context/level? Why not call getcon lf getexeccon fails and use that
> context instead of switching the method?

Good question.  What did you end up with for directory names?

Would you be willing to file a couple of bugzillas (one for the $HOME
expansion and one for this behavior) for the LSPP project?  That will
help us determine whether we need fixes for our certification or just
some documentation for now.

Thanks,

-- ljk
> 
> Oh yeah I also patch the debug output of an error that pam_namespace
> doesn't care about so why should I.
> 
> On 4/17/07, Michael C Thompson <thompsmc@us.ibm.com> wrote:
> 
>> Xavier Toth wrote:
>> > If you try and use $HOME in the directory name for instance
>> > $HOME/.mozilla the $HOME is not expanded. I'll submit a patch.
>>
>> Nice find, thank you for the patch. :)
>>
>> Mike
>>
> 
> ------------------------------------------------------------------------
> 
> --- Linux-PAM-0.99.7.0/modules/pam_namespace/pam_namespace.c	2007-04-18 09:32:05.000000000 -0500
> +++ Linux-PAM-0.99.7.0.new/modules/pam_namespace/pam_namespace.c	2007-04-18 09:31:23.000000000 -0500
> @@ -196,14 +196,18 @@
>      uids = strtok_r(NULL, " \t", &tptr);
>  
>      /*
> -     * If the directory being polyinstantiated is the home directory
> -     * of the user who is establishing a session, we have to swap
> -     * the "$HOME" string with the user's home directory that is
> -     * passed in as an argument.
> +     * Expand $HOME in dir
>       */
> -    if (strcmp(dir, "$HOME") == 0) {
> -	dir = home;
> +    if ((tptr = strstr(dir, "$HOME")) != 0) {
> +        if (strlen(dir) > 5) {
> +            char *expanded = alloca(strlen(home)+strlen(dir)-5+1);
> +            *tptr = 0;
> +            sprintf(expanded, "%s%s", home, tptr+5);
> +            dir = expanded;
> +	}
> +	else
> +            dir = home;
>      }
>  
>      /*
>       * Expand $HOME and $USER in instance dir prefix
> @@ -1117,10 +1141,11 @@
>  
>                  if (umount(pptr->dir) < 0) {
>              	    int saved_errno = errno;
> -            	    pam_syslog(idata->pamh, LOG_ERR, "Unmount of %s failed, %m",
> +            	    if (saved_errno != EINVAL) {
> +            	        pam_syslog(idata->pamh, LOG_ERR, "Unmount of %s failed, %m",
>                      	pptr->dir);
> -            	    if (saved_errno != EINVAL)
>                  	return PAM_SESSION_ERR;
> +		    }
>                  } else if (idata->flags & PAMNS_DEBUG)
>                      pam_syslog(idata->pamh, LOG_DEBUG, "Umount succeeded %s",
>  				pptr->dir);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
