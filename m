Date: Thu, 1 Nov 2007 00:41:08 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: Serge Hallyn <sergeh@us.ibm.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCHv2] selinux: suppress a warning for 64k pages.
In-Reply-To: <20071031164719.77f48d75.sfr@canb.auug.org.au>
Message-ID: <Xine.LNX.4.64.0711010040290.19784@us.intercode.com.au>
References: <20071031145744.6dd02cc7.sfr@canb.auug.org.au>
 <20071031164719.77f48d75.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 31 Oct 2007, Stephen Rothwell wrote:

> On PowerPC allmodconfig build we get this:
> 
> security/selinux/xfrm.c:214: warning: comparison is always false due to limited range of data type
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  security/selinux/xfrm.c |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)
> 
> This version suppresses the warning without ugly ifdefs.


Thanks, Stephen.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-linus


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
