Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBFEIURb019785
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 09:18:30 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBFEHfjx000307
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 14:17:41 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hBFEHeSR000303
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 14:17:41 GMT
Subject: Re: Information
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Carlos =?ISO-8859-1?Q?An=EDsio?= Monteiro <monteiro@ipen.br>,
   selinux <selinux@tycho.nsa.gov>
In-Reply-To: <200312152313.59234.russell@coker.com.au>
References: <3FDD9A28.9070406@ipen.br>
	 <200312152313.59234.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1071497887.28044.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 15 Dec 2003 09:18:07 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-12-15 at 07:13, Russell Coker wrote:
> The file /selinux/policyvers has the version.  A future version of sysvinit 
> will examine that file to determine which (of possibly many) policy databases 
> should be loaded.
> 
> Maybe Dan's rpm has this already, I haven't checked.

Yes, the patched SysVinit already includes this feature.  A
security_policyvers() function was added to libselinux to encapsulate
obtaining the policy version required for the kernel, and the patched
init program uses this function to obtain the version number at
runtime.  The library function will try to obtain the version number
from the kernel via /selinux/policyvers, and will fall back to a default
of 15 if that fails (for older kernels that did not export
/selinux/policyvers).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
