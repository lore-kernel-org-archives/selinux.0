Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA14270
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 13:44:40 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA15510
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 17:43:28 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id RAA15504 for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 17:43:27 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
Subject: Re: newrules
Date: Thu, 25 Apr 2002 19:44:26 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <72222DC86846D411ABD300A0C9EB08A10152436B@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A10152436B@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <20020425174426.ED56C466B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 25 Apr 2002 18:42, Westerman, Mark wrote:
> > Also for the newrules.pl, "read" should usually be changed to
>
> r_file_perms
>
> > and "read write" should usually be changed to rw_file_perms.
>
> This is where we have a difference of option. I don't use the
> macros a whole lot. I test and retest the rules and behavior
> of the program I am creating. The newrules.pl will create
> a read and as you stated you should change to r_file_perms.
> This is where I disagree. Why grant extra permission
> such as for r_file_perms { read getattr access lock poll ioctl }

If you can read the entire file then what harm does poll or getattr do?  
ioctl and lock may be a bad idea, maybe we need another macro...

The problem that I have is that even with the macros the scope of the policy 
is expanding to the limits of what can be managed.  Looking at each specific 
attribute instead of classes such as r_file_perms would expand the amount of 
work significantly!

> if a program does not need a permission such as lock, poll and ioctl
> don't grant that permission. As we develop more finer grained access
> rules program should only be granted the permission they need
> and nothing else. In security terms only grant what is need.

I understand the point, however with the current sample policy I'm working on 
it is already over 10K lines of code.  The more code the harder it is to 
audit...

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
