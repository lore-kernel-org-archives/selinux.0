Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9UJhC9x010762
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2013 15:43:14 -0400
Received: by mail-qc0-f180.google.com with SMTP id e9so1087997qcy.39
        for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2013 12:43:11 -0700 (PDT)
Message-ID: <52716143.3080609@quarksecurity.com>
Date: Wed, 30 Oct 2013 15:42:59 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: Been looking at further shrinkage of the SELinux footprint on
 Linux.
References: <52715E75.5000005@redhat.com>
In-Reply-To: <52715E75.5000005@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> We are trying to shrink out cloud image as small as possible.  One idea was to
> shrink SELinux Policy footprint by adding compression to it.
>
> Here is a patch I have been fooling around with which would read a policy.29
> file if it was compressed with xz.
>
> xz compression does around a 90% compression on the policy file,  and does not
> slow the load in any meaningfull way.
>
> I also have done a patch to try out gzip.
>
> gzip and xz are already used in systemd, which means we would not need to add
> a new requirement to the minimal system.
>
> xz seems quicker and smaller then gzip.
>
> Have not started playing with libsemanage yet.
>
> What do you think?  Is xz availabel on Android?

No.

Is there a reason you wouldn't just have systemd decompress it before 
loading it? I guess if you want all the existing tools/libraries to work 
without any changes it would need to be build in to libselinux rather 
done outside of the library.

Android's libselinux is forked anyway so this probably wouldn't flow to 
Android.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
