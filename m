Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4DBhP9C008827
 for <selinux@tycho.nsa.gov>; Sun, 13 May 2018 07:43:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC15.oob.disa.mil (Postfix) with SMTP id 40kMQx6y2Gz3GD9p
 for <selinux@tycho.nsa.gov>; Sun, 13 May 2018 11:43:21 +0000 (UTC)
Received: from UPBD19PA14.eemsg.mil (unknown [192.168.18.14])
 by UPDCF3IC15.oob.disa.mil (Postfix) with ESMTP id 40kMQx4HJ8z3GD9q
 for <selinux@tycho.nsa.gov>; Sun, 13 May 2018 11:43:21 +0000 (UTC)
Received: from mail-ot0-f176.google.com (mail-ot0-f176.google.com
 [74.125.82.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 7C98756069F
 for <selinux@tycho.nsa.gov>; Sun, 13 May 2018 13:43:12 +0200 (CEST)
Received: by mail-ot0-f176.google.com with SMTP id n3-v6so11258943ota.5
 for <selinux@tycho.nsa.gov>; Sun, 13 May 2018 04:43:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1526129620.28749.19.camel@cepl.eu>
References: <1526129620.28749.19.camel@cepl.eu>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sun, 13 May 2018 13:43:10 +0200
Message-ID: <CAJfZ7==pQDfffb8zW47YUYbzm0Lxqbi_F89K2wjVzL6BntcQvA@mail.gmail.com>
To: =?UTF-8?Q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>,
 selinux-devel@alioth-lists.debian.net, selinux@lists.fedoraproject.org,
 selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: Packaging policycoreutils for OpenSUSE
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, May 12, 2018 at 2:53 PM, Matěj Cepl <mcepl@cepl.eu> wrote:
> Hi,
>
> I am changing jobs (Red Hat -> SUSE; R&D, but not a security
> related job), and although I will be switching my workstation to
> OpenSUSE, I would love to keep SELinux working. Which meant I had
> to dig into the current situation of SELinux and it is … not
> good. So, I started to repackage all SELinux packages 2.7 for
> OpenSUSE in my home build area
> https://build.opensuse.org/project/show/home:mcepl:SELinux
> . So,far I have packaged successfully packages for libselinux,
> libselinux-bindings, checkpolicy, libsemanage, libsepol, and
> python-semanage. Mostly I use original OpenSUSE packages for 2.6,
> but if needed I seek inspiration in Fedora packages.
>
> Unfortunately, I have trouble to package policycoreutils. First
> of all, I don’t understand what’s the difference between two
> upstream tarballs for it:
> https://github.com/SELinuxProject/selinux/archive/policycoreutils
> -2.7.tar.gz
> (linked from https://github.com/SELinuxProject/selinux/releases)
> and
> https://raw.githubusercontent.com/wiki/SELinuxProject/selinux/fil
> es/releases/20170804/policycoreutils-2.7.tar.gz
> (linked from
> https://github.com/SELinuxProject/selinux/wiki/Releases). What’s
> the point of confusing users with two different tarballs of the
> same name?
>
> Second, I don’t understand the behavior of the installation
> scripts. Looking at https://is.gd/MivaE1 , why in the world that
> installation scripts tons of stuff which is not part of
> policycoreutils? Could anybody help me to get through this
> obstacle, please?
>
> Thank you for any suggestions,
>
> Matěj

Hi,
After we have discussed about it on IRC (#selinux on freenode), I have
performed some tests on Github to better understand how its "Releases
page" work. The main issue here is that Github shows tags of the git
repository in the Releases page
(https://github.com/SELinuxProject/selinux/releases) and there is no
way to disabled this behavior. This has several consequences:

* Each tarball in https://github.com/SELinuxProject/selinux/releases
contains the full tree of the project (which is why "that installation
scripts tons of stuff which is not part of policycoreutils"), whereas
the tarballs in the wiki page are created by properly splitting the
subdirectories.
* It is not possible to delete what is currently in Github's release
page without deleting the tags.
* It is possible to "upgrade" a tag to a release by adding release
notes and files to them. For example
https://github.com/gentilkiwi/mimikatz/releases uses this (you can see
the differences between "Releases" and "Tags" pages of this project).
When there are releases like this, it is possible to remove them all
(for example using
https://github.com/stevemao/github-remove-all-releases), which
transforms the release page back to a list of tags (I have tested this
today on a test repository).

Moreover it seems that the Releases page can not be disabled (if it
can, I have not found how).

If my analysis of Github's release system is correct, would it make
sense to change the way the releases are currently tagged to only
create one tag (like "selinux-2.8-rc3") instead of creating one tag
per sub-project? Would this break some tools? (If distribution
packagers use tools to automatically detect when a new release is
available, would such a change break these tools?)

Cheers,
Nicolas
(IooNag on IRC)
