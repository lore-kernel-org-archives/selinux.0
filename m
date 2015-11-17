Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAHHtcJW013602
 for <selinux@tycho.nsa.gov>; Tue, 17 Nov 2015 12:55:38 -0500
Date: Tue, 17 Nov 2015 17:55:06 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Seth Forshee <seth.forshee@canonical.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-bcache@vger.kernel.org,
 dm-devel@redhat.com, linux-raid@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org,
 "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v3 0/7] User namespace mount updates
Message-ID: <20151117175506.GW22011@ZenIV.linux.org.uk>
References: <1447778351-118699-1-git-send-email-seth.forshee@canonical.com>
 <20151117170556.GV22011@ZenIV.linux.org.uk>
 <20151117172551.GA108807@ubuntu-hedt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151117172551.GA108807@ubuntu-hedt>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Nov 17, 2015 at 11:25:51AM -0600, Seth Forshee wrote:

> Shortly after that I plan to follow with support for ext4. I've been
> fuzzing ext4 for a while now and it has held up well, and I'm currently
> working on hand-crafted attacks. Ted has commented privately (to others,
> not to me personally) that he will fix bugs for such attacks, though I
> haven't seen any public comments to that effect.

_Static_ attacks, or change-image-under-mounted-fs attacks?
