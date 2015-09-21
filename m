From: Paul Moore <pmoore@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH] selinux: change
 CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE default
Date: Mon, 21 Sep 2015 15:56:32 -0400
Message-ID: <2601412.Wz9Bm6Unux@sifl>
In-Reply-To: <56005D35.6000503@tycho.nsa.gov>
References: <20150921193434.11997.2963.stgit@localhost>
 <56005D35.6000503@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Monday, September 21, 2015 03:40:37 PM Stephen Smalley wrote:
> On 09/21/2015 03:34 PM, Paul Moore wrote:
> > Change the SELinux checkreqprot default value to 0 so that SELinux
> > performs access control checking on the actual memory protections
> > used by the kernel and not those requested by the application.
> > 
> > Signed-off-by: Paul Moore <pmoore@redhat.com>
> 
> Any ideas on whether this breaks any supported version of RHEL or Fedora?

Rawhide currently sets /sys/fs/selinux/checkreqprot to 0 during boot and a 
little birdy told me that F22 does the same.  We're currently looking into 
RHEL.

> > diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> > index bca1b74..8691e92 100644
> > --- a/security/selinux/Kconfig
> > +++ b/security/selinux/Kconfig
> > @@ -78,7 +78,7 @@ config SECURITY_SELINUX_CHECKREQPROT_VALUE
> > 
> >  	int "NSA SELinux checkreqprot default value"
> >  	depends on SECURITY_SELINUX
> >  	range 0 1
> > 
> > -	default 1
> > +	default 0
> > 
> >  	help
> >  	
> >  	  This option sets the default value for the 'checkreqprot' flag
> >  	  that determines whether SELinux checks the protection requested
> > 
> > @@ -92,7 +92,7 @@ config SECURITY_SELINUX_CHECKREQPROT_VALUE
> > 
> >  	  'checkreqprot=' boot parameter.  It may also be changed at runtime
> >  	  via /selinux/checkreqprot if authorized by policy.
> > 
> > -	  If you are unsure how to answer this question, answer 1.
> > +	  If you are unsure how to answer this question, answer 0.
> > 
> >  config SECURITY_SELINUX_POLICYDB_VERSION_MAX
> >  
> >  	bool "NSA SELinux maximum supported policy format version"
> 
> If we're killing legacy options, can we call this one (and the one that
> depends on it) too?  They were only needed for Fedora 3 and 4, and
> people often trip over them because they blindly enable all of the
> SELinux options and thereby force their kernels to old policy versions.

I have no emotional attachment to it, does anyone object?

-- 
paul moore
security @ redhat
