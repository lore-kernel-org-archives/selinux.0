Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA01094
	for <selinux@tycho.nsa.gov>; Fri, 15 Mar 2002 15:22:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA02313
	for <selinux@tycho.nsa.gov>; Fri, 15 Mar 2002 20:21:14 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id UAA02306 for <selinux@tycho.nsa.gov>; Fri, 15 Mar 2002 20:21:12 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: stat now supports SE Linux in the upstream
Date: Fri, 15 Mar 2002 21:21:55 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0203150900430.15480-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0203150900430.15480-100000@raven>
MIME-Version: 1.0
Message-Id: <20020315202156.23F471ECB1@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 15 Mar 2002 15:10, Stephen Smalley wrote:
> > The latest version of stat has SE Linux support, so there's probably no
> > need for the patch on the NSA site, just a reference that version 3.1 is
> > needed.
>
> This is good to hear - I take it that you submitted the SELinux changes to
> the stat maintainer?  If so, then thanks.  One caveat:  the utility

Not sure whether this was directly related to me.  The code is mostly the 
same and it seems unlikely that they got it from somewhere else (and the bug 
in the current iteration suggests that the upstream maintainer is not running 
SE Linux).  But it could have been due to someone else.

I just sent my patches to the Debian maintainer and let them send it to the 
upstream.

> modifications aren't necessarily in the form that I would like to see
> mainstreamed (many of them were done as quick learning exercises by
> others, and we haven't cleaned them up).  For example, some of the modified
> utilities use a fixed size buffer for the security context and fail if the
> buffer size is too small rather than resizing and trying again.  See the
> sid_to_context test program for how to correctly handle this.

I'll have to look into that.

> We're likely to continue distributing our modified stat until the new
> version is picked up by RedHat as a convenience to our users.

It might be quite some time before RH do that.  IMHO just telling users where 
to get a suitable version is enough, but it's your call.

> > There is a bug in displaying the context though, the following patch
> > fixes it.
>
> I assume that you've submitted this patch to the stat maintainer.

Yes.  The reason why my message was corrupted is that kmail has a bug related 
to copying from one message to another.  I did a cut/paste from the 
confirmation message of my Debian bug report.

It should be fixed in Debian RSN, and in upstream not long after.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
