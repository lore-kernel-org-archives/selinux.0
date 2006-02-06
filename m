Message-ID: <43E6FBD2.5040207@acronis.com>
Date: Mon, 06 Feb 2006 10:33:38 +0300
From: Vladimir Simonov <Vladimir.Simonov@acronis.com>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
Subject: initrc_t has no execmod in targeted policy
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

Trying to launch my network daemon fron init.d on
Fedora Core 4 I see "avc:  denied  { execmod } ..."
in audit.log. The daemon loads some shared libraries
via dlopen. If I guessed right, code relocation at load
time modifies code segment and violates "no execmod
for initrc_t" rile.

The questions:
1. Is my guess correct?
2. If yes, should it be considered as policy drawback
(FC4 uses policy.19) or I'm missing something?
3. How to add execmod to system_u:system_r:initrc_t
type without full policy rebuild?

Best regards
Vladimir Simonov

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
