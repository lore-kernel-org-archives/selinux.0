Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3ENG632010812
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2011 19:16:06 -0400
Received: from countercultured.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p3ENG57J029329
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2011 23:16:05 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_944b1c09de5d78584ba55e49e61739d6"
Date: Thu, 14 Apr 2011 19:16:07 -0400
From: David Quigley <dpquigl@davequigley.com>
To: <selinux@tycho.nsa.gov>
Subject: Writing SEPostGreSQL Database Policies
Message-ID: <2f3e05e6cc143592e0fc799462fd940f@countercultured.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=_944b1c09de5d78584ba55e49e61739d6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8



Are there any good examples out there of locking down a webapp's
access to a database using SEPostGreSQL and some web language like Ruby
on Rails? I looked at Kaigai's and the SELinux Notebook examples for
sepgsql policy and it seems to use the types in reference policy instead
of creating new types for objects and only provides separation through
MCS. It would be nice to go over either an indepth example that uses
different types from reference policy or maybe showcases locking down a
specific application.
--=_944b1c09de5d78584ba55e49e61739d6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<p>Are there any good examples out there of locking down a webapp's access =
to a database using SEPostGreSQL and some web language like Ruby on Rails? =
I looked at Kaigai's and the SELinux Notebook examples for sepgsql policy a=
nd it seems to use the types in reference policy instead of creating new ty=
pes for objects and only provides separation through MCS. It would be nice =
to go over either an indepth example that uses different types from referen=
ce policy or maybe showcases locking down a specific application.</p>
--=_944b1c09de5d78584ba55e49e61739d6--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
