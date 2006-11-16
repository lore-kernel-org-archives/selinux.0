Subject: [PATCH 0/5] libselinux: labeling API for userspace object managers
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 15 Nov 2006 21:25:26 -0500
Message-Id: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a companion interface to the userspace AVC, for use by userspace
object managers to look up contexts for use in labeling their objects.
It also provides an alternate interface to the file contexts
configuration.

The need for this interface is discussed in this thread:
http://marc.theaimsgroup.com/?l=selinux&m=116195833329572&w=2

The interface provides support for pluggable backends, multithreading,
and user-provided callbacks for logging, memory allocation, and context
validation.  It is designed to allow policy separation by package (the
"prefix" string).  Lookups are done by object class and a string "key".

Patch 1: basic interface
Patch 2: basic implementation
Patch 3: security_class_to_string() function
Patch 4: simple, generic backend
Patch 5: file contexts backend

Patches may trickle out slowly as I am planning some thanksgiving
vacation time.  But the most important ones are 1 and 2 since they make
up the front-end.

Comments welcome!


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
