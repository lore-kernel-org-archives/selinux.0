MIME-Version: 1.0
In-Reply-To: <CAFftDdpxGbzPRP0LsU+r=NXra4Q57Yte5ApAS_Ksqt2LmPdXJQ@mail.gmail.com>
References: <1471276754-25266-1-git-send-email-william.c.roberts@intel.com>
 <1471276754-25266-6-git-send-email-william.c.roberts@intel.com>
 <9ca86776-3817-1c5d-dca4-7490cd70212d@tycho.nsa.gov>
 <CAFftDdqDRinx5w-GaapnCRAMrhjxYwKjPxvogrvxDX+p3ASzPg@mail.gmail.com>
 <CAFftDdqPOgi7ZBmscF-vUA=PMbMscrV2kOU2E=ODw-afUzOOhg@mail.gmail.com>
 <CAFftDdpxGbzPRP0LsU+r=NXra4Q57Yte5ApAS_Ksqt2LmPdXJQ@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 16 Aug 2016 10:31:10 -0700
Message-ID: <CAFftDdoAfMN23aq1+LQPccG0-BCHYKjgr8-jZ94N7cs-hRcvqw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] libsepol: fix overflow and 0 length allocations
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

<snip>
>> Currently, in file-systems like reiserFS that support scalable xattrs, only
>> VFS is the one limiting the size to 64k. Since their is no constant, and
>> maybe one day this arbitrary VFS limit
>> would be removed, I think we should check correctlly here that were
>> allocating > 1 bytes, and we keep total_sz a const.
>
>
> BTW do you want to take everything up to this patchset and I can
> rebase on the repo
> instead of sending out so many patches each time. This is me assuming the others
> are ok by lack of commentary.
>

BTW Patchset v4 has this patch at the very end, so the order is
different, if you
can apply the ones you like up to X and i'll rebase my local branch accordingly.
Rather than blasting 7 patches on a daily basis.
