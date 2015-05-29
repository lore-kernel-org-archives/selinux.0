Message-ID: <55685F78.9080306@tycho.nsa.gov>
Date: Fri, 29 May 2015 08:45:44 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
 SELinux List <selinux@tycho.nsa.gov>,
 Steve Lawrence <slawrence@tresys.com>,
 Joshua Brindle <brindle@quarksecurity.com>,
 Eric Paris <eparis@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: ANN: SETools 4.0.0-alpha2
References: <54DB79D3.8@tresys.com>
In-Reply-To: <54DB79D3.8@tresys.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/11/2015 10:48 AM, Christopher J. PeBenito wrote:
> Tresys has released SETools 4.0.0-alpha2:
> 
> https://github.com/TresysTechnology/setools/releases/tag/4.0.0-alpha2
> 
> In this release, SETools has been updated to support Python 3 (tested
> with 3.3 and 3.4) and includes travis-ci testing[1].  Many features are
> complete or nearly complete (full list at the end of the email) and
> available for use via the CLI tools.  The GUI tools have not yet been
> started.
> 
> Warning: If you replace the SETools 3.x on your system, it will break
> the couple of tools from sepolgen/policycoreutils that depend on SETools
> (e.g. sepolicy) since libqpol/libapol C libraries and their
> corresponding SWIG wrappers are no longer provided.

Should we then import libqpol and libapol into the upstream selinux?
We never should have added dependencies on setools to the core selinux
userspace in the first place, as it creates a cyclic dependency.
Doesn't look like libapol and libqpol have other dependencies themselves
beyond what we already require for selinux userspace unless I am missing
something.

> 
> If you are interested in contributing, GitHub's pull request feature is
> preferred for submitting patches.  Please include unit tests.
> 
> SETools requires the following development packages for building:
>   Python 2.7 or 3.3+
>   setuptools
>   gcc
>   bison
>   flex
>   libselinux
>   libsepol 2.4+
>   libbz2
>   SWIG 2.0.12+ or 3.0+
> 
> To run SETools, the following packages are required:
>   Python 2.7 or 3.3+
>   NetworkX 1.8+
>   setuptools
>   libselinux
>   libsepol 2.4+
>   libbz2
> 
> Completed (and nearly completed) features:
> * TE rule query
> * RBAC rule query
> * MLS rule query (range_transition; except for range criteria)
> * Type query
> * Role query
> * User query (except level/range criteria)
> * Object class query
> * Common query
> * Boolean query
> * Policy capability query
> * All context queries (portcon, genfscon, etc, except range criteria)
> * Information flow analysis
> * Domain transition analysis
> 
> [1] https://travis-ci.org/TresysTechnology/setools
> 
