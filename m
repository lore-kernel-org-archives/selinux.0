Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA27042
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 09:22:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA29425
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 13:21:33 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id NAA29421 for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 13:21:32 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: "use"
Date: Mon, 29 Apr 2002 15:22:49 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204290854320.19520-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204290854320.19520-100000@raven>
MIME-Version: 1.0
Message-Id: <20020429132249.8FFC53BFB@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 29 Apr 2002 14:57, Stephen Smalley wrote:
> > #
> > # Permissions to use file descriptions created by another domain.
> > #
> > define(`use_fd_perms', `use')
> > define(`inherit_fd_perms', `use')
> > define(`receive_fd_perms', `use')
>
> The original (pre-LSM) SELinux provided a distinction among these three
> cases that was eliminated from the LSM-based SELinux.  The macros were
> retained for compatibility, but there is no intent to revive the
> distinction.  This change is documented more completely along with a
> summary of all the changes between the original SELinux and the LSM-based
> SELinux in a technical report that is pending release approval from the
> NSA.

Thanks for the information.  I have removed those macros from my source tree, 
and used sed to change every reference to them to be a reference to "use".

I can understand why you want to keep those macros for the moment in your 
tree, but I think it would be a good idea if you changed all the program .te 
files to use "use" instead of "inherit_fd_perms".

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
