Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA11338
	for <selinux@tycho.nsa.gov>; Fri, 8 Mar 2002 08:46:14 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA23353
	for <selinux@tycho.nsa.gov>; Fri, 8 Mar 2002 13:45:13 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
        by jazzband.ncsc.mil  with SMTP id NAA23349 for <selinux@tycho.nsa.gov>; Fri, 8 Mar 2002 13:45:12 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015242FA@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "Westerman, Mark"
	 <Mark.Westerman@csoconline.com>,
        "'Stephen Smalley'" <sds@tislabs.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        Debian Devel
	 <debian-devel@lists.debian.org>
Subject: RE: gdm
Date: Fri, 8 Mar 2002 07:46:23 -0600 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

My first thought was not to make the changes. For one I have no 
idea of how the user might have modified there configuration.
That make it hard on scripts to make changes. The idea of keeping
a copy sound promising. I was thinking of writing a gdmb type database
of all the rules in the file. Then I could cross link domains and rules
to files such that I could say turn (off or on) domain and the database
would know what rule to comment out. 

We truly need to find a way of maintaining the rules.


Mark

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au]
Sent: Thursday, March 07, 2002 3:54 PM
To: Westerman, Mark; 'Stephen Smalley'
Cc: SE Linux; Debian Devel
Subject: Re: gdm


CC'd to the list because it's nothing confidential and something that needs 
wider discussion.

On Thu, 7 Mar 2002 16:36, Westerman, Mark wrote:
> I am creating a rpm package for the gdm,
> Should the install script make changes to
> the policy files or inform the user of what
> changes should be made ?

This is a fundamental issue regarding SE Linux packaging.

In the current version we have a problem in that the rbac file entry as well

as the daemon.te file needs to be in place.  The next release will solve
this 
(which makes it easier to implement whichever policy we decide on).

The problem is that many people will not want to have critical things such
as 
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
