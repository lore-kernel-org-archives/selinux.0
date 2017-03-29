Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TL0joa010682
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 17:00:45 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 5B166228B3
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 17:00:42 -0400 (EDT)
Message-Id: <1490821242.510644.927878696.6DEBD3A9@webmail.messagingengine.com>
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: label for /proc directory (before mounting)
Date: Wed, 29 Mar 2017 17:00:42 -0400
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi, see: https://github.com/ostreedev/ostree/pull/768

TL;DR: Policy (at least Fedora's version) does not specify
a label for /proc on disk (as distinct from the `proc_t` from
the genfscon).

This causes some breakage in rpm-ostree (which I can work
around), but I'd like a better fix than what I did above.
Any suggestions?  It probably doesn't
matter too much what the actual type is since systemd will
overmount it - should I make it the same type as e.g. `/mnt`?
