Message-ID: <43CE880B.3020908@cornell.edu>
Date: Wed, 18 Jan 2006 11:25:15 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Seusers vs ldap
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

How would we go about implementing LDAP support for seusers in libsemanage?
I asked Joshua about this on IRC, but I think we to plan this on list.

I think the most important question to be decided is whether we'll use 
libldap directly, or execute external programs to work with LDAP? The 
first option makes libsemanage always linked to libldap.

I also don't quite understand the role of the system-wide default 
properties in ldap.conf. Joshua is telling me we'll need a server, 
context, and keys specific to semanage (so we have to write all 
ldap-related things in semanage.conf), but I'm not sure why the context 
and server can't be shared with ldap.conf if necessary - I'm probably 
still not understanding how this works - I have very limited knowledge 
of ldap at this point. If you open up system-config-auth on fedora, they 
seem to share the LDAP config for authentication and user info, if you 
enable both of them.

Also, do we have to write a schema? Does that schema get added to the 
slapd package?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
