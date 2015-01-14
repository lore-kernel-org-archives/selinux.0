Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0EKEEqd018444
 for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2015 15:14:14 -0500
From: Paul Moore <pmoore@redhat.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH 6/9] gen_initramfs_list.sh: include xattrs
Date: Wed, 14 Jan 2015 14:36:46 -0500
Message-ID: <1584934.WkKQGAFadF@sifl>
In-Reply-To: <1421205803.2119.110.camel@dhcp-9-2-203-236.watson.ibm.com>
References: <1420663980-20842-1-git-send-email-zohar@linux.vnet.ibm.com>
 <54B5913C.5050109@landley.net>
 <1421205803.2119.110.camel@dhcp-9-2-203-236.watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: initramfs <initramfs@vger.kernel.org>, selinux@tycho.nsa.gov,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "casey.schaufler" <casey.schaufler@intel.com>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 Josh Boyer <jwboyer@fedoraproject.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Rob Landley <rob@landley.net>, linux-ima-devel@lists.sourceforge.net,
 Fionnuala Gunter <fin@linux.vnet.ibm.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, January 13, 2015 10:23:23 PM Mimi Zohar wrote:
> I would assume only 'security.evm' is not portable as it attempts to
> tightly bind the file metadata to the file data.  Casey?  Paul?

[NOTE: Added the SELinux mailing list to the CC line.]

The SELinux xattr should be portable assuming the security label's semantics 
remain constant across the different security policies.  If the label is 
completely unknown SELinux should handle it correctly, it will be treated as 
unlabeled until a module is loaded which defines the label.

Although, this is just for initramfs, yes?  If so, I'm not sure this matters 
that much from a practical point of view; Stephen or someone else from the 
SELinux list may have some thoughts on this.

-- 
paul moore
security @ redhat
