Sender: Pierre-Hugues Husson <phhusson@gmail.com>
From: Pierre-Hugues Husson <phh@phh.me>
To: selinux@tycho.nsa.gov
Cc: phh@phh.me, Tri Vo <trong@android.com>, jwcart2@tycho.nsa.gov
Date: Fri, 23 Mar 2018 00:04:34 +0100
Message-Id: <20180322230435.21048-1-phh@phh.me>
Subject: [PATCH v2 0/1] Detect identical genfscon
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Currently secilc doesn't deal with duplicate genfscon rules.

This commit fixes this, and implements multiple_decls behaviour.
    
To reduce the code changes, the compare function returns in its LSB
whether the rules are only a matching rule match, or a full match.

One usecase is Android/Project Treble:
With Project Treble, vendor might include rules included in later
in framework.
In order to be able to update the framework in this case, we need
to remove identical rules.

This is a RFC version, this hasn't been properly tested.

v2:
- Respect multiple_decls behaviour
- Fail merge when context is different
- genfscon compare function returns partial or full match

Pierre-Hugues Husson (1):
  Detect identical genfscon

 libsepol/cil/src/cil_post.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

-- 
2.15.1
