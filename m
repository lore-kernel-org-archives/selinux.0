Date: Wed, 30 Oct 2002 10:07:48 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Stephen Smalley <sds@tislabs.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: kernel warning
Message-ID: <20021029230748.GA9936@snoopy.apana.org.au>
References: <20021027042301.GA18290@snoopy.apana.org.au> <Pine.GSO.4.33.0210280741410.29887-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0210280741410.29887-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Oct 28, 2002 at 07:57:06AM -0500, Stephen Smalley wrote:
> SELinux has always included a separate SELinux-specific kernel patch to be
> applied on top of the LSM patch, although the precise purpose of the patch
> has varied over time.  In the current release, the patch is available in
> the SELinux archive in selinux/module/selinux-2.4.patch or directly from
> http://www.nsa.gov/selinux/patches/selinux-2.4-2002102211.patch.gz.  In
> the latest release, the dependence of the SELinux module on this patch has
> increased due to the elimination of precondition functions.  Some of the
> changes in this patch may find their way back into the mainstream LSM
> patch in a more general form in the future (they have all been discussed
> on the LSM mailing list), but some changes are likely to remain
> SELinux-specific.

It appears that with this patch, it is no longer possible to
compile the patched kernel without SE-LINUX support.

Maybe the call to selinux_init() in main.c needs
to be wrapped with #ifdef CONFIG_SECURITY_SELINUX?
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
