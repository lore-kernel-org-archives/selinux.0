Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAIFE8LT005363
 for <selinux@tycho.nsa.gov>; Wed, 18 Nov 2015 10:14:08 -0500
Date: Wed, 18 Nov 2015 15:13:35 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Austin S Hemmelgarn <ahferroin7@gmail.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 linux-bcache@vger.kernel.org, dm-devel@redhat.com,
 linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, Serge Hallyn <serge.hallyn@canonical.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org,
 "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v3 0/7] User namespace mount updates
Message-ID: <20151118151335.GD22011@ZenIV.linux.org.uk>
References: <20151117172551.GA108807@ubuntu-hedt>
 <20151117175506.GW22011@ZenIV.linux.org.uk>
 <564B79B1.3040207@gmail.com> <20151117191606.GC108807@ubuntu-hedt>
 <564B941A.2070601@gmail.com> <20151117213255.GE108807@ubuntu-hedt>
 <564C6DD4.6090308@gmail.com> <20151118142238.GB134139@ubuntu-hedt>
 <20151118145818.GC22011@ZenIV.linux.org.uk>
 <20151118150512.GE134139@ubuntu-hedt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151118150512.GE134139@ubuntu-hedt>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Nov 18, 2015 at 09:05:12AM -0600, Seth Forshee wrote:

> Yes, the host admin. I'm not talking about trusting the admin inside the
> container at all.

Then why not have the same host admin just plain mount it when setting the
container up and be done with that?  From the host namespace, before spawning
the docker instance or whatever framework you are using.  IDGI...
