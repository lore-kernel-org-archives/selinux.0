Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA24826
	for <selinux@tycho.nsa.gov>; Sun, 11 Aug 2002 15:23:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA00638
	for <selinux@tycho.nsa.gov>; Sun, 11 Aug 2002 19:22:54 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id TAA00634
	for <selinux@tycho.nsa.gov>; Sun, 11 Aug 2002 19:22:53 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Swollen su_macros.te file
Date: Sun, 11 Aug 2002 21:23:39 +0200
References: <20020811185607.42370.qmail@web40006.mail.yahoo.com>
In-Reply-To: <20020811185607.42370.qmail@web40006.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020811192339.946248662@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 11 Aug 2002 20:56, Brad Chapman wrote:
>       Lately I have noticed that my su_macros.te file is becoming
> unmanageable due to the enormous amount of stuff that I use su for. Could
> you (and the list) please review my su_macros.te file and tell me how to
> make it smaller?

I think that you have something wrong with your setup.  The $1_su_t domain is 
only to be used for the "su" program, I think that you are using the shell in 
that domain too for some reason.

$1_su_t should not have access to man pages, home directories, sysctl,  
debian_menu_t, device files, boot_t, etc.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
