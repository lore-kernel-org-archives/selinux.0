Subject: Re: Fix AFL Found Bugs in libsepol v4
To: william.c.roberts@intel.com, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
References: <1471368517-20552-1-git-send-email-william.c.roberts@intel.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <62a31b43-546b-9f9c-50bb-08e1447a88e1@tycho.nsa.gov>
Date: Wed, 17 Aug 2016 10:13:54 -0400
MIME-Version: 1.0
In-Reply-To: <1471368517-20552-1-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/16/2016 01:28 PM, william.c.roberts@intel.com wrote:
> So the delta between v3 and v4 is addressing the comments
> on "fix overflow and 0 length allocations", and also move that
> patch to the end of the series. Take up to where you have
> issues as each patch can stand on its own.
>
> [PATCH v4 1/7] libsepol: fix invalid access of NULL on
>
> [PATCH v4 2/7] libsepol: ensure key is valid before doing search
>
> [PATCH v4 3/7] ebitmap: detect invalid bitmap
>
> [PATCH v4 4/7] genfs_read: fix use heap-use-after-free
>
> [PATCH v4 5/7] libsepol: bound attr_type_map access by nprim
>
> [PATCH v4 6/7] libsepol: fix unitialized jmp and invalid dereference
>
> [PATCH v4 7/7] libsepol: fix overflow and 0 length allocations
>

Applied all patches.

Thanks,
Jim

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
