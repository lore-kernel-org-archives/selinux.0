Subject: Re: [ libsepol 10 ] Bugfixes for 0-9
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: SELinux <selinux@tycho.nsa.gov>
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
Date: Tue, 26 Jul 2005 15:00:39 -0400
Message-Id: <1122404439.4470.117.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-07-26 at 12:52 -0400, Ivan Gyurdiev wrote:
> You're right, I need to do this properly, and post the relative
> patch on list - attached.
> 
> Depends on: 
> 
> libsepol-1.1-context.diff 
> libsepol-1.2-ports.diff               
> libsepol-1.2-interfaces.diff 
> libsepol-1.2-fix_memory_leaks.diff 
> libsepol-3.1-write_services_printf.diff

Ok, all ten merged, plus the uninit variable patch posted by Dan.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
