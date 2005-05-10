Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4AJFogA012606
	for <selinux@tycho.nsa.gov>; Tue, 10 May 2005 15:15:50 -0400 (EDT)
Received: from smtp-bedford-dr.mitre.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4AJDH6B016786
	for <selinux@tycho.nsa.gov>; Tue, 10 May 2005 19:13:17 GMT
Received: from smtp-bedford-dr.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford-dr.mitre.org (8.11.6/8.11.6) with SMTP id j4AJDRa12275
	for <selinux@tycho.nsa.gov>; Tue, 10 May 2005 15:13:27 -0400
Received: from smtp-bedford-dr.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford-dr.mitre.org (Postfix) with ESMTP id C0F094F8D7
	for <selinux@tycho.nsa.gov>; Tue, 10 May 2005 15:13:27 -0400 (EDT)
To: =?utf-8?q?Lorenzo_Hern=C3=A1ndez_Garc=C3=ADa-Hierro?= <lorenzo@gnu.org>
Cc: ubuntu-hardened@lists.ubuntu.com, selinux@tycho.nsa.gov
Subject: Re: [selinux] HOWTO Install SELinux on Ubuntu
References: <1115152564.15188.24.camel@localhost.localdomain>
From: bsniffen@mitre.org (Brian T. Sniffen)
Date: Tue, 10 May 2005 15:13:10 -0400
In-Reply-To: <1115152564.15188.24.camel@localhost.localdomain> (
 =?utf-8?q?Lorenzo_Hern=C3=A1ndez_Garc=C3=ADa-Hierro's_message_of?= "Tue, 03
 May 2005 22:36:03 +0200")
Message-ID: <d28acn2j3nd.fsf@jon-strange.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Lorenzo Hernández García-Hierro <lorenzo@gnu.org> writes:

> It's currently available at:
> http://wiki.tuxedo-es.org/HOWTO_Install_SELinux_on_Ubuntu
>
> If you want to edit something, feel free to do it, but it would be good

Thanks for writing this up.  I tried to follow the instructions on an
Ubuntu machine, but had serious problems:

* The basic packages (e.g., coreutils) installed fine.  I had some
  difficulties with the selinux-aware PAM 0.78 packages: they
  complained about a missing module in pam_authenticate.  It was
  somewhat annoying to debug this, since it caused login and sudo to
  fail.  I never did solve this problem, because I gave up on:

* The selinux-policy-targeted package in your suggested repository fails to
  install.  There is no appconfig directory.

* The selinux-policy-default package also fails to install.  There are
  many .te files without corresponding .fc files.  The postinst script
  exits with status 1, apparently failing to copy policy/default to
  policy/current.

* Those two policy packages conflict in practice, but have neither
  diversions nor explicit Conflict headers.

* There is no selinux-support package in your selinux/ubuntu apt
  repository---only over in selinux/debian.

This looks like a great project---I'd be very happy to have a second
Desktop SE Linux project for which to develop in parallel with Fedora.
It would help, I think, resolve what are elements of a Desktop SE
Linux install, and what features are really Red Hat's, not necessary
to SE Linux.

But right now, I don't think it's ready for prime time.  Since
unhorking a machine with broken PAM is a bit tricky, perhaps you could
add a note to the top of your web page explaining that the following
instructions may break your machine, and to be exceptionally careful
about having a backout-path before attempting them.

-Brian



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
