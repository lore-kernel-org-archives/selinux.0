Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA01807
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 20:17:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id AAA20853
	for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 00:16:29 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id AAA20849 for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 00:16:27 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Debian User <rogelio@evoworks.evoserve.com>, selinux@tycho.nsa.gov
Subject: Re: initctl create denied
Date: Thu, 27 Jun 2002 20:18:07 -0400
References: <3D1BA3B4.2030404@evoworks.evoserve.com>
In-Reply-To: <3D1BA3B4.2030404@evoworks.evoserve.com>
MIME-Version: 1.0
Message-Id: <20020628001808.3ACD82CE3@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Jun 2002 19:45, Debian User wrote:
> I cant boot into enforcing mode after I made the update for screen.
> I used the latest debian packages. This is because init is denied access
> to initctl which has the wrong label.
>
> Jun 28 06:29:51 coffeesaur2 kernel: avc:  denied  { create } for  pid=1
> exe=/sbin/init path=/initctl scontext=system_u:system_r:init_t
> tcontext=system_u:object_r:tmpfs_t tclass=fifo_file

What is happening here?  Is it creating it under /tmp?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
