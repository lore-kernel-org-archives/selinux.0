Subject: RE: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <36282A1733C57546BE392885C06185924D92D7@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C06185924D92D7@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Message-Id: <1099431274.31739.318.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 16:34:34 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-02 at 13:49, Chad Hanson wrote:
> I would disagree, running with the maximal set of permissions is exactly
> what we are trying to prevent by providing fine-grained privileges.  This
> shouldn't provide  a false sense of security, from a vulnerability point of
> view, because the process is capable of using all current privileges and
> misuse of what it can execute. The minimal use of permission can be used to
> verify that the application is behaving as intended without using unneeded
> permissions for an operation.

>From the kernel POV, any code in the application has the potential to
execute with the maximum set of permissions granted to any domain in the
"domain transition group", or in reality, their union.  You may
carefully write your application to shed and gain permissions as needed,
but an exploit of a flaw in that application may indeed succeed in
getting code to execute in that process with that maximum set of
permissions.  Hence, the application still has to be "trusted" to
exercise that maximal set of permissions, and has a corresponding
assurance burden.  In contrast, if you decompose the application, the
kernel can ensure that only the specific code that should execute with
privilege does so, and the trust burden on the rest of the application
is greatly reduced.  See the difference?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
