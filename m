Date: Mon, 30 Jul 2007 19:39:57 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] SELinux: restore proper NetLabel caching behavior
In-Reply-To: <20070730203331.970255822@hp.com>
Message-ID: <Pine.LNX.4.64.0707301939320.14876@us.intercode.com.au>
References: <20070730203331.970255822@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 30 Jul 2007, Paul Moore wrote:

> A small fix to the SELinux/NetLabel glue code to ensure that the NetLabel
> cache is utilized when possible.  This was broken when the SELinux/NetLabel
> glue code was reorganized in the last kernel release.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
