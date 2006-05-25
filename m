Subject: Re: Fedora Core 5 Tomcat 4 problems
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Michael K. Smith" <mksmith@adhost.com>, SELinux@tycho.nsa.gov
In-Reply-To: <1148490176.24463.454.camel@moss-spartans.epoch.ncsc.mil>
References: <C099D5CE.24D51%mksmith@adhost.com>
	 <1148490176.24463.454.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 25 May 2006 09:16:35 -0400
Message-Id: <1148562995.14262.4.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-24 at 13:02 -0400, Stephen Smalley wrote:
> On Wed, 2006-05-24 at 09:20 -0700, Michael K. Smith wrote:
> > I am attempting to start Tomcat 4 using an rc script that uses the
> > unprivileged user "tomcat" to run the application.

> > allow initrc_su_t security_t:security compute_av;
> 
> pam_rootok permission check from su.

I have added this to su domains in reference policy.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
