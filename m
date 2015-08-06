Message-ID: <55C3778E.7030305@tycho.nsa.gov>
Date: Thu, 06 Aug 2015 11:04:46 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH v2 0/3] Add support for extracting modules
References: <1438871414-62292-1-git-send-email-ykhodorkovskiy@tresys.com>
In-Reply-To: <1438871414-62292-1-git-send-email-ykhodorkovskiy@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/06/2015 10:30 AM, Yuli Khodorkovskiy wrote:
> This patchset adds support for extracting modules from the module store as hll
> or cil to the current working directory. This also adds a function to the
> libsemanage API to extract modules and fixes a memory leak discovered while
> implementing this functionality.
>
> Changes from v1:
> - Add fallback behavior if a module does not exist at the default priority when
> extracting with semodule.
>

Thanks, applied.

> Yuli Khodorkovskiy (3):
>    libsemanage: Add ability to extract modules
>    libsemanage: Fix null pointer dereference in
>      semanage_module_key_destroy
>    policycoreutils/semodule: update semodule to allow extracting modules
>
>   libsemanage/include/semanage/modules.h |  17 ++
>   libsemanage/src/direct_api.c           | 310 ++++++++++++++++++++++-----------
>   libsemanage/src/libsemanage.map        |   1 +
>   libsemanage/src/modules.c              |  23 ++-
>   libsemanage/src/policy.h               |   8 +
>   libsemanage/src/semanageswig_python.i  |   5 +
>   policycoreutils/semodule/semodule.8    |  14 ++
>   policycoreutils/semodule/semodule.c    | 146 +++++++++++++++-
>   8 files changed, 416 insertions(+), 108 deletions(-)
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
