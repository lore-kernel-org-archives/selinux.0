Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FIfdWt027709
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 14:41:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9FIfV0p010869
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 18:41:31 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9FIfVr7010866
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 18:41:31 GMT
Subject: Re: Question about chsh/chfn/passwd patches
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thorsten Kukuk <kukuk@suse.de>
Cc: SELinux Mailinglist <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <20031015183117.GA5967@suse.de>
References: <20031015034406.GA1644@suse.de>
	 <1066241019.7399.79.camel@moss-spartans.epoch.ncsc.mil>
	 <20031015183117.GA5967@suse.de>
Content-Type: text/plain
Message-Id: <1066243290.7399.120.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Oct 2003 14:41:30 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-15 at 14:31, Thorsten Kukuk wrote:
> Ok, since I copy always all attributes if I modify /etc/passwd and
> /etc/shadow (to make sure to preserve ACLs and security attributes),
> I don't need it.

The problem with simply preserving attributes via setxattr is that you
cannot create the new file immediately with the desired attributes, so
there is a window where the new file exists with the default attribute
value, typically inherited from the parent directory.  Note that this is
particularly a concern for /etc/passwd and /etc/shadow, since they live
in the same parent directory but have differing protection requirements.

The SELinux setfscreatecon() interface (implemented via the
/proc/pid/attr/fscreate API) allows a process to set the desired
security context for subsequent file creations, similar to the umask. 
You'll notice that many of the SELinux patches use this interface to set
the desired context prior to creating the new file, so that files are
immediately created with the right context and are protected
accordingly.  This is one of the reasons we don't just use the EA patch
for coreutils and instead have our own.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
