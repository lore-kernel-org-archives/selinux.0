Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA22373
	for <selinux@tycho.nsa.gov>; Thu, 20 Feb 2003 14:41:31 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA25739
	for <selinux@tycho.nsa.gov>; Thu, 20 Feb 2003 19:38:21 GMT
Received: from torexch1.mykotronx.com (host-65-119-11-194.mykotronx.com [65.119.11.194] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id TAA25728
	for <selinux@tycho.nsa.gov>; Thu, 20 Feb 2003 19:38:19 GMT
Message-ID: <FD2221F5E1A8184DB61AFCE064C395F1C91CEF@torexch1.mykotronx.com>
From: CNGUYEN <CNguyen@mykotronx.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "'Stephen D. Smalley'"
	 <sds@epoch.ncsc.mil>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: RE: Making OPIE/QTOPIA aware of SELinux
Date: Thu, 20 Feb 2003 11:42:56 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Applications <----
----              |
OPIE/QTOPIA  <---------|
---                    |
SELinux                |
---                    | 
Device Drivers <-------|

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au]
Sent: Thursday, February 20, 2003 11:36 AM
To: CNGUYEN; 'Stephen D. Smalley'; 'selinux@tycho.nsa.gov'
Subject: Re: Making OPIE/QTOPIA aware of SELinux


On Thu, 20 Feb 2003 17:42, CNGUYEN wrote:
> Any thoughts on how to make the GUI environment (OPIE or QTOPIA) aware of
> SELinux so that "bypassing" SELinux is prevented?

What exactly do you mean by "bypassing SE Linux" and in what ways do you
think 
it should be made aware of SE Linux?

I'm working on Familiar right now but my work is just starting...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
