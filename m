Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA16716
	for <selinux@tycho.nsa.gov>; Sun, 7 Jul 2002 17:47:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA14269
	for <selinux@tycho.nsa.gov>; Sun, 7 Jul 2002 21:46:26 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA14265
	for <selinux@tycho.nsa.gov>; Sun, 7 Jul 2002 21:46:24 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <blacknet@simplyaquatics.com>
Subject: Re: fingerd (was  new packages)
Date: Sun, 7 Jul 2002 17:46:11 -0400
References: <006401c225fc$95ccabc0$0a01a8c0@ed>
In-Reply-To: <006401c225fc$95ccabc0$0a01a8c0@ed>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020707214611.782C13E96@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 7 Jul 2002 17:23, you wrote:
> If I make a
> /usr/share/selinux/policy/current/file_contexts/program/fingerd.fc file
> shouldn't the contents be this?
>
> /usr/sbin/in.fingerd               system_u:object_r:fingerd_exec_t

Yes, that should be OK.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
