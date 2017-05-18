Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4IFfXSY027668
 for <selinux@tycho.nsa.gov>; Thu, 18 May 2017 11:41:35 -0400
Received: by mail-wr0-f194.google.com with SMTP id w50so6866508wrc.0
 for <selinux@tycho.nsa.gov>; Thu, 18 May 2017 08:41:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1494606653.9454.7.camel@tycho.nsa.gov>
References: <20170505131448.8718-1-sds@tycho.nsa.gov>
 <1494606653.9454.7.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 18 May 2017 11:41:25 -0400
Message-ID: <CAHC9VhQ1WTx2VdibR5QYvu1OhysZrSaWVi8LMLiGsXZuk=cu7Q@mail.gmail.com>
Subject: Re: [RFC][PATCH] selinux: add a map permission check for mmap
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, May 12, 2017 at 12:30 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2017-05-05 at 09:14 -0400, Stephen Smalley wrote:
>> Add a map permission check on mmap so that we can distinguish memory
>> mapped
>> access (since it has different implications for revocation). When a
>> file
>> is opened and then read or written via syscalls like
>> read(2)/write(2),
>> we revalidate access on each read/write operation via
>> selinux_file_permission() and therefore can revoke access if the
>> process context, the file context, or the policy changes in such a
>> manner that access is no longer allowed. When a file is opened and
>> then
>> memory mapped via mmap(2) and then subsequently read or written
>> directly
>> in memory, we presently have no way to revalidate or revoke access.
>> The purpose of a separate map permission check on mmap(2) is to
>> permit
>> policy to prohibit memory mapping of specific files for which we need
>> to ensure that every access is revalidated, particularly useful for
>> scenarios where we expect the file to be relabeled at runtime in
>> order
>> to reflect state changes (e.g. cross-domain solution, assured
>> pipeline
>> without data copying).
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>
> Unless you have any comments/objections, feel free to apply this as is
> - I believe it is good to go, and I have also posted the corresponding
> selinux-testsuite patch.

No objections and I think the only comments I had were covered in the
policy capabilities thread (I agree that we should let handle_unknown
take care of things in this patch).

Looks good to me, merged.

-- 
paul moore
www.paul-moore.com
