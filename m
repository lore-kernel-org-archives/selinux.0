Message-ID: <48C8249A.50404@manicmethod.com>
Date: Wed, 10 Sep 2008 15:48:42 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Manoj Srivastava <srivasta@debian.org>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Userspace versioning and releases
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We have discussed a little lately about changing the way we do releases and versioning of the userspace components. One idea is to no longer version per-commit like we do now but instead only bump the version at release time.

This would be a problem for distros using Git as their upstream. One question is, who does this (I know Dan does) and what can we do to move you to using releases? First we want to do releases more often and time based (eg., every 2 or 3 months).

We also would like some way of relating versions of the components with each other, so that it is very easy to tell which libsepol you need for which checkpolicy and libselinux, for example. We'd also need to do this in a way that doesn't interfere with the current versions (no new version scheme should ever be seen as a downgrade to package managers, etc)

Are there any comments or suggestions on this? Does anyone completely object to this kind of change and why?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
