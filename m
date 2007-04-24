Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OF6wg6018251
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 11:06:58 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OF6u3M011137
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 15:06:57 GMT
Message-ID: <27C0723414C58546B4084C2F17BE052A213A23@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Xavier Toth <txtoth@gmail.com>, Michael C Thompson
	 <thompsmc@us.ibm.com>
Cc: selinux@tycho.nsa.gov
Subject: RE: directory polyinstantiation failure
Date: Tue, 24 Apr 2007 11:06:42 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I believe "user" fallback case also creates a problem in utilizing namespace
for the current version of GDM with RHEL 5 from my testing. 

-Chad

> -----Original Message-----
> From: Xavier Toth [mailto:txtoth@gmail.com] 
> Sent: Wednesday, April 18, 2007 12:00 PM
> To: Michael C Thompson
> Cc: selinux@tycho.nsa.gov
> Subject: Re: directory polyinstantiation failure
> 
> Here is the patch for to expand $HOME. However as I looked at 
> the code I see the reason for behavior that had confused me 
> partly because it isn't documented and partly because I don't 
> think it is desired. I'd specified some directories to be 
> polyinstantiated by level but then I'd see that they might 
> also get polyinstantiated by user. The code as described in 
> the following comment is overriding my specified method if 
> getexeccon fails.
> /*
>  * This function checks if the calling program has requested context
>  * change by calling setexeccon(). If context change is not requested
>  * then it does not make sense to polyinstantiate based on context.
>  * The return value from this function is used when selecting the
>  * polyinstantiation method. If context change is not requested then
>  * the polyinstantiation method is set to USER, even if the 
> configuration
>  * file lists the method as "context" or "both".
>  */
> static int ctxt_based_inst_needed(void)
> 
> Why if getexeccon fails doesn't it make sense to 
> polyinstantiate based on context/level? Why not call getcon 
> lf getexeccon fails and use that context instead of switching 
> the method?
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
