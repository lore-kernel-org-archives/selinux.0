Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8JGtPSN030758
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2011 12:55:25 -0400
Received: from mail-yx0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8JGtO5S014639
	for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2011 16:55:24 GMT
Received: by yxk30 with SMTP id 30so5202918yxk.12
        for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2011 09:55:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB04Hprsq9z4qYzO+pTOMYC41ma7d3J7+hrcQ04KSkOQnBEnBQ@mail.gmail.com>
References: <CAB04Hprsq9z4qYzO+pTOMYC41ma7d3J7+hrcQ04KSkOQnBEnBQ@mail.gmail.com>
Date: Mon, 19 Sep 2011 12:55:23 -0400
Message-ID: <CACLa4pt1Q821JJn=kjtJwVV2rzY9fsV_mhiijx3sKPag1ipZBA@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils: preserve mode bits and ownership of /tmp
 in seunshare
From: Eric Paris <eparis@parisplace.org>
To: dave w <nullcore@gmail.com>
Cc: selinux@tycho.nsa.gov, ubuntu-hardened@lists.ubuntu.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 15, 2011 at 1:39 PM, dave w <nullcore@gmail.com> wrote:
> Hi,
>
> This patch addresses a flaw in seunshare.c that allows unprivileged
> users to arbitrarily modify the contents of /tmp.  This bug is further
> described in CVE 2011-1011
> (http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2011-1011):
>
> The seunshare_mount function in sandbox/seunshare.c in seunshare in certain
> Red Hat packages of policycoreutils 2.0.83 and earlier in Red Hat
> Enterprise Linux (RHEL) 6 and earlier, and Fedora 14 and earlier, mounts a
> new directory on top of /tmp without assigning root ownership and the
> sticky bit to this new directory, which allows local users to replace or
> delete arbitrary /tmp files, and consequently cause a denial of service or
> possibly gain privileges, by running a setuid application that relies on
> /tmp, as demonstrated by the ksu application
>
> This patch preserves the mode bits, and thus permissions, and
> ownership of the destination directory of the bind mount performed by
> seunshare.  The permission check in verify_mount() was relaxed for
> directories who originally had the sticky bit set, as root ownership
> is required for these to ensure that unprivileged users cannot unlink
> arbitrary files in the newly bind mounted directory.

As Dan pointed out one of us dropped the ball on this.  I have
committed huge amounts of seunshare changes from the Fedora tree to
the upstream git tree.  It should include fixes for this problem as
well.  Your patch is definitely a smaller fix for the problem at hand
as the Fedora tree has largely rewritten how filesystem mounting is
done as might be appropriate for backports to old code if a distro is
not ready to take the plunge into the wild world of new upstream
tools!

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
