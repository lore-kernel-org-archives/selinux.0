Subject: Re: [RFC][PATCH] collect security labels on user
	processes	generating audit messages
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Linux Audit Discussion <linux-audit@redhat.com>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <1140618378.31467.199.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
	 <1139530450.12638.7.camel@localhost>
	 <1139857945.14253.112.camel@moss-spartans.epoch.ncsc.mil>
	 <1139960902.326.5.camel@localhost>  <43F39797.1050602@trustedcs.com>
	 <1140209880.752.12.camel@localhost>
	 <1140618378.31467.199.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 11:13:24 -0600
Message-Id: <1140628404.9332.1.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-02-22 at 09:26 -0500, Stephen Smalley wrote:
> On Fri, 2006-02-17 at 14:58 -0600, Timothy R. Chavez wrote:
> > Thanks Darrel!  New patch attached... so... assuming this is good... how
> > are we going to do this API merger :] ?
> 
> Looks like your selinux_task_getsecid could be dropped in favor of
> Darrel's selinux_task_ctxid.
> 

Yeah.  I'll post an updated patch against his work when it goes
upstream.  That seems to be the easiest solution.  Thanks.

-tim


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
