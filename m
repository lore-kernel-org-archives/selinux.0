Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA29332
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 07:16:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA00004
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 12:15:45 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA29996
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 12:15:43 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: NSA SE enabled devfsd
Date: Wed, 6 Mar 2002 13:16:38 +0100
Cc: devfs@oss.sgi.com
MIME-Version: 1.0
Message-Id: <20020306121639.699FC2158@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Mar 2002 00:23, Russell Coker wrote:
> I have hacked support for SE Linux into devfsd.

I have found one problem with my current code.  devfsd wants to re-apply it's 
permissions to device nodes whenever it's restarted and whenever you do
"killall -1 devfsd"  to tell it to reload it's config.

During the course of a login session the SID of the pty device will change.  
It starts as devpts_t, goes to sshd_devpts_t (for a ssh session - an 
equivalent type for a non-ssh session), then goes to user_t (or an 
appropriate type for the user).

So if devfsd is restarted when someone is logged in then the result is likely 
to be a logout for them (which is tough if you've logged in to change the 
devfsd config).

Currently I've got my devfsd config matching on ^pts$ and using domain 
transition rules for the rest.

For the /dev/vc/* devices (devfs equivalent to /dev/tty[0-9]*) the only 
solution I get think of right now is to have the devfs_contexts file specify 
them.



Also this is not an issue that is restricted to SE Linux.  Currently if I run 
"killall -1 devfsd" it will be equivalent to "mesg n" for all users!

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
