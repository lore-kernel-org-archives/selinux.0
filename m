To: <mayerf@tresys.com>
Cc: "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>,
   "'Stephen D. Smalley'" <sds@epoch.ncsc.mil>,
   "'Amy L. Herzog'" <aherzog@mitre.org>,
   "'John D. Ramsdell'" <ramsdell@mitre.org>,
   "'Galen B. Williamson'" <gwilliam@mitre.org>,
   "'Grant M. Wagner'" <gmw@tycho.ncsc.mil>, "'David Caplan'" <dac@tresys.com>,
   guttman@mitre.org (Joshua D. Guttman)
Subject: Re: Announce: SELinux conditional policy extensions
Reply-To: guttman@mitre.org (Joshua D. Guttman disp: current)
References: <000c01c3f265$9139f860$020d010a@columbia.tresys.com>
From: guttman@mitre.org (Joshua D. Guttman)
Date: 16 Feb 2004 16:20:32 -0500
In-Reply-To: <000c01c3f265$9139f860$020d010a@columbia.tresys.com>
Message-ID: <nhau11qk9gf.fsf@malabar.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When you refer to conflicting rules, what do you mean?  

Thanks --

        Joshua 

>From README-COND:

>      - Policy conflicts with policy
>    
>          Non-conditional policy rules take preference over conditional 
>          rules.  In most cases, a conflicting conditional rule is 
>          discarded. In some cases, the policy compiler will exit with an 
>          error. The list below describes the conflicts and the results:
>    
>          - A conditional type rule conflicts with a non-conditional type 
>            rule
>    
>    	  The conditional type rule is discarded and the compiler issues
>    	a warning.
>    
>          - A conditional type rule in one conditional policy block 
>    	conflicts with 	a conditional type rule in a different 
>    	conditional policy block.
>    
>    	  The previously processed rule is kept, the second is discarded.
>    

-- 
	Joshua D. Guttman		<guttman@mitre.org>
	MITRE, Mail Stop S119		Office:	+1 781 271 2654
	202 Burlington Rd.		Fax:	+1 781 271 8953
	Bedford, MA 01730-1420 USA	Cell:	+1 781 526 5713



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
