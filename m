Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1HMMqdW002313
	for <selinux@tycho.nsa.gov>; Thu, 17 Feb 2005 17:22:52 -0500 (EST)
Received: from oe-im2.bizmailsrvcs.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1HMJ4qo000850
	for <selinux@tycho.nsa.gov>; Thu, 17 Feb 2005 22:19:04 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
Cc: "'Juan Espino'" <jp_espino@hotmail.com>
Subject: RE: Bell & Lapadula Model
Date: Thu, 17 Feb 2005 17:21:21 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Xine.LNX.4.44.0502171518030.7638-100000@thoron.boston.redhat.com>
Message-Id: <20050217222122.HGPG7908.mm-ismta4.bizmailsrvcs.net@FLM800>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > SELinux enforces a Mandatory Access Control (MAC) Policy based on Bell 
> > and Lapadula Model.  I understand the read control property (no read 
> > up) and the write control (no write down), but in this model there are 
> > another property called tranquility property, I don't know very well 
> > how SELinux enforces this property,
>
> SELinux includes an experimental MLS implementation based on BLP.  This
feature is 
> not currently enabled in Fedora.
>
> Thus, it may be better to discuss the MLS component on the NSA list:
> http://www.nsa.gov/selinux/info/list.cfm?MenuID=41.1.1.9

To be clear, SELinux as most people think about it implements type
enforcement as its MAC, and *not* BLP (i.e., MLS) as you seem to assert. As
James notes the current MLS feature is experimental though there is work to
make it more integral for future release.

With regard to tranquility, it's a property of object/subject labeling,
i.e., that once set security contexts do not change in order to maintain a
consistent security policy throughout all system states. This is an
interesting property for any MAC mechanisms (TE and MLS), and one that is
often by-passed in applications of MAC (because its hard to live within MAC
restrictions, especially the MLS kind). There's a intense debate in the NSA
mail list about security context tranquility for processes, and IMHO, good
TE policies should have greater limitations on all security context changes.

Frank


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
