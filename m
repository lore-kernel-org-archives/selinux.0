Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s97IvYcu011738
 for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2014 14:57:34 -0400
Received: by mail-ob0-f177.google.com with SMTP id uy5so5930968obc.36
 for <selinux@tycho.nsa.gov>; Tue, 07 Oct 2014 11:57:40 -0700 (PDT)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <5433E840.8060605@tresys.com>
References: <5433E840.8060605@tresys.com>
Date: Tue, 7 Oct 2014 20:57:40 +0200
Message-ID: <CAPzO=NyrMVFT8tR4t_Xt6rP_i0aw5za7havPUJzR7j1PPeGXSg@mail.gmail.com>
Subject: Re: SELinux Userspace Release: 20140826-rc4
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Oct 7, 2014 at 3:18 PM, Steve Lawrence <slawrence@tresys.com> wrote:
> The fourth release candidate for the next release of SELinux Userspace
> [1] is now available. The tarballs have been built and can be downloaded
> from the Releases wiki page [2]. Changes since rc2 include:
[...]
> Please give this a test and let us know if you find any problems.

The migration now finished with returncode 0. I did have a warning
during the migration but if I recall correctly it was already
mentioned on the list:

Attempting to rebuild policy from /var/lib/selinux
sysnetwork: Warning: 'else' blocks in optional statements are
unsupported in CIL. Dropping from output.

Things seem to work well. I removed the /etc/selinux/mcs/modules
location to be certain. I'll do some more intensified testing later
and get back to you guys (just wanted to confirm that the previously
reported error was fixed).

Wkr,
  Sven Vermeulen
