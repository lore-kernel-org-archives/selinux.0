Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0AEe8Ii029337
	for <selinux@tycho.nsa.gov>; Mon, 10 Jan 2005 09:40:08 -0500 (EST)
Received: from smtp816.mail.sc5.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j0AEcDXK025946
	for <selinux@tycho.nsa.gov>; Mon, 10 Jan 2005 14:38:13 GMT
Message-ID: <41E293C2.9040608@sbcglobal.net>
Date: Mon, 10 Jan 2005 08:40:02 -0600
From: Lee <FriedBob@sbcglobal.net>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: audit ... denied messages
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I just installed all the SELinux stuff on a Slackware 10 box using a
2.6.7 kernel.  I tried going about it myself, but wasn't making good
progress and then found some packages from http://www.diyab.net/selinux/
and installed those.

When I first booted with SELinux=1, I saw a bunch of audit <...> denied
<...> <program> <context> messages during my init and such.

Everything "seemed" to still be working, as far as my system went, so I
tried logging in, and it worked.  When I did a make relabel, it seemed
to work, but when I later checked dmesg for something, I had several
screens (at approx 132x60) full of these audit ... denied messages, all
in relation to relabeling.

So my questions have a few aspects to them.  Namely, do I need to be
concerned about these messages, and what can I do to make them go away?
~ I don't really know what I'm doing here and am probably not as read up
as I should be, but I suspect, and am hoping, that this is just due to
the way my policiy is set up and will be easy to correct.

I'd appreciate any help, and I'll be going through the docs that I do
have while waiting for a response from here.  FWIW, pointers to (more)
docs that address this would be more appreciated than just "do this,
that and the other", but I'll take what I can get, and will appreciate it.

Thanks.
- --
~  == FriedBob ==

"Hence to fight and conquer in all your battles is not supreme
excellence; supreme excellence consists in breaking the enemy's
resistance without fighting."
~  - Sun Tzu
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFB4pPCvxumKxmOCzIRAgqGAJ9ou5odZNFcdzcm7nYesBoGgL49bACfTSTB
EDKSkIARGuxrSuN+z0shozA=
=bQMP
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
