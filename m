Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8AJ3RLa011217
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 15:03:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8AJ1oLY025921
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 19:01:50 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
	by jazzswing.ncsc.mil  with ESMTP id h8AJ1nsG025918
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 19:01:50 GMT
Subject: Re: rfs xattr's, mkinitrd and other stories
From: Chris PeBenito <pebenito@gentoo.org>
To: Dale Amon <amon@vnl.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20030910164854.GO5397@vnl.com>
References: <20030910164854.GO5397@vnl.com>
Content-Type: text/plain
Message-Id: <1063220599.29764.6.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Wed, 10 Sep 2003 14:03:19 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there going to be any work getting the handler for the 2.4?  I tried
to add it on to Jeff's 2.4 patches on ftp.suse.com, but was
unsuccessful.

On Wed, 2003-09-10 at 11:48, Dale Amon wrote:
> If anyone is interested, I've worked with Jeff Mahoney 
> and Steve Smalley and between us we've got what should
> be the necessary patches for using selinux with
> reiserfs on 2.6.0 kernels. They are availabe here and
> possibly on the Suse site by now:
> 
>  http://www.unixthugs.org/~jeffm/technical/reiserfs/aclea/2.6.0-test4/

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer, SELinux
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
