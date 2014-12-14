Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBEFkgOD015460
 for <selinux@tycho.nsa.gov>; Sun, 14 Dec 2014 10:46:42 -0500
Received: by mail-ob0-f175.google.com with SMTP id wp4so14574413obc.6
 for <selinux@tycho.nsa.gov>; Sun, 14 Dec 2014 07:46:40 -0800 (PST)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <5480B2DB.6010408@tresys.com>
References: <5480B2DB.6010408@tresys.com>
Date: Sun, 14 Dec 2014 16:46:40 +0100
Message-ID: <CAPzO=Ny_kUT2drj3KzW_uhLLpeOqxPJtOa5R46PGa5bhCT92Eg@mail.gmail.com>
Subject: Re: ANN: SELinux Userspace Release: 20140826-rc7
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Dec 4, 2014 at 8:15 PM, Steve Lawrence <slawrence@tresys.com> wrote:
> The seventh release candidate for the next release of SELinux Userspace
> [1] is now available. T
[...]

Hi all

Is it possible to kepe the tmp/ directory when building/loading a policy fails?

# semodule -v -i foo.pp
Attempting to install module 'foo.pp':
Ok: return value of 0.
Committing changes:
Conflicting type rules
Binary policy creation failed at line 177 of
/var/lib/selinux/mcs/tmp/modules/400/java/cil
Failed to generate binary
semodule:  Failed!

The tmp/ directory is cleared so it is not possible to use that
location for troubleshooting.

In this particular case, I could find the java/cil in the
/var/lib/selinux/mcs/active/modules/400 location, but if the error
would be within the foo.pp-generated CIL file, then the CIL file
cannot be found anymore.

Wkr,
  Sven Vermeulen
