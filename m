Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5DIC161001876
	for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 14:12:01 -0400
Received: from web36615.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k5DIC0Cb027075
	for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 18:12:00 GMT
Message-ID: <20060613181112.24452.qmail@web36615.mail.mud.yahoo.com>
Date: Tue, 13 Jun 2006 11:11:12 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: polyinstantiating /tmp and gdm
To: russell@coker.com.au, janak@us.ibm.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200606140000.44403.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Russell Coker <russell@coker.com.au> wrote:

> Maybe a better option is to have the socket created
> under /var/run/.X11-unix 
> and have /tmp/.X11-unix be a sym-link to
> /var/run/.X11-unix.  Creating a new 
> sym-link under each poly directory is less work than
> doing yet another mount.  
> Note that this doesn't only apply to .X11-unix,
> there's .font-unix as well 
> and probably some other daemons out there doing
> other things.

Each of that daemons is going to have to
enforce (at least) MLS if you do this. While
this does make sense for the more sophisticated
programs (MLS X11 has been done, but my
recollections from the 1st SELinux forum was
that doing it again wasn't on anyone's list)
it is not a good notion for the little dumb
services.

The state of labeled networking is still a
bit rough for implementing policy enforcing
daemons.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
