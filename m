Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h41LEiI4013049
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 17:14:44 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h41LEh7R008250
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 21:14:43 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-196.nas-smoothtransition.com [66.95.157.196] (may be forged))
        by jazzband.ncsc.mil  with ESMTP id h41LEgKP008247 for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 21:14:42 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Petty, Clint E'" <clint.e.petty@lmco.com>, <selinux@tycho.nsa.gov>
Subject: RE: Trusted Operating System?
Date: Thu, 1 May 2003 17:13:58 -0400
Message-ID: <009201c31026$97ab8d70$6700a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <AED99F3E5CF6C749B320E3B51B0D14B217B52F@EMSS01M10.us.lmco.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm afraid you'll have to clarify what you mean by "trusted OS".  Do you
mean a common criteria evaluation as I suspect?  The trustworthiness of
an OS and the successful completion of a CC evaluation at some
evaluation level are not equivalent concepts.  The latter tends to be
more of a marketing/political concern (e.g., my government agency
requires an evaluated OS) than an issue with the basic trustworthiness
of the technology.

Without stating my own personal option, there are some who would claim
that the type enforcement architecture and it open source availability
makes the trustworthiness potential of SE Linux greater than evaluated
proprietary OSs with standard user-based access controls (or even
Bell-LaPadula like multilevel security access controls).  Of course for
any application, one must judge the deployed system in its intended
configuration (e.g., a certification and accreditation in U.S.
government lingo) to determine whether the OS that you trust
incorporates adequate assurances to be trustworthy.

Frank

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov 
> [mailto:owner-selinux@tycho.nsa.gov] On Behalf Of Petty, Clint E
> Sent: Thursday, May 01, 2003 2:31 PM
> To: 'selinux@tycho.nsa.gov'
> Subject: Trusted Operating System?
> 
> 
> When do you anticipate you will have made SELinux a Trusted Operating
> System?  Any forcasts?
> Thanks,
> Clint
> 
> 
> --
> This message was distributed to subscribers of the selinux 
> mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
