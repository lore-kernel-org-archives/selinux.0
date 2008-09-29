Subject: Re: user guide drafts: "Working with SELinux" sections
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Valdis.Kletnieks@vt.edu
Cc: Murray McAllister <mmcallis@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <9405.1222399818@turing-police.cc.vt.edu>
References: <48D889A0.1010604@redhat.com>
	 <9405.1222399818@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Mon, 29 Sep 2008 14:31:16 -0400
Message-Id: <1222713076.5429.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-09-25 at 23:30 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 23 Sep 2008 16:16:00 +1000, Murray McAllister said:
> 
> > * selinux-policy-[policy]: provides SELinux policies. For targeted 
> > policy, install selinux-policy-targeted. For MLS, install 
> > selinux-policy-mls. The strict policy was merged in Fedora 9, allowing 
> > confined and unconfined users to co-exist on the same system.
> 
> Strict was merged with what, exactly? (This threw me for a loop when
> strict evaporated out of rawhide, before I figured out that MLS was what
> I needed as the replacement - for most of my boxes, I don't actually *need*
> the MLS/MCS stuff, I just need to not have an 'unconfined' on the box.  For
> a *few* others, the MCS stuff is handy.  And actual MLS is barely on the
> radar here...)

strict policy was merged into targeted policy in F8, which paved the way
for actual user roles in F9.  You can get 95% of the behavior of strict
policy these days just by mapping Linux users to confined SELinux users
using semanage or system-config-selinux, or 100% of its behavior by
removing the unconfined module using semodule (but that's a destructive
operation that requires doing it in permissive and rebooting your system
since you'll invalidate all running processes in unconfined_t).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
