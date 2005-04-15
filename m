Subject: Re: make install fails if any users are in local.users
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Colin Walters <walters@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <1113553156.17324.12.camel@cobra.ivg2.net>
References: <1110672353.29153.2.camel@cobra.ivg2.net>
	 <4235BE2F.8020009@redhat.com> <1110821742.16850.14.camel@cobra.ivg2.net>
	 <42360347.1030105@redhat.com>  <1110838214.19525.1.camel@cobra.ivg2.net>
	 <1110864047.30167.8.camel@cobra.ivg2.net>
	 <1110979208.4802.45.camel@moss-spartans.epoch.ncsc.mil>
	 <1110983044.3914.24.camel@nexus.verbum.private>
	 <1110986633.4802.88.camel@moss-spartans.epoch.ncsc.mil>
	 <1113553156.17324.12.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 08:07:11 -0400
Message-Id: <1113566831.3810.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-04-15 at 04:19 -0400, Ivan Gyurdiev wrote:
> > 
> > > Perhaps though genhomedircon itself could run setfiles -c though on e.g.
> > > file_contexts.homedir.tmp before renaming it to file_contexts.homedir.
> 
> Can you clarify how this is different from the Makefile running setfiles
> -c? I thought this was working for a while, but it seems not - it's
> broken again:

It isn't different - mistake on my part.  Already reported to the list,
and the genhomedircon change was reverted in the latest policycoreutils.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
