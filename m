Subject: Re: Latest Diffs.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <413331AD.1080709@redhat.com>
References: <412CAE6B.30006@redhat.com>
	 <200408282246.20447.russell@coker.com.au>  <413331AD.1080709@redhat.com>
Content-Type: text/plain
Message-Id: <1093881004.5447.93.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 30 Aug 2004 11:50:04 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-30 at 09:54, Daniel J Walsh wrote:
> I originally argued that can_ypbind should be part of can_network and 
> should continue to be.
> You have a boolean to turn off the ypbind, but if you run a network 
> application on a ypbind served
> machine you will hit many avc message about NIS.

Adding can_ypbind to can_network isn't necessarily sufficient, as a
program may not be a networking application at all (e.g. ls) and yet end
up pulling in NIS tables for a passwd lookup or similar.  You would get
fairly wide coverage by adding it to can_network, but not necessarily
complete coverage.  No easy answers; life would be easier if nscd were
used by default and gated all of these lookups.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
