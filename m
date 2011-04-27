Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3RNUFTI023728
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 19:30:15 -0400
Received: from cp-out9.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p3RNUEfH010476
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2011 23:30:14 GMT
Subject: Re: Is there difference betweek sefiles and restorecon in terms of
 labels
From: Guido Trentalancia <guido@trentalancia.com>
To: Sam Gandhi <samgandhi9@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Thu, 28 Apr 2011 01:30:12 +0200
In-Reply-To: <BANLkTi=23O4bO-mDgKectp3_xXpCOXFxmw@mail.gmail.com>
References: <BANLkTi=23O4bO-mDgKectp3_xXpCOXFxmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1303947012.2648.28.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Sam !

Restorecon is a symbolic link to setfiles.

Setfiles probably offers more options. Most notably, I think you can
choose the file contexts definitions (as far as I remember undocumented,
see belove).

I shall quote the code:

                /* 
                 * setfiles:  
                 * Recursive descent,
                 * Does not expand paths via realpath, 
                 * Aborts on errors during the file tree walk, 
                 * Try to track inode associations for conflict detection,
                 * Does not follow mounts,
                 * Validates all file contexts at init time. 
                 */

                /*
                 * restorecon:  
                 * No recursive descent unless -r/-R,
                 * Expands paths via realpath, 
                 * Do not abort on errors during the file tree walk,
                 * Do not try to track inode associations for conflict detection,
                 * Follows mounts,
                 * Does lazy validation of contexts upon use. 
                 */

Hope it helps. Please double-check for correctness.

Least but not last: there are a few undocumented options that I have
tried to document in a patch (see PATCH[1/2] and PATCH[2/2] that I
posted here on Sun, 20 Feb 2011 09:56:48 +0100).

Regards,

Guido

On Wed, 2011-04-27 at 15:59 -0700, Sam Gandhi wrote:
> Looking at man pages of sefiles and restorecon , both mention that
> they initialize security context database ( extended attributes) on
> one or more filesystems.
> 
> There are certainly differences between command line arguments, but
> can these programs be used interchangeably as far as extended
> attributes they assign to files?
> 
> -Sam
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
