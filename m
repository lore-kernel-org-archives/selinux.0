Subject: Re: [PATCH 032/155] policycoreutils: fixfiles use new kernel
 seclabel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: eparis@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <4E39B680.4000106@redhat.com>
References: <4E39B680.4000106@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Aug 2011 10:58:05 -0400
Message-ID: <1312469885.20973.54.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-08-03 at 16:58 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> This patch looks good to me. acked.

When similar logic was added to setfiles, we included a kernel version
check (>= 2.6.30) to ensure that we didn't end up excluding all
filesystems on older kernels that do not report seclabel.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
