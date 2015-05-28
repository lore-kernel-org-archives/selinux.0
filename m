Message-ID: <55675F02.70201@tycho.nsa.gov>
Date: Thu, 28 May 2015 14:31:30 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: getpidcon() behaviour when other LSM is enabled
References: <20150528200648.6fb9e949@fornost.bigon.be>
In-Reply-To: <20150528200648.6fb9e949@fornost.bigon.be>
Content-Type: text/plain; charset=windows-1252
Cc: 786956@bugs.debian.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/28/2015 02:06 PM, Laurent Bigonville wrote:
> Hello,
> 
> In procps(-ng)[0] when the use of libselinux is enabled at build time,
> it always uses getpidcon() even if an other (or no) LSM is enabled.
> 
> I tried to use getpidcon() (via the cmd tool getpidcon) with apparmor
> enabled instead of selinux, and it returned the apparmor context.
> Is this expected and can we rely on this?

Fundamentally, getpidcon() just reads the value of
/proc/pid/attr/current into a dynamically allocated buffer and returns
it.  That part should work for any security module.  The only other
thing getpidcon() does is pass the context to mcstransd for context
translation if mcstransd is running.  That could potentially break if
you happen to be running mcstransd on a non-SELinux system, although I
don't know why anyone would.  Possibly we ought to have mcstransd test
is_selinux_enabled() and bail immediately if it is disabled just to
preclude that.

> Otherwise, I've prepared the attached patch. Would this patch be
> acceptable?
> 
> Cheers,
> 
> Laurent Bigonville
> 
> [0] https://gitlab.com/procps-ng/procps/blob/master/ps/output.c#L1237
> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
