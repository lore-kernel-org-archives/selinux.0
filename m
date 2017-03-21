Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2LITDo9030396
 for <selinux@tycho.nsa.gov>; Tue, 21 Mar 2017 14:29:13 -0400
Subject: Re: [PATCH 0/3] libsepol: Allow hexadecimal numbers in Xen context
 rules
To: selinux@tycho.nsa.gov
References: <1490023139-12045-1-git-send-email-jwcart2@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <0d3cbfa8-b93b-df86-93be-08efde0e3702@tycho.nsa.gov>
Date: Tue, 21 Mar 2017 14:29:37 -0400
MIME-Version: 1.0
In-Reply-To: <1490023139-12045-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/20/2017 11:18 AM, James Carter wrote:
> Allow the use of hexadecimal numbers in iomemcon, ioportcon, and
> pcidevicecon statements. The use of hexadecimal numbers is often
> the natural choice for these rules.
>
> James Carter (3):
>   libsepol/cil: Allow hexadecimal numbers in Xen context rules
>   libsepol: Update module_to_cil to output hexadecimal for Xen rules
>   libsepol/cil: Use hexadecimal numbers when writing Xen rules
>
>  libsepol/cil/src/cil_build_ast.c | 30 +++++++++++++++---------------
>  libsepol/cil/src/cil_build_ast.h |  4 ++--
>  libsepol/cil/src/cil_policy.c    | 10 +++++++---
>  libsepol/src/module_to_cil.c     | 11 ++++++-----
>  4 files changed, 30 insertions(+), 25 deletions(-)
>

This series has been applied.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
