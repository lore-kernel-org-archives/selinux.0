Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TMTi5U003494
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 18:29:44 -0400
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Re: label for /proc directory (before mounting)
Date: Thu, 30 Mar 2017 09:29:25 +1100
References: <1490821242.510644.927878696.6DEBD3A9@webmail.messagingengine.com>
In-Reply-To: <1490821242.510644.927878696.6DEBD3A9@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201703300929.25931.russell@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 30 Mar 2017 08:00:42 AM Colin Walters wrote:
> This causes some breakage in rpm-ostree (which I can work
> around), but I'd like a better fix than what I did above.
> Any suggestions?  It probably doesn't
> matter too much what the actual type is since systemd will
> overmount it - should I make it the same type as e.g. `/mnt`?

I've been thinking of submitting a patch for /proc and other mountpoints to be 
mnt_t or root_t for some time.  Your suggestion sounds good to me.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
