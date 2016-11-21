Subject: Re: [RFC][PATCH] selinux: Remove unused permission definitions
To: Nick Kralevich <nnk@google.com>
References: <1432739005-1955-1-git-send-email-sds@tycho.nsa.gov>
 <20150614053349.GA5191@localhost.localdomain>
 <557EC809.5050002@tycho.nsa.gov>
 <CAFJ0LnHTLD74Tatd7N=nY6TDH1wUE-xXukp0_aRXywjVwJ1upQ@mail.gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d4917968-9b05-5a80-d179-c281ebd8ead8@tycho.nsa.gov>
Date: Mon, 21 Nov 2016 16:06:42 -0500
MIME-Version: 1.0
In-Reply-To: <CAFJ0LnHTLD74Tatd7N=nY6TDH1wUE-xXukp0_aRXywjVwJ1upQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/21/2016 03:48 PM, Nick Kralevich wrote:
> 
> 
> On Mon, Jun 15, 2015 at 5:41 AM, Stephen Smalley <sds@tycho.nsa.gov
> <mailto:sds@tycho.nsa.gov>> wrote:
> 
>     On 06/14/2015 01:33 AM, Dominick Grift wrote:
>     > On Wed, May 27, 2015 at 11:03:25AM -0400, Stephen Smalley wrote:
>     >> Remove unused permission definitions from SELinux.
>     >> Many of these were only ever used in pre-mainline
>     >> versions of SELinux, prior to Linux 2.6.0.  Some of them
>     >> were used in the legacy network or compat_net=1 checks
>     >> that were disabled by default in Linux 2.6.18 and
>     >> fully removed in Linux 2.6.30.
>     >>
>     >> Permissions never used in mainline Linux:
>     >> file swapon
>     >
>     > I think that blk_file (fixed disk) swapon is actually used in my policy by fstools (i think swapon command)
> 
>     It isn't checked anywhere in the SELinux kernel code, so it might be
>     defined in your policy but it has no meaning.  The LSM hook and SELinux
>     hook function implementation that applied the check was never merged
>     into mainline.
> 
> 
> Why was the LSM hook and SELinux hook function implementation for swapon
> never mainlined? 
> 
> In particular, without some kind of swapon check, a process with
> CAP_SYS_ADMIN could take any readable-writeable file, call swapon on the
> file, force swapping, and gain read-write access to another process memory. 
> 
> Can we try to get these patches mainlined again?

I think it just wasn't a high priority, since the operation was already
being controlled via CAP_SYS_ADMIN (and thus also SELinux :capability
sys_admin check) and there wasn't a clear use case for distinguishing
it.  Given that there are over 500 CAP_SYS_ADMIN checks in the kernel,
it is unclear how much we would gain by separately restricting just
swapon.  A more comprehensive audit of all CAP_SYS_ADMIN checks and
adding finer-grained LSM hooks and/or new finer-grained capabilities
would likely be useful, but is not a trivial undertaking.  One can
disable swap altogether via CONFIG_SWAP=n if you don't need that
functionality at all.
