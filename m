Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2KKGwx6018504
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 15:16:58 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h2KKGv9P006196
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 20:16:57 GMT
Received: from fw.oem.doe.gov (fw.oem.doe.gov [205.254.142.226])
        by jazzband.ncsc.mil  with ESMTP id h2KKGuP7006193 for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 20:16:57 GMT
Received: from oem.oem.doe.gov (oem-blk.oem.doe.gov [172.30.10.118])
	by fw.oem.doe.gov with ESMTP id h2KKH81h000727
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 15:17:08 -0500 (EST)
Received: from rsl-blk.oem.doe.gov (rsl-blk.oem.doe.gov [172.20.12.10])
	by oem.oem.doe.gov (8.8.8+Sun/8.8.8) with ESMTP id PAA11794
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 15:19:30 -0500 (EST)
Received: from oem.doe.gov (athlon [172.20.10.7])
	by rsl-blk.oem.doe.gov (8.8.8+Sun/8.8.8) with ESMTP id MAA05136
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 12:19:29 -0800 (PST)
Message-ID: <3E7A1FA6.1030604@oem.doe.gov>
Date: Thu, 20 Mar 2003 12:08:06 -0800
From: Douglas Phillipson <phillipd@oem.doe.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Opinions on installing selinux on different distros, second try
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm sorry if this gets posted twice.  The first time I didn't see it get 
posted...

I have been monitoring this list for a few months and as a SELinux newby 
I have a few questions for those that have braved the attempt to use 
SELinux.  I hope to use it myself in the DOE community shortly.

1) I see lots of problems with SELinux, by the posts I read.  Is there 
any release version, by number, with known problems for each release. Or 
is this just a evolving "Thing" where bugs are fixed and new capability 
is added on the fly?

2) Is it best to start from non-distro raw kernel source or is patching 
one of the major distros, redhat, Suse, Mandrake, Debian compatible, better.

3) Are there recommended  distros and or kernel versions to use SELinux 
with?  Perhaps a FAQ for each supported Distro or version of kernel?

4) Has anyone compiled a installation procedure that was successful for 
their distro that you could share with others?  Perhaps even a list of 
"gotchas" to avoid.

5) Has anyone had SELinux approved for use in a classified network?  If 
so do you have a security plan I could look at?

6) Does there exist a "White Paper" on SeLinux's security 
features/enhancements.

7) Does SeLinux add and "C2" auditing functionality.

8) I understand that  the "Secure Computing" corporation had a hand in 
this.  Do they have a commercial version available or one planned?

Comment:  I think the Debian method of "release when it's ready" and a 
"Stable", "Testing" and "Unstable" release system would be a good fit 
here.  Any opinions or plans on this?

Thanks, I am looking forward to trying it but don't want to re-invent 
the wheel here.

Doug P


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
