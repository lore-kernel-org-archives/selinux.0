Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8AH2QLa010206
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 13:02:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8AH0nLY014687
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 17:00:49 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h8AH0nsG014684
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 17:00:49 GMT
Subject: Re: rfs xattr's, mkinitrd and other stories
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dale Amon <amon@vnl.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20030910164854.GO5397@vnl.com>
References: <20030910164854.GO5397@vnl.com>
Content-Type: text/plain
Message-Id: <1063213343.14458.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 10 Sep 2003 13:02:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-09-10 at 12:48, Dale Amon wrote:
> So I'm on to the next phase of getting a debian 
> system working with 2.6.0 (with devfs and a 
> reiserfs root)

devfs will require a patch to support labeling, and appears to be
obsolete in 2.6.

> Secondly, all of the examples I find are somewhat
> different. Steve's patch in the HOWTO is for a
> very different looking RH file so it's hard to
> tell what he actually needs. Colin's July 17 looks
> reasonable and I'll probably start with that... but
> I am worried about the issues with debian packages.

The mkinitrd script needs to copy the policy file and load_policy
program onto the initrd, and the /linuxrc script that is placed on the
initrd needs to mount selinuxfs and run load_policy before the root
filesystem is mounted.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
