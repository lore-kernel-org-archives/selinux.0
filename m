Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2SDuAx6029767
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2003 08:56:11 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2SDqalY017265
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2003 13:52:37 GMT
Received: from RelayDAL.nai.com (relaydal.nai.com [205.227.136.197])
	by jazzswing.ncsc.mil  with ESMTP id h2SDqaKX017262
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2003 13:52:36 GMT
Received: from txwsout1.nai.com ([161.69.216.92])
	by RelayDAL.nai.com (Switch-2.2.5/Switch-2.2.5) with SMTP id h2SDrkN05561
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2003 07:53:46 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: general policy stuff
Date: Fri, 28 Mar 2003 07:58:29 -0600
Message-ID: <8894CA1F87A5D411BD24009027EE783801C14D09@md-exchange1.na.nai.com>
From: <Kelly_Djahandari@nai.com>
To: <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker's diff patch have been applied to the files on sourceforge, and the spelling error corrected. Thanks Russell for the changes.

Kelly Djahandari
Network Associates Laboratories

-----Original Message-----
From: Russell Coker
To: SE Linux
Sent: 3/16/03 3:36 PM
Subject: general policy stuff

The Makefile for the policy has constraints mis-spelled in the following
line:
POLICYFILES += tmp/contraints-contexts.m4

Temporary files don't matter much how they are spelled, but I still
think it 
should be right.

Recently the line
allow $2_t console_device_t:chr_file rw_file_perms;
was added to the daemon_sub_domain() macro.  I don't think that this is 
desired as the ability to read/write to the console can allow a daemon a

dangerous level of access (maybe offering a trojan login prompt).

Although there are probably some other things that need to be considered

regarding the console (last time I wanted to run a getty on a serial
console 
I found the default policy incapable of it).

I have attached the diff between my policy and the CVS policy for the
core 
files and the .fc files.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux
packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page
 <<diff>> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
