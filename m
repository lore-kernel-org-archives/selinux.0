Subject: Re: [PATCH] secon makefile
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, kvance@tresys.com
In-Reply-To: <1154528354.9510.2.camel@twoface.columbia.tresys.com>
References: <1154528354.9510.2.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 10:35:49 -0400
Message-Id: <1154615749.32479.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-02 at 10:19 -0400, Joshua Brindle wrote:
> The secon makefile did not correctly respect DESTDIR so building the
> repo in a sandbox was not possible. 

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
