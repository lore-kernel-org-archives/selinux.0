Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA03521
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 17:55:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA20041
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 21:54:10 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA20037
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 21:54:08 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: devfs change
Date: Mon, 26 Aug 2002 23:55:06 +0200
Cc: selinux@tycho.nsa.gov
References: <20020826211017.76011.qmail@web40005.mail.yahoo.com>
In-Reply-To: <20020826211017.76011.qmail@web40005.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020826215507.205E66B13@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 26 Aug 2002 23:10, Brad Chapman wrote:
> That makes sense. I asked because I have a modified version of your policy
> for my system (Red Hat 6.2) and don't want to have to modify your policy
> again. The way I plan to do it now is:
>
> 1. Make a diff between my policy and your policy that I started with.
> 2. Apply the diff against the old policy to the new policy, fix the fuzz
> and reject errors, and attempt to compile it to see if it makes sense.
>
> Is this a good way to keep my changes, yet enjoy your changes as well?

That's the best you can do.

I've put a copy of my policy tree on 
http://www.coker.com.au/selinux/policy.tgz , the release version shouldn't be 
much different.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
