Subject: Re: make install fails if any users are in local.users
From: Colin Walters <walters@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, Daniel J Walsh <dwalsh@redhat.com>,
   selinux@tycho.nsa.gov
In-Reply-To: <1110979208.4802.45.camel@moss-spartans.epoch.ncsc.mil>
References: <1110672353.29153.2.camel@cobra.ivg2.net>
	 <4235BE2F.8020009@redhat.com> <1110821742.16850.14.camel@cobra.ivg2.net>
	 <42360347.1030105@redhat.com>  <1110838214.19525.1.camel@cobra.ivg2.net>
	 <1110864047.30167.8.camel@cobra.ivg2.net>
	 <1110979208.4802.45.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 09:24:04 -0500
Message-Id: <1110983044.3914.24.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-03-16 at 08:20 -0500, Stephen Smalley wrote:
> One question is whether setfiles -c
> should only validate the base file_contexts configuration (which no
> longer contains the home directory entries at all). 

I don't see a good alternative, really.  The home directory stuff is
entirely dynamic and outside policy build.  

Perhaps though genhomedircon itself could run setfiles -c though on e.g.
file_contexts.homedir.tmp before renaming it to file_contexts.homedir.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
