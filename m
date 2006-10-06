Subject: Re: [RFC PATCH] newrole suid breakdown
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: Steve Grubb <sgrubb@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>, jdesai@us.ibm.com
In-Reply-To: <452674C8.2040105@us.ibm.com>
References: <452432FA.1060009@us.ibm.com>
	 <1160079125.2132.232.camel@moss-spartans.epoch.ncsc.mil>
	 <45256F49.1070105@us.ibm.com>  <200610051748.06669.sgrubb@redhat.com>
	 <1160146343.12253.85.camel@moss-spartans.epoch.ncsc.mil>
	 <452674C8.2040105@us.ibm.com>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 11:49:51 -0400
Message-Id: <1160149791.12253.121.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-06 at 10:22 -0500, Michael C Thompson wrote:
> Stephen Smalley wrote:
> > On the question of checking whether an app is suid, I don't see any way
> > to do that in Linux unambiguously, since there is always the case where
> > the caller was already in the same uid as the file.
> 
> Apparently, there is a way to check. Klaus showed me this yesterday, but 
> he pointed out that it might not be accurate due to SELinux transitions. 
> I have tried this, it doesn't seem like the context of the executable 
> (for transitions) affects this value.
> 
> #include <stdio.h>
> 
> extern int __libc_enable_secure;
> 
> int main() {
> 	printf("%d\n", __libc_enable_secure);
> }
> 
> If someone can also confirm this behavior, this could be the solution 
> we're looking for. Not sure how acceptable it is though, as it is kinda 
> hackish.

No, that has the same ambiguity; if the caller already had uid 0, then
__libc_enable_secure will be 0 (it is set based on the AT_SECURE value
provided by the kernel, and the kernel is just comparing the euid
against the uid and the egid against the gid, plus the SELinux check).

Context transitions also cause it to be set unless a particular
permission is allowed between the caller and the new domain (naturally
you have to be in enforcing mode too).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
