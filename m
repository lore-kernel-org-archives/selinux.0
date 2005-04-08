Subject: Re: SELinux packages for SuSE 9.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Dwerryhouse <paul@dwerryhouse.com.au>
Cc: selinux@tycho.nsa.gov, Thomas Bleher <bleher@informatik.uni-muenchen.de>
In-Reply-To: <20050407231425.GA14489@dwerryhouse.com.au>
References: <20050407231425.GA14489@dwerryhouse.com.au>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 07:37:21 -0400
Message-Id: <1112960241.32127.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-04-08 at 09:14 +1000, Paul Dwerryhouse wrote:
> Hi all,
> 
> I have created SELinux-enabled packages for SuSE 9.2, and these can be
> found here:
> 
> http://suse-selinux.leapster.org/
> 
> Packages such as libselinux, policycoreutils, etc, have been built from
> the main NSA SELinux CVS tree.
> 
> I built the other userspace packages by patching SuSE's 9.2 SRPMs with
> the selinux patches from Fedora's devel CVS tree, and in many cases
> modified them to make the patches apply properly.
> 
> Also provided is an SELinux-enabled kernel, based on the 2.6.11.4
> kernel-of-the-day source from SuSE's ftp server, with the latest
> SELinux patch applied.
> 
> I have not altered the policy yet, so as it stands, the system will hang
> if placed into enforcing mode. This is fairly simple to fix - just a small
> change to the getty policy is required - and I hope to have an updated
> policy package available later today. However, there will still be a
> considerable number of policy fixes needed before this is usable.

Have you looked at Thomas Bleher's policy for SuSE?  Also, should I add
a URL to your site to the SuSE page on the SELinux sourceforge site, 
http://selinux.sourceforge.net/distros/suse.php3, and to the selinux-
doc/README?

Now if only someone could get these changes into the main SuSE distro...

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
