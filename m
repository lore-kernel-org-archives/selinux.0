Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA09394
	for <selinux@tycho.nsa.gov>; Sun, 24 Feb 2002 23:24:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id EAA14776
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 04:23:46 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id EAA14772 for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 04:23:45 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: gdm
Date: Mon, 25 Feb 2002 05:24:31 +0100
References: <72222DC86846D411ABD300A0C9EB08A1015242C9@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A1015242C9@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <20020225042432.3A43D24A95@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 11 Feb 2002 14:46, Westerman, Mark wrote:
> I orginaly ported the gdm to selinux. The apm_bios
> is access by XFree86. I am not really sure what the
> XFree86 is doing with the bios, I can only guess it
> is trying to gather information about the graphics card
> or looking at the screen saving information (i.e blank
> the screen when not in use).

Perhaps we should have a separate domain for the X server and allow only the 
xdm type program to transition to it?

Also it would probably be a good idea to rename gdm to xdm to avoid confusion.

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
