MIME-Version: 1.0
In-Reply-To: <1474737005-1907-1-git-send-email-william.c.roberts@intel.com>
References: <1474737005-1907-1-git-send-email-william.c.roberts@intel.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Sat, 24 Sep 2016 10:58:24 -0700
Message-ID: <CAFftDdpxLWh1zG+mriPqA8vT3y4XO+NdCnvMv8SQAzAfyOHhoQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: drop unused stdio_ext.h header file
To: William Roberts <william.c.roberts@intel.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Sep 24, 2016 at 10:10 AM,  <william.c.roberts@intel.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> Nothing was being used from the stdio_ext.h header file, so
> remove it. Additionally, Mac builds, required for the
> Android build, do not have this header.
>
> Change-Id: Ic61c87fcda79ffebeef93a20a2b3802f048bb0b0

Rather thean resending this, I forgot to drop the change-id when I
cherry-picked it,
can you just ammend it?

<snip>
