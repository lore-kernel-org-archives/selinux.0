Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5S26H0S017048
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 22:06:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5S25Sss001512
	for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2003 02:05:28 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h5S25LhY001509
	for <selinux@tycho.nsa.gov>; Sat, 28 Jun 2003 02:05:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>, selinux@tycho.nsa.gov
Subject: Re: biometric codecs / hardware signed blackbox-capable interconnecti ve system-resources
Date: Sat, 28 Jun 2003 12:05:54 +1000
References: <B4E788FBFCD6844F96A017F337797AE167B624@mozart.patioenclosuresinc.com> <20030628001205.GA21997@snoopy.apana.org.au>
In-Reply-To: <20030628001205.GA21997@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306281205.54145.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Removed selinux-team as they are probably all on this list anyway.

On Sat, 28 Jun 2003 10:12, Brian May wrote:
> I don't see any solutions here. For instance, lets say I went to a
> untrusted computer console A. I insert a smart card to authenticate
> myself, and automatically sysadm_r priviliges on remote computer B. This
> could be done in a secure manner, and in such a way that that no data
> on the smartcard can be stolen. This is easy, convenient, and means
> you don't have to keep track of numerous passwords and retype them in
> frequently (remember too that the more often you enter the password, the
> more likely it is someone will observe it getting entered).
>
> Unknown to me though, the copy of bash on A was altered, it forked
> another process that also connected to B with sysadm_r priviliges, and
> executed a command like "rm -rf /".

Issues of forking bash can be solved, the smart-card could implement part of 
the ssh code so that only one connection is used, that is straight from the 
smart-card to computer B.  However this does not solve the problem as what 
computer A displays may be quite different to what computer B is sending 
back.

I can't imagine a way of securing a connection that originates with an 
untrusted machine.  Best to just use an iPaQ as a ssh client.

As for the original issue of biometrics, I can't imagine why pam wouldn't do 
the job.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
