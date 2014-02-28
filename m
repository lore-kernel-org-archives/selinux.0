From: Paul Moore <pmoore@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: put the mmap() DAC controls before the MAC
 controls
Date: Fri, 28 Feb 2014 07:22:23 -0500
Message-ID: <3760564.vHA94ycV4h@sifl>
In-Reply-To: <530F9B1B.3020204@tycho.nsa.gov>
References: <20140227143045.14242.66994.stgit@localhost>
 <530F976E.8050108@tycho.nsa.gov> <530F9B1B.3020204@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: casey.schaufler@intel.com, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, February 27, 2014 03:07:55 PM Stephen Smalley wrote:
> Looking at Fedora policy, there are differences in what domains are
> allowed mmap_zero vs sys_rawio, although I don't know how
> intentional/meaningful that is.
> 
> sesearch -A -p mmap_zero
> vs
> sesearch -A -p sys_rawio
> 
> Why for example does cupsd_t have sys_rawio?  That's rather disturbing.
> 
> I guess you should keep the separate check until those differences are
> resolved.

No more comments overnight so I'm going to go ahead and push this to next with 
your ack added.  We can always remove the SELinux check at a later date.

Thanks.

-- 
paul moore
security and virtualization @ redhat
