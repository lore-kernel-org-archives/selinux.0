Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h98DdIWt018949
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 09:39:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h98DdH7d021179
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 13:39:17 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h98DdHRn021176 for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 13:39:17 GMT
Subject: Re: A few clarifications - SID, Precondition functions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Vikram K <vikramatiitkdotacdotin@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031008085847.26164.qmail@web41015.mail.yahoo.com>
References: <20031008085847.26164.qmail@web41015.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1065620356.8181.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 08 Oct 2003 09:39:16 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-08 at 04:58, Vikram K wrote:
> Therefore, we thought of generalizing this process and instead of
> hardcoding a particular model into the existing code, we would add
> hooks that would be implemented by a loadable policy module (similar
> to the way in which LSM works). Particular policies can then be
> implemented in such modules. Such a framework, we felt, could be
> useful for indirectly extending the policy language by implementing
> these extensions as modules themselves. This is a highly unconfirmed
> statement, though, but we felt motivated enough to proceed.

I think that this is likely the wrong approach.  Rather than creating
yet another infrastructure within SELinux for loadable policy modules
(which is really what LSM is for), I'd suggest working on creating a
real module abstraction in the policy language and implementing support
for policy modules that can be reasonably bounded and can be checked for
violations of properties of the base policy.  I'd suggest reading the
following paper as background: 
T. Fraser and L. Badger, _Ensuring Continuity during Dynamic Security
Policy Reconfiguration in DTE_, Proceedings of the 1998 IEEE Symposium
on Security and Privacy,
http://www.computer.org/proceedings/s&p/8386/83860015abs.htm

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
