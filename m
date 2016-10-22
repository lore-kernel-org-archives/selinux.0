Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9MDi0bL018656
 for <selinux@tycho.nsa.gov>; Sat, 22 Oct 2016 09:44:00 -0400
Subject: Re: [RFC] Split up policycoreutils
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
References: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
From: Chris PeBenito <pebenito@ieee.org>
Message-ID: <c9ef14f5-1062-21a5-e5ef-d6746a1868d8@ieee.org>
Date: Sat, 22 Oct 2016 09:44:09 -0400
MIME-Version: 1.0
In-Reply-To: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/21/16 13:47, Stephen Smalley wrote:
> policycoreutils started life as a small set of utilities that were
> necessary or at least widely used in production on a SELinux system.
> Over time though it has grown to include many optional components, and
> even within a given subdirectory (e.g. sepolicy) there seem to be a
> number of components that should be optional (e.g. the dbus service).
> I'd like to propose that we move a number of components out of
> policycoreutils into their own top-level subdirectory (possibly grouping
> some of the related ones together).

I'm not sure where the main part of sepolicy should go, but it would be 
nice to split it out since it depends on setools which has heavier 
dependencies than a core system package should typically have IMO 
(NetworkX, which pulls in scipy, numpy, matplotlib, etc.)

-- 
Chris PeBenito
