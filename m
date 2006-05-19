Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4JDvXgn005279
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 09:57:33 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4JDvUk7014325
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 13:57:31 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Maria Iano <maria@iano.org>
Subject: Re: correct way to set context in perl?
Date: Fri, 19 May 2006 23:57:35 +1000
Cc: Erich Schubert <erich@debian.org>, selinux@tycho.nsa.gov
References: <20060518160656.V26098@iano.org> <1147985248.3617.2.camel@wintermute.xmldesign.de> <20060518171245.Y26098@iano.org>
In-Reply-To: <20060518171245.Y26098@iano.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605192357.39325.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 19 May 2006 07:12, Maria Iano <maria@iano.org> wrote:
> Thanks for your response. The master and slave directories are separate.
> The zones are divided into over a hundred different groups (and growing).
> Individual users have access to edit zones in some groups and not others.
> Each group has its own directory. Under each group's directory are the
> master and slave directories. As new groups are created (by the perl
> scripts), new directories need to be created (as well as new files) and I
> need to be able to give them the correct security contexts, and there will
> be two different types under each group directory.

Why would each group require a separate slave directory?

The only reason why a user might need direct access to the slave directory is 
to read files (for converting a slave into a master) and to unlink files 
(after removing them from the BIND configuration).

Given that DNS data is essentially public allowing all groups to read each 
other's data is not going to do any harm.  Also as the data is regenerated as 
needed and always kept fresh the unlink problem can be solved by a cron job 
that runs once per month and deletes old slave files.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
