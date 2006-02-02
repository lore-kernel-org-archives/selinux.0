Subject: Re: labeling of compilers etc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: James Morris <jmorris@namei.org>, SELinux-dev@tresys.com,
   SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <200602021027.16336.russell@coker.com.au>
References: <200601291156.13076.russell@coker.com.au>
	 <200601311847.56015.russell@coker.com.au>
	 <1138801545.18268.32.camel@moss-spartans.epoch.ncsc.mil>
	 <200602021027.16336.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 07:32:32 -0500
Message-Id: <1138883552.18268.114.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-02 at 10:27 +1100, Russell Coker wrote:
> I probably should have split this discussion into two messages.  There are two 
> issues here, that of domain_auto_trans() on shell scripts and that of general 
> execution of shell code.
> 
> You are correct that there is no domain transition related to the script when 
> the shell is executed directly.  However it's still desirable to enforce 
> access control over which files can be executed.

True.  But it isn't clear what you gain from shell-enforced access
control when the shell is running in the caller's domain, because the
caller can then easily influence and control the shell in order to
bypass its checking (e.g. using LD_* variables, running the shell under
a debugger, etc).  This might require first importing precompiled code
into the target system from an external site, but that likely isn't
difficult if one gained access in the first place.

Stephen Smalley wrote:
> > Also, it should be possible
> > to eliminate the kernel race condition on interpreted scripts; Solaris
> > does this by pre-opening the script file and passing /dev/fd/<n> to the
> > interpreter so that there is no second lookup of the script file.  This
> > still wouldn't make setuid/setgid bash scripts a good idea, but other
> > scripting languages may be more resilient to caller influence.

Russell Coker wrote:
> That is a really good idea.  You are correct that setuid and 
> domain_auto_trans() shell scripts are still a really bad idea (the shell is 
> far too dependent on environment variables etc).  But anything that makes 
> hostile action more difficult is a good thing.

Yes.  If I recall correctly, one stumbling block in making the above
change in Linux is that in Linux, the /dev/fd/<n> links
-> /proc/self/fd/<n> links become inaccessible under setuid/setgid
(except for setuid to root, of course).  So one would have to alter that
restriction while still dealing with the potential leak issue there.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
