From: Richard Haines <richard_c_haines@btinternet.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 0/2] checkpolicy: Add constraint info to -d option
Date: Sun,  3 Nov 2013 19:11:00 +0000
Message-Id: <1383505860-2554-1-git-send-email-richard_c_haines@btinternet.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In an earlier email you asked if the constraint information that is
now available from libsepol could be added to the debug mode of
checkpolicy. Well I've completed a patch that allows this, however I
also added facilities to output mls/validatetrans expressions as well.

The two patches add a new sepol_validate_transition_reason_buffer()
function to libsepol and updates checkpolicy to call this and also
sepol_compute_av_reason_buffer().

Hope they are a useful addition.

Richard Haines (2):
  libsepol: Add sepol_validate_transition_reason_buffer function
  checkpolicy: Add debug feature to display constraints / validatetrans

 checkpolicy/checkpolicy.c                  | 110 ++++++++++++++++++++++++++++-
 libsepol/include/sepol/policydb/services.h |  14 ++++
 libsepol/src/services.c                    |  80 +++++++++++++++++++--
 3 files changed, 198 insertions(+), 6 deletions(-)

-- 
1.8.3.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
