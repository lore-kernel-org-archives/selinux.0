Subject: Re: setsebool problems
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <4243050D.3050808@redhat.com>
References: <4243050D.3050808@redhat.com>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 13:26:28 -0500
Message-Id: <1111688788.14076.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-24 at 13:21 -0500, Daniel J Walsh wrote:
> So this patch changes the selinux handling of booleans.  First it 
> introduces a new file booleans.local which will contain the users custom 
> boolean settings.  booleans will be changes to a config file so that it 
> will be overwritten by rpm on upgrade.  security_load_booleans now reads 
> booleans and booleans.local to setup boolean values.  setsebool now only 
> writes the changed values to booleans.local.

Don't you need to modify libsepol (sepol_genbools) as well in order to
get booleans.local consulted by load_policy and /sbin/init?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
