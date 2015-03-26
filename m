Message-ID: <55146AEF.3030909@tycho.nsa.gov>
Date: Thu, 26 Mar 2015 16:24:15 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libsepol: Move secilc out of libsepol
References: <1427398242-13577-1-git-send-email-ykhodorkovskiy@tresys.com>
In-Reply-To: <1427398242-13577-1-git-send-email-ykhodorkovskiy@tresys.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/26/2015 03:30 PM, Yuli Khodorkovskiy wrote:
> Since the secilc compiler is independent of libsepol, move secilc out of
> libsepol. Linke secilc dynamically rather than statically with libsepol.
> 
> - Move secilc source, test policies, docs, and secilc manpage to secilc
>   directory.
> - Remove unneeded Makefile from libsepol/cil. To build secilc, run make
>   in the secilc directory.
> - Add target to install the secilc binary to /usr/bin/.
> - Create an Android makefile for secilc and move secilc out of libsepol
>   Android makefile.
> - Add cil_set_mls to libsepol public API as it is needed by secilc.
> - Remove policy.conf from testing since it is no longer used.
> 
> Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>

Hmmm...will have to think about how we want to handle this in future
releases and in Android.  Presently we generate separate tar releases
for each component, not the entire tree, so it introduces a new
component that distributions will need to add, and Android would have to
introduce an external/secilc project or just keep stuffing it under
libsepol for convenience.
