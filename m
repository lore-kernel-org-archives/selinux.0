Subject: Re: [ libsepol 10 ] Bugfixes for 0-9
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: SELinux <selinux@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1122396779.2812.32.camel@celtics.boston.redhat.com>
References: <1121967118.9844.17.camel@celtics.boston.redhat.com>
	 <1122386595.4470.40.camel@moss-spartans.epoch.ncsc.mil>
	 <1122387393.4470.54.camel@moss-spartans.epoch.ncsc.mil>
	 <1122393674.4470.73.camel@moss-spartans.epoch.ncsc.mil>
	 <1122393858.2812.5.camel@celtics.boston.redhat.com>
	 <1122395431.2812.13.camel@celtics.boston.redhat.com>
	 <1122396106.4470.76.camel@moss-spartans.epoch.ncsc.mil>
	 <1122396779.2812.32.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 13:43:52 -0400
Message-Id: <1122399832.6329.11.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Actually that null-terminates it twice...at least one should stay
I think, because an mls_sid_to_context doesn't null-terminate.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
