Subject: Re: Making libselinux depend on libsepol
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118948154.30202.95.camel@moss-spartans.epoch.ncsc.mil>
References: <1118944064.28244.4.camel@celtics.boston.redhat.com>
	 <1118944751.30202.62.camel@moss-spartans.epoch.ncsc.mil>
	 <1118945030.28244.8.camel@celtics.boston.redhat.com>
	 <1118947036.30202.81.camel@moss-spartans.epoch.ncsc.mil>
	 <1118947182.28244.10.camel@celtics.boston.redhat.com>
	 <1118948154.30202.95.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 16 Jun 2005 15:11:28 -0400
Message-Id: <1118949088.28244.23.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> In any event, how do you intend to deal with the user-specified path to
> load_policy(8)? 

Not sure... 

Adding inline: 
int security_unmap_policy(void*data, size_t len)

Adding:
__attribute__ ((format (printf, 1, 2)))
void __selinux_debug_printf(const char *fmt, ...)




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
