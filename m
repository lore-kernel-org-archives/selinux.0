Subject: Re: Old libselinux bug.  We are leaking a file descriptor.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46F7DAA9.2040408@redhat.com>
References: <46F7DAA9.2040408@redhat.com>
Content-Type: text/plain
Date: Mon, 24 Sep 2007 12:28:27 -0400
Message-Id: <1190651307.487.45.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-09-24 at 11:41 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> This bug causes dbus to leak file descriptors when autostarting confined
> applications.
> 
> Should be able to remove
> 
> 	ifdef(`hide_broken_symptoms', `
> 		dontaudit $2 $1_dbusd_t:netlink_selinux_socket { read write };
> 	');
> 
> - From policy.

Applied.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
