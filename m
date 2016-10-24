Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9OCXSrA008369
 for <selinux@tycho.nsa.gov>; Mon, 24 Oct 2016 08:33:28 -0400
Received: by mail-lf0-f48.google.com with SMTP id b81so186175393lfe.1
 for <selinux@tycho.nsa.gov>; Mon, 24 Oct 2016 05:33:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
References: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
From: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Mon, 24 Oct 2016 14:33:24 +0200
Message-ID: <CAPzO=NxcmWyc_gcTBPhPvkCQS_YgSMuvDS4Y87M6AnBx2AiGWg@mail.gmail.com>
Subject: Re: [RFC] Split up policycoreutils
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Oct 21, 2016 at 7:47 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> policycoreutils started life as a small set of utilities that were
> necessary or at least widely used in production on a SELinux system.
> Over time though it has grown to include many optional components, and
> even within a given subdirectory (e.g. sepolicy) there seem to be a
> number of components that should be optional (e.g. the dbus service).
> I'd like to propose that we move a number of components out of
> policycoreutils into their own top-level subdirectory (possibly grouping
> some of the related ones together).
[... gui, mcstrans, restorecond, sandbox, semodule_*, sepolicy ...]

I don't see a problem going forward with this. We'll have some package
management effort to do in Gentoo then (we haven't split that like
Fedora did, but used USE flags to toggle the building of certain
areas) but that's manageable.

Wkr,
  Sven Vermeulen
