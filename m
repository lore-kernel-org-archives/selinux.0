Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1OJCFRb025323
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 14:12:16 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1OJAalK006364
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 19:10:36 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i1OJAaOX006361
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 19:10:36 GMT
Subject: Re: Su(1) flaws (was: identity)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Rafal Wojtczuk <rafal.wojtczuk@7bulls.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040224180942.GA2322@warszawa.7bulls.com>
References: <20040224180942.GA2322@warszawa.7bulls.com>
Content-Type: text/plain
Message-Id: <1077649926.21221.155.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 24 Feb 2004 14:12:06 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-02-24 at 13:09, Rafal Wojtczuk wrote:
> 	In case of (*), the whole idea of "an unprivileged user to
> temporarily acquire another user's credential" is broken. If user "joe" reads
> his mail with a buggy mail client and also likes to "su" to root/sysadm_t, a
> buffer overflow in joe's mail client can result in total system compromise. 
> Yes, it requires a targetted attack. IIRC, monkey.org (which holds dsniff's
> homepage) was compromised some time ago in a similar way (someone cracked 
> "joe" account and was able to take over a su session left on "screen").

Mail client should run in its own domain.  screen likely needs to be a
policy enforcer for its "windows"; similar to the X server problem.

> 	Moreover, for (*) purposes su(1) must be executable by unprivileged 
> users (unless we restrict su to be mode 4750, group wheel by default;
> it is not so at least in Fedora). Therefore, if an unprivileged user 
> successfully exploits a buffer overflow in su or any library used, he gains 
> all su(1) privileges -> ability to transform to sysadm_t. This 
> (unnecessarily) enlarges the area prone to exploitation.

The su policy was amended for that reason when support was added for
context transitions; only staff_t and sysadm_t have su program domains
defined for them, and staff users were already authorized to use newrole
to transition to sysadm.  user_t cannot use su to change contexts (or in
fact at all) under the current policy.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
