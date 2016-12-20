From: Steve Grubb <sgrubb@redhat.com>
To: Gary Tierney <gary.tierney@gmx.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, paul@paul-moore.com
Subject: Re: [PATCH v2 0/2]
Date: Mon, 19 Dec 2016 22:15:36 -0500
Message-ID: <1590451.dna1Fbd7yx@x2>
In-Reply-To: <cover.1482195891.git.gary.tierney@gmx.com>
References: <20161219160041.GB5359@workstation>
 <cover.1482195891.git.gary.tierney@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, December 20, 2016 1:28:45 AM EST Gary Tierney wrote:
> Have updated the patches to print error messages for failures which result
> in indeterminate state and warnings for failures to load policy from
> userspace. Also updated the patches to remove the function name from log
> messages.
> 
> Steve,
> 
> Does your work on AUDIT_MAC_STATUS_FAIL/AUDIT_MAC_LOAD_FAIL messages (I'm
> assuming that's what Stephen's referencing in his previous mail) obsolete
> the printk logs in the first patch?

No, audit cares only about audit events. We don't care at all about syslog 
messages. However, they ought to be singing the same song so to speak.

-Steve
