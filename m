Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA11340
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 10:35:23 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA25157
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 15:34:18 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA25153
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 15:34:16 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: gdm
Date: Mon, 25 Feb 2002 15:04:59 +0100
References: <72222DC86846D411ABD300A0C9EB08A1015242DC@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A1015242DC@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <20020225140500.0D792174@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 25 Feb 2002 14:41, Westerman, Mark wrote:
> Now that you have modified the kdm to use SELinux I would
> agree that we to rename the gdm domain. I not on favor of
> renaming the xdm because there is a xdm program and does
> not totaly avoid the confusion.

I disagree.  xdm is the generic name "X Display Manager" and the program that 
all the other programs are copied off (that's why the kdm code sucks so 
badly).

But if you can think of a name that's more logical than "xdm" then that'll be 
fine.  The best I can think of now is "xlogin".

> How about sdm for (Security Display Manager) ?

Calling a domain "security" makes no sense in this context (every domain is a 
security domain).  The only reason for calling something "security" in a SE 
Linux context is if it's something that's seriously related to security, but 
as the /ss_policy file has no mention of security in it's SID.

Currently the only mention of security in the SE Linux policy is the 
security_t domain.

-- 
Signatures >4 lines are rude.  If you send email to me or to a mailing list
that I am subscribed to which has >4 lines of legalistic junk at the end
then you are specifically authorizing me to do whatever I wish with the
message (the sig won't be read).

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
