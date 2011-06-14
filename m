Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5EHawpO027725
	for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2011 13:36:58 -0400
Received: from mail-iy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p5EHavFM003742
	for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2011 17:36:57 GMT
Received: by iyb26 with SMTP id 26so6348641iyb.12
        for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2011 10:36:57 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 14 Jun 2011 10:36:55 -0700
Message-ID: <BANLkTikdwRevmnuj7Lw6Vtv=d-iFHd45Yg@mail.gmail.com>
Subject: /etc/selinux/$P/users/local.users and system.users are they deprecated?
From: Sam Gandhi <samgandhi9@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Dear Experts,

First in my environment I am not allowed to ship python, so I can't
use wonderful tool semanage.

I admit that I am bit  confused (&intimidated) by so many files to
manage that constitutes SELinux configuration.

Are files /etc/selinux/$P/users/local.users & system.users required
for proper functioning of SELinux user-space libraries? Or user/roles
defined in policy definitions sufficient?

I looked at the latest libselinux code it still has code to use
local.users but didn't see code that actually uses system.users,  Aksi
reference policy make install also installs these files.

However in the the mailing list I have seen references back in
2005/2006 that these files are deprecated? The latest pdf file that
was mailed out recently also has reference to local.users but not to
system.users.

If system.users file is still valid which definition then takes the
precedence and doesn't this expose a security hole that someone can
change user role after the policy was generated?

In my policy definitions I am defining a new user diags_u, type
diags_t and role diags_r, essentially following statements in
policy.conf (through macros etc)

type diags_t, domain, userdomain, unpriv_userdomain, nscd_client_domain, privfd;
role diags_r types diags_t;
user diags_u roles { diags_r };

Is that sufficient?  fwiw, I have been able to transition to
diags_u:diags_r:diags_t context using the newrole command, when using
policy that contains above statements.

-Sam

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
