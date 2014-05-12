Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4CDODhH020938
 for <selinux@tycho.nsa.gov>; Mon, 12 May 2014 09:24:13 -0400
To: miklos@szeredi.hu, jmorris@namei.org, john.johansen@canonical.com,
 selinux@tycho.nsa.gov
Subject: [PATCH (for 3.15) 0/5] Fix cross rename regressions for LSM.
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <CAJfpeguus=9GuvEKua4U-VF=nonzLgU5VFHqt8xRTTYU7RL-zQ@mail.gmail.com>
 <201404242020.FJD18726.LOOJtOQMFVFFSH@I-love.SAKURA.ne.jp>
 <201405012058.JEG30273.LJFHOOFMtOFQVS@I-love.SAKURA.ne.jp>
 <201405051449.GAE81222.LOOFtFJMQFOSVH@I-love.SAKURA.ne.jp>
 <201405120053.HJG95368.HFLQSFMOOtOVJF@I-love.SAKURA.ne.jp>
In-Reply-To: <201405120053.HJG95368.HFLQSFMOOtOVJF@I-love.SAKURA.ne.jp>
Message-Id: <201405122221.DBG43278.LOQtJSOFVFFOHM@I-love.SAKURA.ne.jp>
Date: Mon, 12 May 2014 22:21:28 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Changes from previous patchset.

  Clarified that this is a regression fix.
  AppArmor: Pass appropriate inode's mode to aa_path_perm().
  TOMOYO: Changed "file swapname" permission to "file exchange" permission.
