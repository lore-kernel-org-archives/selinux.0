Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h45GNHI4027831
	for <selinux@tycho.nsa.gov>; Mon, 5 May 2003 12:23:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h45GNG7R029127
	for <selinux@tycho.nsa.gov>; Mon, 5 May 2003 16:23:16 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h45GNFKP029124 for <selinux@tycho.nsa.gov>; Mon, 5 May 2003 16:23:15 GMT
Subject: Re: Support for XWindows ?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Akshay Gangam <gvakshay@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20030503004232.1113.qmail@web20805.mail.yahoo.com>
References: <20030503004232.1113.qmail@web20805.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1052151794.1377.770.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 05 May 2003 12:23:14 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-05-02 at 20:42, Akshay Gangam wrote:
> I have a running installed on a stand alone system,
> with lsm2.4+selinux+RH8.0 on it. 
> The kernel is in permissive mode, but I have not moved
> to enforcing mode, since I not sure of the support for
> XWindows. Does changing is enforcing mode, leave me
> deprived of Emacs/Xwindows to read documentation or to
> open multiple terminal sessions ?

You need to enable the X-related domains (via sepcut or by directly
moving up the .te files from policy/domains/program/unused) and reload
your policy.  You also need a patched [xgk]dm if you want to run an X
Display Manager; we don't provide one, but others have supplied patches.
With regard to knowing whether it is safe to move to enforcing mode, you
need to study your logs (dmesg output or /var/log/messages) to see what
would be denied if you were to switch into enforcing mode.  Keep in mind
that a denial is typically only logged once when in permissive mode (and
then retained in the cache until you reload your policy or switch into
enforcing mode), so you need to check the full log from when you booted.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
