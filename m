Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6SNGSrT014978
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 19:16:33 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6SNFvVb025645
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 23:15:58 GMT
Date: Thu, 29 Jul 2004 01:16:30 +0200
From: Erich Schubert <erich@debian.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [idea] multiple contexts.
Message-ID: <20040728231630.GA3948@wintermute.xmldesign.de>
References: <20040724231154.GE3437@lkcl.net> <1090858323.24945.116.camel@moss-spartans.epoch.ncsc.mil> <20040727160605.GG3392@lkcl.net> <1090949595.2448.180.camel@moss-spartans.epoch.ncsc.mil> <20040727182340.GW3392@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040727182340.GW3392@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On the multiple contexts thing:
The power set of a finite set is still finite. I.e. you don't need to
have multiple context if you are willing to manage enough contexts.
It's just a matter of writing appropriate macros...
You could name your contexts like sysadm_kde_mail_foobar_something
for the context having the access rights of sysadm, kde, mail etc.

The thing is: you don't want to allow any combination.
For example you don't want a context which can use both KDE and write to
system applications. Keeping such things exclusive is a good thing.
When you allow multiple context you would need to write many rules like
"when switching to context xyz, drop context foo" - that is not better.

Why not define roles "kde_with_shell_r" and "kde_without_shell_r" and
write appropriate access rules? (or: "kde_full_r" and "kde_limited_r")

This makes it a lot easier to verify.

Also you avoid conflicts, rules are explicit. kde_full_r can exec xterm,
kde_limited_r cannot. You can't have the case that a user has both
contexts - should he be allowed access or not?

Greetings,
Erich Schubert
-- 
    erich@(mucl.de|debian.org)      --      GPG Key ID: 4B3A135C    (o_
     Go away or i'll replace you with a very small shell script.    //\
    Der Anfang aller Erkenntnis ist das Staunen. --- Aristoteles    V_/_

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
