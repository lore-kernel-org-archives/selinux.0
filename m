Date: Wed, 22 Mar 2017 09:45:46 +0000
From: Simon McVittie <smcv@debian.org>
To: Stephen Smalley <sds@tycho.nsa.gov>, 857660@bugs.debian.org
Cc: cgzones <cgzones@googlemail.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Bug#857660: SELinux: cannot sent policyload notice
Message-ID: <20170322094546.ptoxui7yavjbdn64@perpetual.pseudorandom.co.uk>
References: <CAJ2a_DcAMXXj5+LZeHsRqARfEmbCCpwfVt2fBiana5rH4mWEGA@mail.gmail.com>
 <20170313220715.4mbrqzwcr3xzrcr2@perpetual.pseudorandom.co.uk>
 <CAJ2a_DdCveafhom+5-VHW-Bi7kTNvDx0x2u=-dhKW2x81Q+QFQ@mail.gmail.com>
 <1490121984.2050.3.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490121984.2050.3.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 21 Mar 2017 at 14:46:24 -0400, Stephen Smalley wrote:
> On Tue, 2017-03-14 at 00:11 +0100, cgzones wrote:
> > I created bug report against dbus 1.10 on Debian [1] due to failing
> > to
> > send policyload notices.
> > Are there any objections or comments on the upstream patch[2]?
> 
> Also, the patch looks correct to me.

Thanks, I've cherry-picked it from master to the 1.10 branch. It will
be in dbus 1.10.18, unless the Debian release team ask me to revert it.

    S
