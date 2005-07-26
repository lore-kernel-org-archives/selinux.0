Subject: Re: [ libsepol 10 ] Bugfixes for 0-9
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1122404471.6329.42.camel@celtics.boston.redhat.com>
References: <1121967118.9844.17.camel@celtics.boston.redhat.com>
	 <1122386595.4470.40.camel@moss-spartans.epoch.ncsc.mil>
	 <1122387393.4470.54.camel@moss-spartans.epoch.ncsc.mil>
	 <1122393674.4470.73.camel@moss-spartans.epoch.ncsc.mil>
	 <1122393858.2812.5.camel@celtics.boston.redhat.com>
	 <1122395431.2812.13.camel@celtics.boston.redhat.com>
	 <1122396106.4470.76.camel@moss-spartans.epoch.ncsc.mil>
	 <1122396779.2812.32.camel@celtics.boston.redhat.com>
	 <1122404439.4470.117.camel@moss-spartans.epoch.ncsc.mil>
	 <1122404471.6329.42.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 15:06:06 -0400
Message-Id: <1122404766.4470.122.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-07-26 at 15:01 -0400, Ivan Gyurdiev wrote:
> Remove unnecessary null-termination as pointed out (priv mail)?

Yes.

> If null termination is removed +1 strlen should also go away.

No.  Still need that for the nul terminator after the type when !
mls_enabled.  That is why it used to be included in that computation -
it was either going to be for the field separator or the nul terminator
after the type, depending on whether or not MLS was enabled.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
