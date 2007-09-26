Message-ID: <46F9F2E2.4060406@ak.jp.nec.com>
Date: Wed, 26 Sep 2007 14:49:22 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Paul Moore <paul.moore@hp.com>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Subject: [PATCH] Improve SELinux performance when AVC misses.
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp>	 <200708211111.27019.paul.moore@hp.com>	 <1187714269.1451.148.camel@moss-spartans.epoch.ncsc.mil>	 <200708211255.45132.paul.moore@hp.com> <46CC00F4.2090501@ak.jp.nec.com>	 <46E7583C.9030103@ak.jp.nec.com>	 <1190136066.14037.53.camel@moss-spartans.epoch.ncsc.mil>	 <46F22BEF.9050208@ak.jp.nec.com>	 <1190402479.17518.130.camel@moss-spartans.epoch.ncsc.mil>	 <46F89767.2090203@ak.jp.nec.com> <1190728430.24726.13.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1190728430.24726.13.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>>> For example, ebitmap_netlbl_export() when NetLabel is not enabled is
>>>> defined as explicitly inlined function which always returns -ENOMEM,
>>>> however, these are also declarations of function when NetLabel is enabled.
>>> Ah, never mind - as these are defined in the header file, they can stay
>>> static inline.
>> OK. I'll submit a patch to clean up non-stub static inline functions
>> next to this patch.
> 
> I don't think it is necessary.

Sorry, I might misread your suggestion.

>>> Ok, looks reasonable.  Please run it through ./scripts/checkpatch.pl and
>>> fix up the minor issues it reports, then post a clean message with a
>>> suitable description and the patch inline.
>> What is your stance about warnings for "line over 80 characters" ?
>> To resolve all of them makes harder to read source code, so I'm ignoring
>> them in the attached version.
>> Rest of warnings except for them are removed.
> 
> I think we have to conform to it, and if it makes it harder to read,
> possibly that suggests that we need to rework the code in some way.

I'm preparing another version of patch which does not contain any
"line over 80 characters" warning. Please wait for a while.

> Need to make a fresh posting with appropriate subject line, text
> description of the patch, Signed-off-by, diffstat -p1 output, inlined
> patch.  No residue from prior replies.

OK, the following part is a fresh patch.
