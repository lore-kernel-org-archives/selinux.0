Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6LKxbHa016822
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2003 16:59:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6LKwWFB014701
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2003 20:58:32 GMT
Received: from zaphod.crypt.gen.nz (203-79-74-204.adsl.paradise.net.nz [203.79.74.204])
	by jazzswing.ncsc.mil  with ESMTP id h6LKwVGD014698
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2003 20:58:31 GMT
Message-ID: <1231.202.27.185.71.1058821169.squirrel@www.crypt.gen.nz>
Date: Tue, 22 Jul 2003 08:59:29 +1200 (NZST)
Subject: Re: selinux and redhat9
From: "Kerry Thompson" <kerry@crypt.gen.nz>
To: <selinux@tycho.nsa.gov>
In-Reply-To: <000001c34fb8$010e5880$6601a8c0@inspiron>
References: <000001c34fb8$010e5880$6601a8c0@inspiron>
Cc: <sreese@prcdigital.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Reese said:
> I have been an avid redhat user/admin for the last 3 years, and I'm
> interested to know where's the best place to get started with Q/A about
> this project obviously besides the original site???

Hi Stephen

There's many resources around covering most of the Linux distributions,
including RedHat.

Faye Coker's HOWTO (
http://sourceforge.net/docman/display_doc.php?docid=15285&group_id=21266 )
is a great place to start, although its based on Debian rather than RedHat
its well worth reading.

I wrote an article for SysAdmin magazine a while ago which introduces
SELinux on RedHat and looks at a policy for the BIND DNS server:
http://www.samag.com/documents/s=7835/sam0303a/0303a.htm.

TreSys have a number of good papers at http://www.tresys.com/selinux.html.

And there's my "UnOfficial FAQ" which is also worth looking at if you're
starting out: http://www.crypt.gen.nz/selinux/faq.html

.. and Russell Coker has an article in the upcoming August edition of
Linux Journal magazine which will be worth reading.

I recommend just giving it a go. Download the current SELinux release from
the NSA site, go through the README file and install it on a test system (
or on a spare disk drive, or whatever ). Look at how files are labelled,
and how the type enforcement rules work, then start making changes and
seeing what results you get. It may sound daunting at first, but after
you've got an installation running you'll find that its not particularly
hard at all.

Kerry





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
