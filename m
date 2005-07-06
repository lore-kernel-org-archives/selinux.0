Subject: Useradd patchset - seeking comments..
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Daniel J Walsh <dwalsh@redhat.com>, sds@tycho.nsa.gov,
   kmacmillan@tresys.com, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 06 Jul 2005 17:21:23 -0400
Message-Id: <1120684883.24068.16.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here [ http://ivan.ivg2.net/selinux/patches/ ]
is an updated patchset that attempts to 
accomplish the following:

- provide library routines to easily edit and modify
the various selinux data files (users file, file contexts,
template file, map file... ) through libselinux,
and make some changes to allow alternative backends
in the future.

- integrate the utilities useradd/usermod/userdel
with libselinux interface for manipulating users
(currently useradd/userdel...still have to work
on usermod). 

- alter the 1:1 user-to-seluser map scheme to
what was discussed per Karl's proposal. Groups
are disallowed. Syntax is subject to change.

- simplify the code necessary to work with
and load policy in libsepol - this involves
changing policydb to an opaque data structure,
and deprecating functions that manipulate the
policy (data, len) image. Also, there is a convenient
create_policydb function in libselinux.

Patchset is not finished, but I want to see if you
have any comments... 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
