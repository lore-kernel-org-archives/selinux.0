Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA25967
	for <selinux@tycho.nsa.gov>; Sun, 25 Aug 2002 20:36:43 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id AAA20328
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 00:35:02 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id AAA20323 for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 00:35:01 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id C06C792492
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 10:36:38 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 7F8021665
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 02:36:26 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: devfs_t vs device_t
Date: Mon, 26 Aug 2002 01:29:01 +0200
MIME-Version: 1.0
Message-Id: <20020826003626.7F8021665@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve has insisted that all "allow domain" rules be removed from the sample 
policy.  This increases the cost (in terms of policy size, complexity, and 
user confusion) of having a separate type devfs_t for the root of the devfs 
file system.

This combined with the limited benefits of having the separate type lead me 
to now believe that having such a type loses us more than it gains us.

I have created a new test policy tree with no devfs_t and which uses device_t 
for /dev in both devfs and non-devfs.  I have it working on three machines 
without any problems (apart from the need to change to permissive mode before 
the install of the new policy and reboot afterwards).

Steve, please let me know what you think of this idea.

As an aside, for future upgrade paths I have been considering a mechanism for 
a policy snippet to be inserted in the running policydb but not in the 
policydb that is loaded from disk at boot time, so therefore you can have 
some temporary rules for running programs that will disappear at reboot time. 
Of course it would be a bad idea to run for weeks or months in such a state, 
but it could be very handy if you want to install a new policy now and then 
schedule a reboot at 8PM to take care of any left-over processes.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
