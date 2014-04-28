Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3SECqQO026875
 for <selinux@tycho.nsa.gov>; Mon, 28 Apr 2014 10:12:52 -0400
Received: by mail-lb0-f169.google.com with SMTP id n15so5161126lbi.0
 for <selinux@tycho.nsa.gov>; Mon, 28 Apr 2014 07:12:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <535E0C0A.1000501@gmail.com>
References: <535E0C0A.1000501@gmail.com>
Date: Mon, 28 Apr 2014 07:12:50 -0700
Message-ID: <CAB9W1A1qJqeg3x67x9te70tpEOSoQkvcFwjTzq=8dfLzeKsvew@mail.gmail.com>
Subject: Re: No chance of using SELinux on rootfs without security namespace?
From: Stephen Smalley <stephen.smalley@gmail.com>
To: dE <de.techno@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

It would be difficult at best, unless you are only using it for a
minimalist root and everything else is on some other filesystem type.
Without xattrs, you do not have per-file security labels and therefore
cannot set up automatic domain transitions on any of the executables
in that filesystem or otherwise distinguish any of those files in the
policy.  Lack of xattr support in a native Linux filesystem is a
significant drawback these days; xattrs are used not only for SELinux
but also for ACLs, file capabilities, and various application purposes
(user. namespace).  reiser4 isn't in mainline AFAIK.

On Mon, Apr 28, 2014 at 1:06 AM, dE <de.techno@gmail.com> wrote:
> I just realized -- my rootfs doesn't support xattr (reiser4).
>
> Is there any chance I can use SELinux?
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
