Message-Id: <201206071607.q57G7Y71022409@vivaldi29.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: walters@verbum.org
Cc: SELinux@tycho.nsa.gov
Subject: Re: [PATCH]: allow standard compilation of GIT development tree (was Re: [PATCH]: do not link static libraries from the system library directory)
Date: Thu, 07 Jun 2012 18:07:34 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Colin.

>On Wed, 2012-06-06 at 13:58 -0400, Colin Walters wrote:
>
>> What I was actually saying is that your patch should explicitly
>> separate BUILD_INTERNAL_CFLAGS from CFLAGS.  Automake calls the former
>> AM_CFLAGS, but you can call it whatever you want in your Makefile.

Yes, I have also considered such logic (GIT_CFLAGS) and if it is the preferred way, it can be easily done.

>http://marc.info/?l=selinux&m=105830780118085&w=2
>
>9 years later, discussing the CFLAGS handling again =)
>
>Some things change (I now get binaries in .rpm form instead of .debs,
>libselinux has migrated from cvs to svn to git), some things stay the
>same...

The make system won't change as often as the revision control system, possibly it won't change at all for the whole duration of the project, so it shouldn't be such a bad idea to invest a few minutes in some maintenance...

Regards,

Guido 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
