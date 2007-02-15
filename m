Subject: Re: [RFC] Ability to allow undefined permissions and classes -v2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, Eric Paris <eparis@redhat.com>,
        Chad Sellers <csellers@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <45D4AE8B.1080902@mentalrootkit.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015888BA220@exchange.columbia.tresys.com>
	 <1171564421.32574.36.camel@moss-spartans.epoch.ncsc.mil>
	 <45D4AE8B.1080902@mentalrootkit.com>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 14:19:53 -0500
Message-Id: <1171567193.32574.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-15 at 14:03 -0500, Karl MacMillan wrote:
> Stephen Smalley wrote:
> > On Wed, 2007-02-14 at 14:22 -0500, Joshua Brindle wrote:
> >>> From: Eric Paris [mailto:eparis@redhat.com] 
> >>> That is my point of question and lack of understanding.  Will 
> >>> the policy which is passed to the kernel have all of the 
> >>> policy for all of the system or only that for the kernel?  
> >>> The way I see both cases:
> >>>
> >> Only for the kernel.
> > 
> > Actually, I thought you had found that the userspace security server
> > isn't much of a win (and a definite cost) for current usage by e.g. the
> > X server.  Which would suggest that we aren't likely to evict userspace
> > policy from the kernel any time soon.
> > 
> 
> And the cost is not just performance (which is a large cost - the number 
> of context switches will always make it lose). There are:
> 
> - Problems synchronizing policy change (which is particularly bad when 
> contexts are invalidated). This includes boolean changes.
> 
> - Increased user-visible complexity in libselinux (including a new 
> configuration file for routing).
> 
> - Potentially overlapping object classes (e.g., for something like 
> samba, should answers about "file" come from the kernel or the userspace 
> security server).
> 
> - Potential for the death of the userspace security server (including 
> things like the OOM killer) or extreme performance problems under heavy 
> swapping.
> 
> The only potential win is reduced kernel memory usage for policy, but 
> the total memory footprint for kernel + userspace security server is 
> likely much higher and it is not clear that the ability to swap portions 
> of the userspace security server is desirable. I think we will get 
> further by reducing the kernel policy memory footprint.
> 
> Even when you want to disable kernel enforcement for some object classes 
> I think that the userspace security server loses (this is something I 
> have suggested to allow userspace apps like DBUS to rely entirely on 
> SELinux policy instead of SELinux + custom security policy). In those 
> scenarios you are likely still going to want labeling to happen for 
> processes, files, etc. even if many of the access checks are disabled. 
> That means there will still need to be a policy loaded into the kernel.
> 
> I don't see any compelling use for the userspace security server and 
> don't think we should make kernel changes with the assumption that it 
> will be present in the future.

The userspace security server still has potential utility for higher
level application policies that are orthogonal to the local kernel's
policy, like the RAdAC work.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
