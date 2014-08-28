Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7SKqVla017490
 for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2014 16:52:31 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp4so1111488obc.34
 for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2014 13:52:37 -0700 (PDT)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <53FF8DE9.6070302@tycho.nsa.gov>
References: <53FCA845.1030001@tresys.com> <20140827150608.GA6701@siphos.be>
 <53FE02E5.6080506@tresys.com>
 <CAPzO=NyyP-m8jPBujd-vnG9XHo2FymskgQBH3fKPt448NznZdA@mail.gmail.com>
 <53FF8DE9.6070302@tycho.nsa.gov>
Date: Thu, 28 Aug 2014 22:52:37 +0200
Message-ID: <CAPzO=Nwwbn8ihZmuj-JGKPUonZwjS69Zjg=1ix1EDbR=QQ56oQ@mail.gmail.com>
Subject: Re: SELinux Userspace Release: 20140826-rc1
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Aug 28, 2014 at 10:15 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> When running the semanage_migrate_script I get the following problem:
>>
>> Migrating from /etc/selinux/mcs/modules/active to /var/lib/selinux/mcs/active
>> Attempting to rebuild policy from /var/lib/selinux
>> sysnetwork: Warning: 'else' blocks in optional statements are
>> unsupported in CIL. Dropping from output.
>> Segmentation fault
[...]
> Can you provide a copy of your original policy prior to conversion?

If you mean the policy.29 file, certainly. You can wget it from
http://dev.gentoo.org/~swift/tmp/20140828-policy.29

Wkr,
  Sven Vermeulen
