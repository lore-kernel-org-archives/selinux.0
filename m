Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA27883
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 06:51:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id KAA23562
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 10:50:54 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id KAA23552
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 10:50:52 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: giovanni <giovanni@unirel.it>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Apache on SELinux
Date: Mon, 29 Jul 2002 12:51:25 +0200
References: <200207291212.26166.giovanni@unirel.it>
In-Reply-To: <200207291212.26166.giovanni@unirel.it>
MIME-Version: 1.0
Message-Id: <20020729105126.1138E69C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 29 Jul 2002 12:12, giovanni wrote:
> We are going to experiment apache web server on selinux. If someone has
> already done it, could give us some information or a configuration example?

A default configuration of SE Linux and a default configuration of Apache 
should work together without any problems.

However Apache is a very complex program with lots of options for 
configuration, and it's likely that you will choose configuration options 
that require modifications to the policy.  But it's difficult to predict what 
these are likely to be, run it in permissive mode at first and you'll soon 
see what needs to be changed.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
