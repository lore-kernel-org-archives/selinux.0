Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA10725
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 08:41:37 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA19452
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 13:40:26 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzswing.ncsc.mil  with SMTP id NAA19448
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 13:40:22 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015242DC@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        SE Linux
	 <selinux@tycho.nsa.gov>
Subject: RE: gdm
Date: Mon, 25 Feb 2002 07:41:34 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Now that you have modified the kdm to use SELinux I would 
agree that we to rename the gdm domain. I not on favor of 
renaming the xdm because there is a xdm program and does
not totaly avoid the confusion.
How about sdm for (Security Display Manager) ? 
Or may be something else to avoid the confusion
of kdm, gdm and xdm.

Mark

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au]
Sent: Sunday, February 24, 2002 10:25 PM
To: Westerman, Mark; SE Linux
Subject: Re: gdm


On Mon, 11 Feb 2002 14:46, Westerman, Mark wrote:
> I orginaly ported the gdm to selinux. The apm_bios
> is access by XFree86. I am not really sure what the
> XFree86 is doing with the bios, I can only guess it
> is trying to gather information about the graphics card
> or looking at the screen saving information (i.e blank
> the screen when not in use).

Perhaps we should have a separate domain for the X server and allow only the

xdm type program to transition to it?

Also it would probably be a good idea to rename gdm to xdm to avoid
confusion.

> Have you include the code in the xdm to login a
> user ?

I've just done that.  Hopefully it'll be in the Debian kdm package soon and 
in the upstream KDE source in the near future.

-- 
Signatures >4 lines are rude.  If you send email to me or to a mailing list
that I am subscribed to which has >4 lines of legalistic junk at the end
then you are specifically authorizing me to do whatever I wish with the
message (the sig won't be read).

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
