Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h82HPiLa017889
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 13:25:44 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h82HPhet019406
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 17:25:44 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h82HPhlq019403 for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 17:25:43 GMT
Subject: Re: glibc rpm install error
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Nick Davis <nicholas-davis@utulsa.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <3F54CF05.8050608@utulsa.edu>
References: <3F54CF05.8050608@utulsa.edu>
Content-Type: text/plain
Message-Id: <1062523542.18568.130.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 02 Sep 2003 13:25:42 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-09-02 at 13:10, Nick Davis wrote:
> Error: %postun(glibc-2.3.2-27.9.selinux.0) scriptlet failed, exit status 121
> 
>  From that point on, any command I run gives a Segmentation Fault.  I 
> tried installing the glibc RPMs last, after all of the other utils, but 
> the same thing happens.
> 
> Has anyone run into this problem before, or have an idea on what the 
> problem might be?

Yes.  The problem isn't specific to SELinux; it also occurs when
installing the original RHL errata RPMs if you install the i386 glibc on
a system that previously had the i686 glibc installed.  You need to
build two sets of glibc RPMS, one with --target=i386 and one with
--target=i686, then install the glibc-N.i686.rpm along with
glibc-{common,...}-N.i386.rpm, omitting the glibc-N.i386.rpm entirely.

You may also be able to just grab the rawhide glibc from RH and use it,
as the changes to support AT_SECURE were upstreamed.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
