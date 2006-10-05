Message-ID: <4525494C.6080901@trustedcs.com>
Date: Thu, 05 Oct 2006 13:05:00 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Daniel Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Christopher PeBenito <cpebenito@tresys.com>
Subject: [RFC PATCH 0/3] access checks for translating contexts
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following is an attempt to perform access checks for context translations.
The idea being that a process should not know about labels that are outside
of it's clearance.  Since there are now standalone MLS checks available, I have
added a new security class "context" with permission "translate".  The
mlsconstraint on that permission handles the MLS clearance portion.  TE access
must also be granted for the context to be translated - I see this a drawback
of the implementation because now we need a way to give TE access to all types
if we want a process to do translations limited purely by MLS.

Now... The daemon running at the lowest MLS level and the file describing
translations is at the lowest MLS level.  This throws the whole idea of
protecting the labels (the reason for the daemon in the first place) themselves
out the door since everyone can just read the file.  That daemon needs to run
at the highest MLS level and the file needs to be at the highest MLS level.
We (TCS) had things set up that way when we did some of the initial work on
the daemon.  Has anyone looked into actually fixing this issue (or at least
have an idea on what caused the breakage)?  If not, this whole patchset is
really not necessary.  I guess I could look into that as well...

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
