Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA17215
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 13:31:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA07540
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 17:30:45 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id RAA07536
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 17:30:43 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Samarth Sharma" <samarth7880@rediffmail.com>, selinux@tycho.nsa.gov
Subject: Re: Help required
Date: Fri, 9 Aug 2002 19:31:29 +0200
References: <20020809084005.24422.qmail@webmail8.rediffmail.com>
In-Reply-To: <20020809084005.24422.qmail@webmail8.rediffmail.com>
MIME-Version: 1.0
Message-Id: <20020809173129.E5677809B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 9 Aug 2002 10:40, Samarth  Sharma wrote:
>      1.Does SELinux provide application transparency(like Flask
> proposes)?

Most applications can run unchanged without needing to know anything about SE 
Linux.

>      2.If yes then what level of applications can be transprent to
> the security architecture underneath.

I'm not sure what you mean by this.

>      3.If no what has to be done to make it security aware?

Usually nothing.  The only programs that REALLY need changes are login, sshd, 
and cron.

>      4.What would happen in case of daemons?

Generally they have their own daemon domain.

>      5.If I write an application for seLinux who will be   the
> object manager or do i have to code the object manager myself.

The kernel.

You really should try out SE Linux.  We could spend several months answering 
your questions and you still probably wouldn't get the whole picture.  Spend 
a day or two installing SE Linux on a spare machine and you'll get it much 
sooner.

Also login to #selinux on irc.openprojects.net.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
