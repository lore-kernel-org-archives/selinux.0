Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7SJwCnJ014226
 for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2014 15:58:12 -0400
Received: by mail-ob0-f177.google.com with SMTP id wo20so1001183obc.8
 for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2014 12:58:17 -0700 (PDT)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <53FE02E5.6080506@tresys.com>
References: <53FCA845.1030001@tresys.com> <20140827150608.GA6701@siphos.be>
 <53FE02E5.6080506@tresys.com>
Date: Thu, 28 Aug 2014 21:58:16 +0200
Message-ID: <CAPzO=NyyP-m8jPBujd-vnG9XHo2FymskgQBH3fKPt448NznZdA@mail.gmail.com>
Subject: Re: SELinux Userspace Release: 20140826-rc1
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Aug 27, 2014 at 6:10 PM, Steve Lawrence <slawrence@tresys.com> wrote:
> The only action that should be required post upgrade is migration from
> /etc/selinux to /var/lib/selinux. There is detailed information about
> this process on the GitHub "Policy Store Migration" wiki page [2], but
> the jist of it is after upgrading, execute the the
> semanage_migrate_store script installed by default to
> /usr/libexec/selinux. The script has additional options that can be used
> to do things like remove the old store or prevent rebuilding the policy.
> Run the script with --help for a description of the options.
>
> Please let us know if there are any questions/issues.

Hi Steve

(Sorry for the direct mail in the previous remark, gmail doesn't like
to automatically reply to the mailinglist)

When running the semanage_migrate_script I get the following problem:

Migrating from /etc/selinux/mcs/modules/active to /var/lib/selinux/mcs/active
Attempting to rebuild policy from /var/lib/selinux
sysnetwork: Warning: 'else' blocks in optional statements are
unsupported in CIL. Dropping from output.
Segmentation fault

The segmentation fault comes up at the following python code:

rc = semanage.semanage_commit(handle)

In the logs, I get:

[ 2403.250065] semanage_migrat[25752]: segfault at 28 ip
000003044dd14c5b sp 000003d2272a1140 error 4 in
libsepol.so.1[3044dcb2000+8f000]

The system has grsecurity enabled as well, but grsecurity should give
more output if it was preventing something. I'll investigate this more
tomorrow-evening.

Wkr,
  Sven Vermeulen
