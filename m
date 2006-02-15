Subject: Re: [RFC][PATCH] collect security labels on user processes
	generating audit messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov,
   Linux Audit Discussion <linux-audit@redhat.com>,
   James Morris <jmorris@namei.org>
In-Reply-To: <1140018578.11792.23.camel@localhost>
References: 
	 <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
	 <1139530450.12638.7.camel@localhost>
	 <1139857945.14253.112.camel@moss-spartans.epoch.ncsc.mil>
	 <1139960902.326.5.camel@localhost>
	 <1140011251.14253.346.camel@moss-spartans.epoch.ncsc.mil>
	 <1140018578.11792.23.camel@localhost>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 11:17:18 -0500
Message-Id: <1140020238.14253.404.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-02-15 at 09:49 -0600, Timothy R. Chavez wrote:
> This makes sense to me.  I'll go ahead and make the change.  I wouldn't
> even technically need the function or function call in my patch since
> selinux_available() simply returns ss_initialized.

Well, I think we want to keep that variable private to the SELinux
"module".  In the future, we'll likely add proper namespace prefixes to
all non-static SELinux symbols to avoid polluting the kernel namespace.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
