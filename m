Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA05695
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 12:08:43 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA20482
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 16:07:32 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id QAA20478 for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 16:07:30 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
Date: Thu, 18 Apr 2002 18:08:28 +0200
References: <20020418112238.A1788@lemuria.org> <20020418145101.D31F444CB8@lyta.coker.com.au> <20020418171532.B6551@lemuria.org>
In-Reply-To: <20020418171532.B6551@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020418160829.1AF9F44D90@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 18 Apr 2002 17:15, Tom wrote:
> On Thu, Apr 18, 2002 at 04:51:01PM +0200, Russell Coker wrote:
> > > Absolutely. The problem is that you have a unified frontend with
> > > diversification at the backend. This is the same issue you have for
> > > ssh, except that ssh (and other remote login tools) have a method for
> > > changing to a specific user, based on user/password data.
> >
> > Ssh solves it by forking a new process and changing UID BEFORE doing any
> > work.
>
> Right. I want to do the same thing, but not with UIDs, but with
> domains.

Changing UIDs involves much the same process as changing domains.

If you want to get any support from Apache people etc then it's best if you 
talk about changing UID (something that they all understand).

> > > where user2's script contains something like:
> > > <? $f=fopen("../user1/script.php"); read($f); ?>
> >
> > What you could do is to have a unix domain socket named
> > /var/www/socket/user1 which the Apache process creates and then forks off
> > a child process to run all PHP code for user1 under the UID of that user,
> > and then pass back the data to Apache through the socket for
> > retransmission to the client.
>
> That requires changes in the apache code, which is bug-prone and will

No changes should be needed to the Apache code, just to the module code.  Of 
course that's still a major PITA...

> In essence, it boils down to: "a script (php, cgi, whatever) that
> belongs to user X can only access files of user X"

Doing it for cgi is easy enough.  I could easily hack something up if the NSA 
people don't release the MITRE code.

> The sole problem being that the scripts aren't executed in the
> unix-sense of execution, but by being loaded and interpreted by the
> apache process.

Which means that they can't be given a different UID and therefore they can't 
be given a different domain because domain transition can only occur at exec 
time (just like for SUID programs).

The concept you have is wrong, nothing will make domain transitions on module 
load work.

PHP via CGI with suexec may work if your PHP requirements are small enough.  
Otherwise you need some module changes.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
