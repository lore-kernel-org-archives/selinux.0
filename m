Date: Thu, 25 May 2006 08:06:54 -0700
Subject: Re: Fedora Core 5 Tomcat 4 problems
From: Michael Smith <mksmith@adhost.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
CC: <SELinux@tycho.nsa.gov>
Message-ID: <C09B161E.5B85%mksmith@adhost.com>
In-Reply-To: <1148562995.14262.4.camel@sgc.columbia.tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov




On 5/25/06 6:16 AM, "Christopher J. PeBenito" <cpebenito@tresys.com> wrote:

> On Wed, 2006-05-24 at 13:02 -0400, Stephen Smalley wrote:
>> On Wed, 2006-05-24 at 09:20 -0700, Michael K. Smith wrote:
>>> I am attempting to start Tomcat 4 using an rc script that uses the
>>> unprivileged user "tomcat" to run the application.
> 
>>> allow initrc_su_t security_t:security compute_av;
>> 
>> pam_rootok permission check from su.
> 
> I have added this to su domains in reference policy.

Thank you to everyone for the help.  I did the runuser modification and that
did indeed fix the issue.  Once I download the new reference policy I'll
also remove the local policy per Stephen's advice.

Regards,

Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
