Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA09199
	for <selinux@tycho.nsa.gov>; Thu, 7 Mar 2002 17:10:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA02242
	for <selinux@tycho.nsa.gov>; Thu, 7 Mar 2002 22:08:49 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA02236
	for <selinux@tycho.nsa.gov>; Thu, 7 Mar 2002 22:08:47 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        "'Stephen Smalley'" <sds@tislabs.com>
Subject: Re: gdm
Date: Thu, 7 Mar 2002 22:53:32 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>,
        Debian Devel <debian-devel@lists.debian.org>
References: <72222DC86846D411ABD300A0C9EB08A1015242F5@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A1015242F5@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <20020307220938.3572B22B2A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

CC'd to the list because it's nothing confidential and something that needs 
wider discussion.

On Thu, 7 Mar 2002 16:36, Westerman, Mark wrote:
> I am creating a rpm package for the gdm,
> Should the install script make changes to
> the policy files or inform the user of what
> changes should be made ?

This is a fundamental issue regarding SE Linux packaging.

In the current version we have a problem in that the rbac file entry as well 
as the daemon.te file needs to be in place.  The next release will solve this 
(which makes it easier to implement whichever policy we decide on).

The problem is that many people will not want to have critical things such as 
flask configuration touched by an upgrade.

I am thinking of having the flask config files installed in a different 
directory and then having a program that summarises the differences and 
offers to copy changed files across.

This differs from the regular Debian config file manipulation in that:
Config files which the user has never modified will not be upgraded/changed 
without the user's agreement.
New config files will not be automatically added.

What do you think?

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
