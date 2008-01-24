Date: Fri, 25 Jan 2008 09:43:14 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
cc: SELinux List <selinux@tycho.nsa.gov>, linux-kernel@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: make mls_compute_sid always polyinstantiate
In-Reply-To: <4798F57C.8090300@tycho.nsa.gov>
Message-ID: <Xine.LNX.4.64.0801250942580.14081@us.intercode.com.au>
References: <4798F57C.8090300@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 24 Jan 2008, Eamon Walsh wrote:

> This patch removes the requirement that the new and related object types
> differ in order to polyinstantiate by MLS level.  This allows MLS
> polyinstantiation to occur in the absence of explicit type_member rules or
> when the type has not changed.
> 
> Potential users of this support include pam_namespace.so (directory
> polyinstantiation) and the SELinux X support (property polyinstantiation).
> 
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
