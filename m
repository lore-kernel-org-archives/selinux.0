Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA16365
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 12:10:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA28310
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 16:09:16 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id QAA28306 for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 16:09:14 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Timothy Wood <timothy@hallcomp.com>
Subject: Re: ssh and fs relabel (new release)
Date: Wed, 28 Aug 2002 18:10:44 +0200
References: <1030541100.2059.18.camel@phobos> <20020828134511.DAFDD8FDA@lyta.coker.com.au> <1030549849.2346.59.camel@phobos>
In-Reply-To: <1030549849.2346.59.camel@phobos>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020828161045.4E6F69033@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 28 Aug 2002 17:50, you wrote:
> > However, be aware that making such changes grants anyone who has port 22
> > access to your machine full administrative access if (when?) another bug
> > is discovered in sshd...
>
> So then I need to login under someone with user_r:user_t and then
> newrole and su correct?

It's your call.

If you have port 22 firewalled so that only trusted people can connect to it 
then allowing an administrative login may make sense.

> > It's expected that the policy source files have type policy_src_t...
>
> Is this an error in the file_context policies or do I just have selinux
> in an abnormal directory (/usr/src/selinux)?  This is stock and I
> haven't changed any of the policies yet.

I'm not sure what the plan is in that regard.  I never test the stock 
install, I concentrate on my Debian packages.

> Also, how broken are the user admin programs?  I tried adding a user,
> which didn't work, and I remember seeing you post some fixes for
> suseradd.  Are they partly functional or broken?  The suseradd in the
> new release appears to work in premissive mode (denied in enforcing).
> The spasswd program is a different story.  It tells me it doesn't take
> an argument (such as spasswd <username> ) so I don't see how you set an
> initial password for a new user.

sadminpasswd is for setting a password for a new user.  spasswd is for that 
user to change their own password.

How did suseradd fail?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
