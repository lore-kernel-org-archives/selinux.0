Date: Tue, 14 Oct 2003 12:11:48 -0700
From: Michael Reilly <michaelr@cisco.com>
To: <SELinux@tycho.nsa.gov>
Subject: Anyone run mozilla in enforce mode?
Message-Id: <20031014121148.4155015d.michaelr@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you to those who helped me  - I finally got my X server running in
enforce mode.  Turning off dontaudit revealed that the X server needed
DAC_OVERRIDE.

Now I have another problem - mozilla fails to start.  Nothing is logged even
with the dontaudit's removed from the policy.  Mozilla does complain that it
couldn't find one of its libraries (I do not recall which one and I left my
notes at home).

I went through and labeled the mozilla executables and reg* files so they
match is specified in the file_constraints since mozilla installed itself
into /usr/lib/mozilla-1.4 instead of /usr/lib/mozilla.  The shared libraries
are properly labled as shared libs.

Has anyone been able to run Mozilla in enforce mode?  If so, what changes
need to be made from the default policy?

Thanks,

michael
-- 
---- ---- ----
Michael Reilly    michaelr@cisco.com
    Cisco Systems, Santa Cruz, CA

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
