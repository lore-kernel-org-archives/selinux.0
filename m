Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA28498
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2001 14:15:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA10043
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2001 18:14:38 GMT
Received: from hidrogeno.cti (cti015035.prima.com.ar [200.42.15.35])
	by jazzswing.ncsc.mil  with ESMTP id SAA10014
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2001 18:13:56 GMT
Received: from cti.com.ar (radon.cti [170.51.191.71])
	by hidrogeno.cti (8.8.6 (PHNE_17190)/8.8.6) with ESMTP id PAA27208
	for <selinux@tycho.nsa.gov>; Wed, 9 May 2001 15:15:34 -0300 (SAT)
Message-ID: <3AF9C18F.1890725@cti.com.ar>
Date: Wed, 09 May 2001 15:15:44 -0700
From: "Hugo F. Martinez" <hmartinez@cti.com.ar>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Installing selinux on RedHat 7.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello:
    I came across with some problems installing selinux on RedHat 7.0
and  i would like to know if someone of you had something like this
making the initial policy

ERROR IN THE STATEMENT ENDING ON LINE 1054 (TOKEN ';'):
    UNKNOWN CLASS FILESYSTEM USED IN RULE

And the line that make that error is this:

allow file_type fs_t:filesystem associate;

I've changed the version from gcc 2.96.3 to 2.95.3 and i got the same
error, and when i boot the machine i get this messages from the kernel

security: starting up (compiled on <date>)
security: loading policy configuration from /ss_policy
security: unable to open /ss_policy
kernel panic: security_init

The directory /ss_policy does not exist. One more thing is that my
machine compiles and works with the kernel-2.4 without the flask
facility.

Thanks.




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
