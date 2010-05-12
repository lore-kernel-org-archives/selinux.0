MIME-Version: 1.0
In-Reply-To: <20100511152801.762ce0ac@nehalam>
References: <20100511152801.762ce0ac@nehalam>
Date: Tue, 11 May 2010 20:39:03 -0400
Message-ID: <AANLkTil7EgPIL1MyDDQNtKUe-5cawr6z23VQj5nG68BQ@mail.gmail.com>
Subject: Re: Labeling as part of distribution build process?
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 11, 2010 at 6:28 PM, Stephen Hemminger
<shemminger@vyatta.com> wrote:
> I am working on SELinux support for our distribution. We support LiveCD
> and running off a read-only image.  I have gotten xattr support for
> Squashfs to work, but one question is how to do labeling of alternative
> root location. One twist is that the build environment probably will
> not be running with the same SELinux policy as the target.
>
> What I want is to label a sub directory tree based on the rules
> of a policy (package).  The existing tools appear to be targeted
> at a self-hosted policy environment. Is there some way to label
> with other tools?

You should be able to use setfiles as long as you run it within a
chroot and run it in a domain that is allowed to set undefined
contexts (setfiles_mac_t in the Fedora policy, introduced to support
livecd building and building of other distribution releases with
different policies on a SELinux-enabled host).  See:
http://marc.info/?l=selinux&m=127300211126195&w=2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
