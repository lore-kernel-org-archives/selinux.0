Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KFb8dM029779
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 10:37:08 -0500
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KFcNox004348
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 15:38:24 GMT
Received: by wr-out-0506.google.com with SMTP id i7so2527733wra
        for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 07:38:17 -0800 (PST)
Message-ID: <e739902b0702200737g692dde82j10b75cfe20cb2f6@mail.gmail.com>
Date: Tue, 20 Feb 2007 07:37:50 -0800
From: "Ryan Bradetich" <rbradetich@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: Compile error with the SVN version of the refpolicy.
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1171981486.14363.13.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <e739902b0702162219o45a8ccc9v5e5092c9e310c4bb@mail.gmail.com>
	 <1171981486.14363.13.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Stephen,

I had used the package from the Ubuntu Feisty repository which is
version 1.32-1.  I will revert my patch in my local tree and use the
source from the SVN  checkpolicy from sourceforge.

Thanks for your response!

- Ryan


On 2/20/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2007-02-16 at 22:19 -0800, Ryan Bradetich wrote:
> > Hello all,
> >
> > I am having a compile problem with the latest SVN check out of the
> > refpolicy.  Here is the error message:
> >
> > /usr/bin/checkpolicy policy.conf -o
> > /etc/selinux/refpolicy/policy/policy.21
> > /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> > policy/modules/services/zebra.te:1136:ERROR 'syntax error' at token
> > 'ntfs-3g' on line 1523915:
> > genfscon msdos / system_u:object_r:dosfs_t
> > genfscon ntfs-3g / system_u:object_r:dosfs_t
> > checkpolicy:  error(s) encountered while parsing configuration
> > make: *** [/etc/selinux/refpolicy/policy/policy.21] Error 1
> >
> >
> > The problem is that checkpolicy does not appear to like the '-'
> > character.  I changed the '-' to a '_' in the
> > policy/modules/kernel/filesystem.te file to fix the compile problem.
> >
> >
> > If this change is correct, I have provided a patch to someone can apply.
>
> No, the filesystem type string must match what the kernel module defines
> it to be, and in this case, it truly is "ntfs-3g".  You need a newer
> checkpolicy (1.33.1 or later).  When building refpolicy from the tresys
> svn, use the latest checkpolicy from the sourceforge svn.
>
> --
> Stephen Smalley
> National Security Agency
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
