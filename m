Subject: Making libselinux depend on libsepol
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 16 Jun 2005 13:47:44 -0400
Message-Id: <1118944064.28244.4.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I plan to add a function with this signature:

int security_map_policy(void** newdata, size_t* newlen)
or security_create_policy 
or security_construct_policy if you prefer..

It will go into a file called policy.c in libselinux,
and security_load_policy will go in that file too.

The function would basically do what policycoreutils/load_policy.c
does right now - put the policy, users, and booleans together
in one simple function in a library form, as opposed to
calling a tool to do it.

However, that makes libselinux depend on libsepol....
Is that a bad thing?




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
