Message-ID: <0D2F5426C26FD511A1C400B0D0D05968159831@deliverance.tycho.ncsc.mil>
From: "Wagner, Grant" <gmw@tycho.ncsc.mil>
To: Manoj Srivastava <manoj.srivastava@stdc.com>, selinux@tycho.nsa.gov
Subject: RE: Clarification about distribution terms on the software
Date: Wed, 26 Sep 2001 12:50:51 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

The NSA lawyers tell us that the Warranty Exclusion and Limitation of
Liability wording in the relevant open source licenses (i.e., GNU GPL and
BSD) are sufficient for our needs relative to indirect recipients (i.e.,
those that do not get the code from the NSA web site directly). The wording
on http://www.nsa.gov/selinux/src-disclaim.html need not be propagated to
such indirect recipients as long as all the relevant licenses are
propagated.

-- Grant

Grant M. Wagner
Technical Director 
Secure Systems Research Office
National Security Agency

gmw@tycho.nsa.gov


> -----Original Message-----
> From: Manoj Srivastava [mailto:manoj.srivastava@stdc.com]
> Sent: Tuesday, September 25, 2001 1:29 PM
> To: selinux@tycho.nsa.gov
> Subject: Clarification about distribution terms on the software
> 
> 
>  Hi,
> 	[This is a repost from the address I am subscribed with, and
> 	hence some people on the internal list shall see this as a
> 	duplicate. I apologize for the inconvenience]
>  
>          A number of developers for the Debian Project 
> (http://www.debian.org/)
>   have expressed an interest in rolling in a kernel-patch-selinux
>   package, for inclusion in the Debian GNU?Linux distribution.
>  
>  	The criteria for inclusion of a package in the project are
>   defined by the ``Debian Free Software Guidelines'' contained in the
>   ``Social Contract'' (http://www.debian.org/social_contract). 
>  
>  	The initial impressions were good: The License terms at
>   http://www.nsa.gov/selinux/license.html makes it very clear that the
>   license terms are DFSG compliant. 
>  
>  	The confusion arises as one tries to download the sources, and
>   is presented with  http://www.nsa.gov/selinux/src-disclaim.html; one
>   is now required to agree to a legal agreement (I am not a lawyer, it
>   seems to be a restatement of the standard lack of warranty
>   clauses. However, I am not a lawyer).
>  
>  	One of the questions that arise from this is: Whom does the
>   NSA want this agreement from? Me, as a packager, the Debian Project,
>   as the distributor, or the end user of the software who is going to
>   install it on their machines, and may be impacted by any 
> flaws in the
>   process of doing so?  If indeed the end user agreement is required,
>   SELinux would not meet the DFSG.
>  
>  	Arguably, since the software itself is licensed under the GPL,
>   on may, after downloading the software, further redistribute it as
>   provided for by the GPL.
>  
>  	However, Debian is not in the business of not adhering to
>   upstream author wishes, and we would like to honour the intent, as
>   opposed to the letter, of the license.  Given that, the simplest
>   process was to come to the horses mouth and ask the authors what
>   their intent when putting a click-through legal agreement (which may
>   well be binding in the state where jurisdiction lies) on 
> the software
>   download? Is agreement of the end users required, or is 
> this only for
>   the initial download?  
>  
>  	manoj
> 
> -- 
>  No animal should ever jump on the dining room furniture unless
>  absolutely certain he can hold his own in conversation. Fran Lebowitz
> Manoj Srivastava   <manoj.srivastava@stdc.com>    
> <srivasta@debian.org> 
> 1024R/C7261095 print CB D9 F4 12 68 07 E4 05  CC 2D 27 12 1D F5 E8 6E
> 1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB 
> BF24 424C
> 
> --
> You have received this message because you are subscribed to 
> the selinux list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
