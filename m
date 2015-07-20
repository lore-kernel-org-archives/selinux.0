Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6KHt2vH017802
 for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2015 13:55:02 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id B902920C0B
 for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2015 13:54:59 -0400 (EDT)
Message-Id: <1437414899.148452.328428529.097963A9@webmail.messagingengine.com>
From: Colin Walters <walters@verbum.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <87fv4owvxv.fsf@x220.int.ebiederm.org>
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <55A6C448.5050902@schaufler-ca.com>
 <87vbdlf7vo.fsf@x220.int.ebiederm.org>
 <55A6E107.3070200@schaufler-ca.com>
 <CALCETrVCNQPVr-hg_pqd2J_LeWtRJs3LRsbbE+fifo4sat+FQQ@mail.gmail.com>
 <55A71CE3.4050708@schaufler-ca.com>
 <87fv4owvxv.fsf@x220.int.ebiederm.org>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
Date: Mon, 20 Jul 2015 13:54:59 -0400
Cc: Serge Hallyn <serge.hallyn@canonical.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>,
 Seth Forshee <seth.forshee@canonical.com>,
 LSM List <linux-security-module@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, SELinux-NSA <selinux@tycho.nsa.gov>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jul 16, 2015, at 12:47 AM, Eric W. Biederman wrote:

> With that said desktop environments have for a long time been
> automatically mounting whichever filesystem you place in your computer,
> so in practice what this is really about is trying to align the kernel
> with how people use filesystems.

There is a large attack surface difference between mounting a device
that someone physically plugged into the computer (and note typically
it's required that the active console be unlocked as well[1]) versus
allowing any "unprivileged" process at any time to do it.

Many server setups use "unprivileged" uids that otherwise wouldn't
be able to exploit bugs in filesystem code.

[1] https://bugzilla.gnome.org/show_bug.cgi?id=653520
"AutomountManager also keeps track of the current session availability
(using the ConsoleKit and gnome-screensaver DBus interfaces) and
inhibits mounting if the current session is locked, or another session
is in use instead."
