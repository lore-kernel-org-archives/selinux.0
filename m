Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA11429
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 10:45:39 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA07785
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 15:44:40 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
        by jazzband.ncsc.mil  with SMTP id PAA07781 for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 15:44:40 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015242DD@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        SE Linux
	 <selinux@tycho.nsa.gov>
Subject: RE: gdm
Date: Mon, 25 Feb 2002 09:45:48 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

xlogin is fine with me

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au]
Sent: Monday, February 25, 2002 8:05 AM
To: Westerman, Mark; SE Linux
Subject: Re: gdm


On Mon, 25 Feb 2002 14:41, Westerman, Mark wrote:
> Now that you have modified the kdm to use SELinux I would
> agree that we to rename the gdm domain. I not on favor of
> renaming the xdm because there is a xdm program and does
> not totaly avoid the confusion.

I disagree.  xdm is the generic name "X Display Manager" and the program
that 
all the other programs are copied off (that's why the kdm code sucks so 
badly).

But if you can think of a name that's more logical than "xdm" then that'll
be 
fine.  The best I can think of now is "xlogin".

> How about sdm for (Security Display Manager) ?

Calling a domain "security" makes no sense in this context (every domain is
a 
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
