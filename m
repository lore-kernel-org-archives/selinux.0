Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAOJ0ERb010026
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 14:00:15 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAOIxfp5026655
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 18:59:41 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hAOIxet0026652
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2003 18:59:40 GMT
Subject: Re: How to handle lots of executables  buried in /usr
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <3FC21D65.5070803@redhat.com>
References: <3FC21D65.5070803@redhat.com>
Content-Type: text/plain
Message-Id: <1069700405.8635.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 24 Nov 2003 14:00:06 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-11-24 at 10:01, Daniel J Walsh wrote:
> I am seeing lots of errors in policy because of shell scripts and exes 
> that are installed in subdirectories of /usr being marked as  usr_t 
> instead of bin_t .  What do you guys think of adding a script to be 
> executed after make relabel that would find these files and change their 
> context to bin_t.
> 
> find /usr -perm +111 --context system_u:object_r:usr_t -type f -exec 
> chcon \
> system_u:object_r:bin_t {} ; -print
> 
> 
> Is this a bad idea?  I do notice that their are a lot of files marked 
> executables by their install that are really not executable, but this 
> would clean up several failures untill the package installs are cleaned up.

It might be better to define multiple types for different groups of
binaries, and only grant execute access as appropriate.

As a side note, be careful about symlinks.  The above find construct
will get the context of the symlink, but the chcon will set the context
of the referenced file unless you specify -h.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
