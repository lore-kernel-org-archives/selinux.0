Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA28621
	for <selinux@tycho.nsa.gov>; Sat, 13 Jul 2002 00:05:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id EAA02519
	for <selinux@tycho.nsa.gov>; Sat, 13 Jul 2002 04:04:33 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id EAA02515
	for <selinux@tycho.nsa.gov>; Sat, 13 Jul 2002 04:04:31 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: revising the su decision
Date: Sat, 13 Jul 2002 06:04:56 +0200
References: <20020712111941.30466.qmail@web40009.mail.yahoo.com> <63597.137.246.8.231.1026493819.squirrel@austin.bmh.com> <20020712200607.C26001@lemuria.org>
In-Reply-To: <20020712200607.C26001@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020713040456.9455A766B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Jul 2002 20:06, Tom wrote:
> b) so, what you need is a trusted process ON the machines. ideally,
> with a policy crafted specifically for it. I'll call this process
> instwa, the "install watcher". it could be as simple as a cronjob
> called every 5 minutes that essentially does:
>
> if ( any file in /var/install ) then ( rpm/dpkg/whatever -i $file )
>
> c) give your remote/install user write priviledges for /var/install

If someone can write to /var/install in that case, then why not just allow 
them to login directly with full admin privs?

Writing a RPM or DEB package to take over or destroy a system is easy 
enough...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
