Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA05262
	for <selinux@tycho.nsa.gov>; Wed, 27 Nov 2002 09:19:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA10359
	for <selinux@tycho.nsa.gov>; Wed, 27 Nov 2002 14:17:18 GMT
Received: from smtpproxy2.mitre.org (smtpproxy2.mitre.org [192.80.55.70])
        by jazzband.ncsc.mil  with ESMTP id OAA10355 for <selinux@tycho.nsa.gov>; Wed, 27 Nov 2002 14:17:17 GMT
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, giorgio.zanin@poste.it,
        guttman@mitre.org (Joshua D. Guttman), selinux-list@lists.mitre.org
Subject: Re: role dominance
Reply-To: guttman@mitre.org (Joshua D. Guttman disp: current)
References: <200211271407.JAA21945@moss-shockers.ncsc.mil>
From: guttman@mitre.org (Joshua D. Guttman)
Date: 27 Nov 2002 09:19:05 -0500
In-Reply-To: <200211271407.JAA21945@moss-shockers.ncsc.mil>
Message-ID: <nha65ujnlie.fsf@banjara.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

"Stephen D. Smalley" <sds@epoch.ncsc.mil> writes:

>   
>   Yes, the user is implicitly authorized for the dominated role, and (U1,R2,T2) 
>   would be a valid security context.  
>   

role dominance seems not to be used in the current example policy.  I
had the impression that you were planning to deprecate it or remove
it.   Is that wrong?  

Thanks --

        Joshua 
-- 
	Joshua D. Guttman		<guttman@mitre.org> 
	MITRE, Mail Stop S119		Office:	+1 781 271 2654
	202 Burlington Rd.		Cell:	+1 781 526 5713
	Bedford, MA 01730-1420 USA	Fax:	+1 781 271 8953



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
