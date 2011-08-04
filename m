Subject: Re: [PATCH 040/155] policycoreutils: setfiles: use glob to handle
 ~ and
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: eparis@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <4E39B710.3090709@redhat.com>
References: <4E39B710.3090709@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Aug 2011 10:59:51 -0400
Message-ID: <1312469991.20973.55.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-08-03 at 17:01 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> This patch looks good to me. acked.

I don't quite understand why this isn't handled by the shell before it
ever reaches setfiles.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
