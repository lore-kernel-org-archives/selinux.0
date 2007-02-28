Subject: [RFC] Dropping compat support for /etc/security policy file paths
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Steve G <linux_4ever@yahoo.com>, Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Manoj Srivastava <manoj.srivastava@stdc.com>,
        Russell Coker <russell@coker.com.au>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: text/plain
Date: Wed, 28 Feb 2007 08:01:52 -0500
Message-Id: <1172667712.19041.455.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Are any active distributions still using the old /etc/security/ location
and layout for SELinux policy files?  If not, we could drop the compat
file path support from libselinux on the trunk.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
