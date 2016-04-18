Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3IEia2i028761
 for <selinux@tycho.nsa.gov>; Mon, 18 Apr 2016 10:44:36 -0400
Subject: Re: [PATCH 0/3] libsepol/cil: Fixes to neverallow and bounds checking
To: selinux@tycho.nsa.gov
References: <1460575157-5846-1-git-send-email-jwcart2@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <5714F331.9030000@tycho.nsa.gov>
Date: Mon, 18 Apr 2016 10:46:09 -0400
MIME-Version: 1.0
In-Reply-To: <1460575157-5846-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/13/2016 03:19 PM, James Carter wrote:
> Dan Walsh found a bug that resulted in a seg fault while working on docker policy.
> Steve Smalley was able to reproduce and find out where it was occuring in secilc.
>
> This patch set fixes that bug and makes other improvements in the bounds and
> neverallow checking.
>
> James Carter (3):
>    libsepol/cil: Fixed bug in cil_type_match_any()
>    libsepol/cil: Improve type bounds check reporting
>    libsepol/cil: Cleanup neverallow checking and fail if bounds checking
>      fails
>
>   libsepol/cil/src/cil_binary.c | 74 +++++++++++++++++++++++--------------------
>   libsepol/cil/src/cil_find.c   |  6 +++-
>   2 files changed, 44 insertions(+), 36 deletions(-)
>


Applied.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
