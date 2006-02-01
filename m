Subject: Re: labeling of compilers etc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SELinux-dev@tresys.com, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1138801545.18268.32.camel@moss-spartans.epoch.ncsc.mil>
References: <200601291156.13076.russell@coker.com.au>
	 <1138631347.7076.32.camel@moss-spartans.epoch.ncsc.mil>
	 <200601311847.56015.russell@coker.com.au>
	 <1138801545.18268.32.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 08:47:33 -0500
Message-Id: <1138801653.18268.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-02-01 at 08:45 -0500, Stephen Smalley wrote:
> This is not exactly equivalent, see above.  Also, it should be possible
> to eliminate the kernel race condition on interpreted scripts; Solaris
> does this by pre-opening the script file and passing /dev/fd/<n> to the
> interpreter so that there is second lookup of the script file.

The above should obviously be "...no second lookup of the script
file...".

>   This
> still wouldn't make setuid/setgid bash scripts a good idea, but other
> scripting languages may be more resilient to caller influence.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
