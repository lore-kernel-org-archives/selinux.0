Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA24256
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 14:46:11 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA25910
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 19:44:58 GMT
Received: from Woody.fw.matav.hu (matav-1.matav.hu [145.236.241.98])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA25906
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 19:44:56 GMT
Received: from benigni.tii.matav.hu ([10.3.73.154]) by intranet.matav.hu
          (Netscape Messaging Server 3.6)  with SMTP id AAA298D
          for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 21:07:24 +0100
Date: Tue, 26 Dec 2000 20:45:18 +0100
From: Magosanyi Arpad <mag@bunuel.tii.matav.hu>
To: selinux@tycho.nsa.gov
Subject: questions
Message-ID: <20001226204517.A2967@bunuel.tii.matav.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Hi!

I was playing a bit with this flasky linux.
Some irrelevant little notes:
- chmod a+x flask/mkaccess_vector.sh and chmod a+x flask/mkflask.sh was
necessary, on 2.2.17. Maybe writing the makefile in such a way that they
don't need execute permission would be a nice idea. I know that this is
absolutely unnecessary cosmetics.
- On policy_parse.y yacc always choked on line 228. There were two consecutive
lines containing a single ';'. I guess it is due to some syntax error in my
/etc/security/*, or the m4 tricks.
- Why redhat? I think that giving the patches relative to the upstream source
would be a nicer solution. I am still wrestling with the userspace, maybe
I do not have some tools or something. Having a Makefile instead a (horror!)
csh script would greatly simplify the task. (Well, I have modified the script
for bash, because I don't have csh on my system, and can use set -e)

Now I am trying to apply my pet patcset to the thingie. It is lvm and reiserfs.
Both applies cleanly, but I guess there shall be done some coding to actually
use them. I have studied the ext2 patches, and I am reasonably sure that I know
what to do with reiserfs, but have a problem: in the reiser code there is no
reserved or otherwise unused space in the disk inode structure. I could not find
anything resembling to resource fork or space for acl either. Maybe having the
inode<->psid mapping in the special directory for filesystems without direct 
support would be a reasonable temporary solution.
For lvm, I don't have a clue as what to look for. I guess that standard 
capability checks would be sufficient. I either don't know if these are 
implemented in the lvm code. Anyone having more ideas than me?

I am also interested in the network code (but first I want to get to the
stage where I can boot the thingie). I hope that Zorp's mandatory access
control can be combined with this. Is the following is true?:
In the current implementation flask can label hosts based on their
claimed IP address, but cannot handle other multilevel hosts due to lack
of ipsec integration?

-- 
GNU GPL: csak tiszta forrásból
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
