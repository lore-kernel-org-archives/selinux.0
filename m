Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA06165
	for <selinux@tycho.nsa.gov>; Fri, 13 Sep 2002 07:09:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA14824
	for <selinux@tycho.nsa.gov>; Fri, 13 Sep 2002 11:07:49 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id LAA14799 for <selinux@tycho.nsa.gov>; Fri, 13 Sep 2002 11:07:47 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>
Subject: Re: uml policy
Date: Fri, 13 Sep 2002 11:01:18 +0200
Cc: selinux@tycho.nsa.gov
References: <20020912201240.B2594@lemuria.org> <200209130053.55563.russell@coker.com.au> <20020913073553.D2818@lemuria.org>
In-Reply-To: <20020913073553.D2818@lemuria.org>
MIME-Version: 1.0
Message-Id: <200209131101.18761.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 13 Sep 2002 07:35, Tom wrote:
> > You possibly don't want the system to run it (but that is debatable),
> > however you certainly want to be able to install a kernel as the
> > administrator and have regular users execute it.
>
> Shouldn't chcon be able to do that?

chcon/chsid changes the context, but you have to create the policy that allows 
the changes in question and defines suitable types to be used.

Also it might be best to set things up such that the user can create (and 
remove!) a hard link to a kernel or backing store file created by the 
administrator.  Then the UML is stuck to it's own directory.

> > Chroot is probably too heavy, irc is simpler and easier to copy from. 
> > For keystroke logger files I guess you could make them append-only.  Or
> > you could use the same read-write file you use for the data store.
>
> Definitely append only, but the problem is that they are created on
> runtime, not like logfiles where you can assume that it exists when you
> execute.

You can allow create and append access but no write or unlink...

> And they are always created in the uml dir. I'll look into the uml
> source what exactly is hardcoded there. I would definitely prefer them
> to be in their own subdir.

Is the fact that they are created in the UML directory interfering with the 
policy you desire?  Or is it just a general UML usability issue?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
