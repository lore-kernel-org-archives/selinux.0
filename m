Subject: Re: More patches
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1121455871.10134.21.camel@celtics.boston.redhat.com>
References: <1121455871.10134.21.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Mon, 18 Jul 2005 10:31:20 -0400
Message-Id: <1121697080.32546.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-07-15 at 15:31 -0400, Ivan Gyurdiev wrote:
> The following patch removes the utilities
> genpolusers and genpolbools from libsepol:
> 
> libsepol-0-remove_genutils.diff
> 
> They are of limited value, and mostly superseded by load_policy.
> In the future they will be superseded by a new utility called
> gen policy.

Merged.

> The following patch makes restorecon use standard output 
> for displaying status information, which will make it
> easier to handle failure in our startup script.
> 
> policycoreutils-restorecon-stdout.diff

Hmm...why not just use printf then?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
