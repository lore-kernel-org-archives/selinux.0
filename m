Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8BBhDLa014895
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 07:43:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8BBfULY012653
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 11:41:30 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h8BBfTsG012650
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 11:41:29 GMT
Subject: Re: rfs xattr's, mkinitrd and other stories
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dale Amon <amon@vnl.com>
Cc: Colin Walters <walters@verbum.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>,
   Russell Coker <russell@coker.com.au>
In-Reply-To: <20030910233424.GV5397@vnl.com>
References: <20030910164854.GO5397@vnl.com>
	 <1063233012.27358.11.camel@columbia> <20030910230519.GU5397@vnl.com>
	 <20030910233424.GV5397@vnl.com>
Content-Type: text/plain
Message-Id: <1063280556.16884.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 11 Sep 2003 07:42:36 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-09-10 at 19:34, Dale Amon wrote:
> Okay, next round of questions. According to Steve's HOWTO, the
> line
> 
> 	none /selinux selinuxfs defaults 0 0
> 
> goes into the /etc/fstab to cause this file to mount. However
> Debian mkinitrd defaults to cramfs and also states it requires
> a debian dist patched kernel.
> 
> I'm left with these questions:
> 
> * what is an selinuxfs???

It isn't the initrd filesystem.  selinuxfs is a pseudo filesystem that
exports the security policy API to userspace.  The /linuxrc script on
the initrd needs to mount it in order to perform the initial policy
load, and you also want it mounted on the real root (which is why we put
it in /etc/fstab) for use by the SELinux-patched programs (e.g. login).
See my slides from the 2003 OLS SELinux BOF, available from
http://www.nsa.gov/selinux/docs.html, for a discussion of the API
changes for 2.5/6.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
