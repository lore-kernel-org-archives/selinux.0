Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3OKY6I4010746
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 16:34:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3OKY57R008265
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 20:34:05 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h3OKY5KP008262 for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 20:34:05 GMT
Subject: Re: role orthogonality
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Robert Bihlmeyer <robbe@orcus.priv.at>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87ist9eem5.fsf@orcus.priv.at>
References: <87ist9eem5.fsf@orcus.priv.at>
Content-Type: text/plain
Message-Id: <1051216245.20300.141.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 24 Apr 2003 16:30:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-04-20 at 04:51, Robert Bihlmeyer wrote:
> One thing that I still poorly understand is the interaction between
> types and roles.
> 
> Am I right that roles are only relevant when transitioning, and not
> during normal type enforcement?

Yes, roles only come into play on process transitions, based on the role
allow rules and the constraints configuration.  Roles are merely a layer
of abstraction for grouping related domains together and assigning them
to users.  They can provide a limited form of boundary between sets of
domains (i.e. by limiting a user to certain roles, you bound the set of
domains he can reach), but even here, you are truly relying on TE to
deal with all possible interactions between those domains (i.e.
non-transition forms of interactions).

> It seems to me that we often want to break that orthogonality, so we
> encode the role in the type (e.g. sysadm_tty_device_t vs
> user_tty_device_t). I find this ugly, boring and repetitive -- exactly
> the kind of thing that computers should shield us from. 

This is actually a type derivation (sysadm_tty_device_t is a type
derived from sysadm_t and tty_device_t), not role encoding.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
