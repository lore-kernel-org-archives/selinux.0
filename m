Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754974AF64;
	Wed, 20 Dec 2023 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 727DA2F4;
	Wed, 20 Dec 2023 14:32:02 -0800 (PST)
Received: from [10.57.4.161] (unknown [10.57.4.161])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79D0A3F738;
	Wed, 20 Dec 2023 14:31:16 -0800 (PST)
Message-ID: <3717b995-5209-4db8-be77-c6303bb1c0db@arm.com>
Date: Wed, 20 Dec 2023 22:31:15 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] lsm: consolidate buffer size handling into
 lsm_fill_user_ctx()
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Cc: selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>,
 John Johansen <john.johansen@canonical.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>, Mark Brown <broonie@kernel.org>
References: <20231024213525.361332-4-paul@paul-moore.com>
 <20231024213525.361332-7-paul@paul-moore.com>
Content-Language: en-US
From: Aishwarya TCV <aishwarya.tcv@arm.com>
In-Reply-To: <20231024213525.361332-7-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 24/10/2023 22:35, Paul Moore wrote:
> While we have a lsm_fill_user_ctx() helper function designed to make
> life easier for LSMs which return lsm_ctx structs to userspace, we
> didn't include all of the buffer length safety checks and buffer
> padding adjustments in the helper.  This led to code duplication
> across the different LSMs and the possibility for mistakes across the
> different LSM subsystems.  In order to reduce code duplication and
> decrease the chances of silly mistakes, we're consolidating all of
> this code into the lsm_fill_user_ctx() helper.
> 
> The buffer padding is also modified from a fixed 8-byte alignment to
> an alignment that matches the word length of the machine
> (BITS_PER_LONG / 8).
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/security.h   |  9 ++++---
>  security/apparmor/lsm.c    | 15 +++--------
>  security/security.c        | 55 +++++++++++++++++++++-----------------
>  security/selinux/hooks.c   | 42 +++++++++++++++--------------
>  security/smack/smack_lsm.c | 23 +++++-----------
>  5 files changed, 67 insertions(+), 77 deletions(-)
> 

Hi Paul,

While building the kernel against next-master for arch arm64
> security/security.c:810:2: warning: ‘memcpy’ offset 32 is out of the bounds [0, 0] [-Warray-bounds]
warning is observed. On some other architectures like i386 and x86_64,
an error is observed. > arch/x86/include/asm/string_32.h:150:25: error:
‘__builtin_memcpy’ offset 32 is out of the bounds [0, 0]
[-Werror=array-bounds]

The links of the logs is listed below:
https://storage.kernelci.org/next/master/next-20231220/arm64/defconfig/gcc-10/logs/build-warnings.log
https://storage.kernelci.org/next/master/next-20231220/i386/i386_defconfig/gcc-10/logs/build-errors.log

The logs of all the architecture built against next-master can be found
here (select the 'All' category in the table to view):
https://linux.kernelci.org/build/next/branch/master/kernel/next-20231220/


Find this issue filed at KSPP/linux here:
https://github.com/KSPP/linux/issues/347


A bisect done by building kernel against next-master for arch arm64
(full log below) identified this patch as introducing the failure.

git bisect log:
git bisect start
# good: [b85ea95d086471afb4ad062012a4d73cd328fa86] Linux 6.7-rc1
git bisect good b85ea95d086471afb4ad062012a4d73cd328fa86
# bad: [5ba73bec5e7b0494da7fdca3e003d8b97fa932cd] Add linux-next
specific files for 20231114
git bisect bad 5ba73bec5e7b0494da7fdca3e003d8b97fa932cd
# good: [a15c6466b909f03889150df57b227702a7bd6bd5] Merge branch
'for-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
git bisect good a15c6466b909f03889150df57b227702a7bd6bd5
# good: [6a8b8b208098a27488a3649966d64894da948a02] Merge branch
'for-next' of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
git bisect good 6a8b8b208098a27488a3649966d64894da948a02
# bad: [81105901f053f9684a111c0569eb35474b2a86f9] Merge branch 'next' of
git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
git bisect bad 81105901f053f9684a111c0569eb35474b2a86f9
# bad: [585a8722efb6f823e961f16bd9be818f994d4804] Merge branch
'rcu/next' of
git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
git bisect bad 585a8722efb6f823e961f16bd9be818f994d4804
# good: [c867caae623b3dd488a849df5538e79a59b0a47f] Merge branch into
tip/master: 'x86/percpu'
git bisect good c867caae623b3dd488a849df5538e79a59b0a47f
# bad: [381a25d3e3d440ccc05de8ddd56a055423ac9fe5] Merge branch 'next' of
git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
git bisect bad 381a25d3e3d440ccc05de8ddd56a055423ac9fe5
# good: [762c934317e6f4b576eb4aa75e5facf4968a4a8f] SELinux: Add selfattr
hooks
git bisect good 762c934317e6f4b576eb4aa75e5facf4968a4a8f
# good: [fdcf699b60712ecd6e41d9fc09137279257a4bf8] lsm: correct error
codes in security_getselfattr()
git bisect good fdcf699b60712ecd6e41d9fc09137279257a4bf8
# bad: [9ba8802c8b66fbde2ee32ab4c44cd418f9444486] lsm: convert
security_setselfattr() to use memdup_user()
git bisect bad 9ba8802c8b66fbde2ee32ab4c44cd418f9444486
# bad: [41793202292fd2acf99fdc09eff8323cc27c80eb] lsm: align based on
pointer length in lsm_fill_user_ctx()
git bisect bad 41793202292fd2acf99fdc09eff8323cc27c80eb
# bad: [d7cf3412a9f6c547e5ee443fa7644e08898aa3e2] lsm: consolidate
buffer size handling into lsm_fill_user_ctx()
git bisect bad d7cf3412a9f6c547e5ee443fa7644e08898aa3e2
# first bad commit: [d7cf3412a9f6c547e5ee443fa7644e08898aa3e2] lsm:
consolidate buffer size handling into lsm_fill_user_ctx()

Thanks,
Aishwarya



