Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h82CLbLa015184
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 08:21:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h82CLZet020962
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 12:21:36 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h82CLZlq020959 for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 12:21:35 GMT
Subject: Re: getting sids
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Diyab <diyab@diyab.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <d6c88ab9c32238e8614baa747f3704ab@ziggy.r00td0wn.net>
References: <d6c88ab9c32238e8614baa747f3704ab@ziggy.r00td0wn.net>
Content-Type: text/plain
Message-Id: <1062505293.18568.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 02 Sep 2003 08:21:33 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-08-30 at 23:40, Diyab wrote:
> Is there any difference between get_default_sid and get_user_sid other than the fact that get_user_sid also returns a context?  Mostly I'm wondering why get_default_sid was used in the vixie cron code instead of get_user_sid.  Also I noticed there is a cron_get_user_sid defined in the get_user_sid.h but it is not used anywhere in the cron code.  Is there a reason for this and would it be better to use that instead of get_default_sid?

get_user_sid is obsolete.  For that matter, all of libsecure is
obsolete; the 2.6-based SELinux required a complete API overhaul, and
the new 2.4-based SELinux (back port of 2.6-based SELinux) also uses the
new API, which is encapsulated by libselinux.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
