Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA12200
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 12:21:21 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA13034
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 17:20:22 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id RAA13030 for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 17:20:20 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
Subject: Re: gdm
Date: Mon, 25 Feb 2002 18:21:08 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <72222DC86846D411ABD300A0C9EB08A1015242DF@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A1015242DF@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <20020225172108.5A90313539@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 25 Feb 2002 17:51, Westerman, Mark wrote:
> If you would like I will try and redo the gdm domain
> to follow this guidline and make the change to xdm_t.
>
> Russell did you need to make modifications to the
> domain for the kdm ?

No, but as my system is still running in debugging mode (and producing 
hundreds of kernel messages about security policy denying operations - so 
many that I haven't even looked at a fraction of them) I can't be sure that 
I've got all the necessary rules.

It shouldn't be difficult to change it later, if nothing else what I have 
currently sent out will be a good starting point for other interested people.

-- 
Signatures >4 lines are rude.  If you send email to me or to a mailing list
that I am subscribed to which has >4 lines of legalistic junk at the end
then you are specifically authorizing me to do whatever I wish with the
message (the sig won't be read).

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
