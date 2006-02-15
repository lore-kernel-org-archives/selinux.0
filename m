Subject: Re: [RFC][PATCH] collect security labels on user processes
	generating audit messages
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@redhat.com>, selinux@tycho.nsa.gov,
   Linux Audit Discussion <linux-audit@redhat.com>,
   James Morris <jmorris@namei.org>
In-Reply-To: <1140020238.14253.404.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
	 <1139530450.12638.7.camel@localhost>
	 <1139857945.14253.112.camel@moss-spartans.epoch.ncsc.mil>
	 <1139960902.326.5.camel@localhost>
	 <1140011251.14253.346.camel@moss-spartans.epoch.ncsc.mil>
	 <1140018578.11792.23.camel@localhost>
	 <1140020238.14253.404.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 10:41:13 -0600
Message-Id: <1140021673.11805.39.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-02-15 at 11:17 -0500, Stephen Smalley wrote:
> On Wed, 2006-02-15 at 09:49 -0600, Timothy R. Chavez wrote:
> > This makes sense to me.  I'll go ahead and make the change.  I wouldn't
> > even technically need the function or function call in my patch since
> > selinux_available() simply returns ss_initialized.
> 
> Well, I think we want to keep that variable private to the SELinux
> "module".  In the future, we'll likely add proper namespace prefixes to
> all non-static SELinux symbols to avoid polluting the kernel namespace.
>  

I think maybe I miscommunicated my intentions.  If I move the check to
determine whether or not SELinux is enabled into selinux_id_to_ctx(),
then I can simply use ss_initialized directly rather then calling
selinux_available(), as I'll be making the check within the SELinux
"module" (selinux/exports.c).

-tim


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
