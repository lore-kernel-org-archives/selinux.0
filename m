Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA15490
	for <selinux@tycho.nsa.gov>; Sun, 29 Sep 2002 17:20:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA02586
	for <selinux@tycho.nsa.gov>; Sun, 29 Sep 2002 21:19:17 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA02582
	for <selinux@tycho.nsa.gov>; Sun, 29 Sep 2002 21:19:16 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Chris Vance <cvance@tislabs.com>
Subject: Re: [patch] label /home directory, create suserdel
Date: Sun, 29 Sep 2002 23:20:33 +0200
References: <Pine.LNX.4.33.0209291546510.20607-300000@zorg.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0209291546510.20607-300000@zorg.gw.tislabs.com>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Message-Id: <200209292320.33859.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 29 Sep 2002 21:50, Chris Vance wrote:
> Attached are two patches (also committed to the sourceforge CVS tree) that
> define a new label for the /home directory and allow access as necessary.
> The first patch defines the new label and adds permissions.  The second
> patch add the suserdel program in the utils/spasswd directory.

I've added that to my tree.

However more work needs to be done.  If the /etc/skel directory contains any 
of .ssh, .gnupg, etc then it won't give them the right labels.

We need a patch to setfiles to label the home directories correctly managing 
different roles for different users and different types for different 
sub-directories of the home directories.  Then the useradd wrapper would need 
to call that to set the files.

Also I've got a solution to the .Xauthority problem too, I'll post a patch 
soon.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
