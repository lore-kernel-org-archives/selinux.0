Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1TG1WRb022567
	for <selinux@tycho.nsa.gov>; Sun, 29 Feb 2004 11:01:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1TG1LQQ007305
	for <selinux@tycho.nsa.gov>; Sun, 29 Feb 2004 16:01:21 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id i1TG1KP0007302 for <selinux@tycho.nsa.gov>; Sun, 29 Feb 2004 16:01:20 GMT
Date: Sun, 29 Feb 2004 16:01:06 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, selinux@tycho.nsa.gov
Subject: Re: Attn Colin: Overhelpful /usr/sbin/policy-remove-unwanted
Message-ID: <20040229160106.GH24151@vnl.com>
References: <20040228181418.GO11147@vnl.com> <200402291344.28017.russell@coker.com.au> <20040229042610.GA11147@vnl.com> <200402291545.38528.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200402291545.38528.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Feb 29, 2004 at 03:45:38PM +1100, Russell Coker wrote:
> On Sun, 29 Feb 2004 15:26, Dale Amon <amon@vnl.com> wrote:
> > On Sun, Feb 29, 2004 at 01:44:28PM +1100, Russell Coker wrote:
> > > The syslog.te file has policy to allow syslog-ng to perform klogd
> > > functionality.  Why don't you have syslogd working in that manner?
> >
> > I just thought about what you said here. Are we on the
> > same page? The problem I'm seeing is to do with Colin's
> > script deciding to remove klogd.te because there is no
> > klogd debian package installed... which is because the
> > debian syslog-ng package doesn't need the klogd package.
> 
> That should be OK, the policy is written to support this.
> 
> > This causes a problem later because the POLICY files
> > require klogd.te regardless of whether there is a
> > klogd debian package or not.
> 
> What is the problem?  When I compile a policy without klogd (suitable for a 
> syslog-ng system) it works.

After Colin's install script removes klogd.te, the policy build fails:

Using policy installation method "Automatic"
/usr/bin/checkpolicy:  loading policy configuration from /etc/security/selinux/src/policy.conf
ERROR 'unknown type klogd_t' at token ';' on line 39546:
#
neverallow ~klogd_t proc_kmsg_t:file ~{ getattr };
/usr/bin/checkpolicy:  error(s) encountered while parsing configuration
make: *** [/etc/security/selinux/policy.15] Error 1
dpkg: error processing selinux-policy-default (--configure):
 subprocess post-installation script returned error exit status 2
Errors were encountered while processing:
 selinux-policy-default

In my current scripts, I have a workaround: after the initial
failure I have an explicit cp to replace klogd.te; this allows
me to successfully complete the package install.

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
