Subject: Re: Patch to correct genhomedircon homedir labeling.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <462E1745.8050608@redhat.com>
References: <462E1745.8050608@redhat.com>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 16:30:17 -0400
Message-Id: <1177446617.24282.195.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-04-24 at 10:42 -0400, Daniel J Walsh wrote:
> semanage can change the __default__ login mapping command to a user 
> other than user_u.  This patch will cause genhomedircon to use this 
> setting rather than currently always using user_u.
> 
> semanage login -m -s staff_u __default__
> 
> 
> Should cause all login accounts added by useradd to use staff_home* by 
> default.

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
