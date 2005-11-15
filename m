Subject: Re: [PATCH] move genhomedircon call out of transaction
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Sellers <csellers@tresys.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux-dev@tresys.com,
   selinux@tycho.nsa.gov
In-Reply-To: <200511141709.43445.csellers@tresys.com>
References: <200511141709.43445.csellers@tresys.com>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 08:23:44 -0500
Message-Id: <1132061024.5415.338.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-14 at 17:09 -0500, Chad Sellers wrote:
> Attached is a patch that moves the genhomedircon patch out of the libsemanage 
> transaction.  This is necessary since genhomedircon now uses libsemanage, and 
> enters a transaction itself.

Thanks, merged as of libsemanage 1.3.54.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
