Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0MFEKRb008625
	for <selinux@tycho.nsa.gov>; Thu, 22 Jan 2004 10:14:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0MFEJCa012339
	for <selinux@tycho.nsa.gov>; Thu, 22 Jan 2004 15:14:19 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i0MFEJVC012336 for <selinux@tycho.nsa.gov>; Thu, 22 Jan 2004 15:14:19 GMT
Subject: RE: transition failure
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "James R. Kratzer" <JamesK@xetron.com>
Cc: "'russell@coker.com.au'" <russell@coker.com.au>,
   "SE Linux Mail List (E-mail)" <selinux@tycho.nsa.gov>
In-Reply-To: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A88@s3cin>
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A88@s3cin>
Content-Type: text/plain
Message-Id: <1074784446.13445.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 22 Jan 2004 10:14:06 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-01-22 at 09:56, Kratzer, James R. wrote:
> Thanks Russ.  I was not aware of the constraints.  I'm am using "runcon"
> because when I use "run_init" I get the following error:
> 
>     execvp: Permission Denied
> 
> I forgot to mention previously that the "runcon" command gives this same
> error as well along with the "avc: denied { transition }" message.  
> 
> BTW, these errors only occur with enforcing=1 as run_init and runcon execute
> swatch just fine with enforcing=0.
> What does execvp mean?

execvp(3) is a library function that is a front-end for execve(2);
run_init calls it to execute the script.  The most likely cause for
failure here is that the type on the /etc/rc.d/init.d/swatchd script is
wrong; it needs to have the initrc_exec_t type.  Try 'chcon -t
initrc_exec_t /etc/init.d/swatchd'.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
