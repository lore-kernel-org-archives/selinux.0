Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6T0nQrT015383
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 20:49:26 -0400 (EDT)
Received: from smtp808.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6T0mtVb028317
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 00:48:55 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp808.mail.ukl.yahoo.com with SMTP; 29 Jul 2004 00:49:25 -0000
Date: Thu, 29 Jul 2004 02:00:31 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Erich Schubert <erich@debian.org>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [idea] multiple contexts.
Message-ID: <20040729010031.GB4335@lkcl.net>
References: <20040724231154.GE3437@lkcl.net> <1090858323.24945.116.camel@moss-spartans.epoch.ncsc.mil> <20040727160605.GG3392@lkcl.net> <1090949595.2448.180.camel@moss-spartans.epoch.ncsc.mil> <20040727182340.GW3392@lkcl.net> <20040728231630.GA3948@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040728231630.GA3948@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 29, 2004 at 01:16:30AM +0200, Erich Schubert wrote:
> Hi,
> 
> On the multiple contexts thing:
> The power set of a finite set is still finite. I.e. you don't need to
> have multiple context if you are willing to manage enough contexts.
> It's just a matter of writing appropriate macros...

> Why not define roles "kde_with_shell_r" and "kde_without_shell_r" and
> write appropriate access rules? (or: "kde_full_r" and "kde_limited_r")

 i've just noticed the sudo_domain() macros, and their friends
 irc_domain() and sendmail_ etc.

 whilst i don't yet sufficiently get the principle of these
 to make use of it properly (i tried earlier today) i at least
 understand what they are intended to do: to "combine" what
 i perceive to be two contexts (user_t and kde_t).

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
