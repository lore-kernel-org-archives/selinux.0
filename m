From: Arnd Bergmann <arnd@arndb.de>
To: Deepa Dinamani <deepa.kernel@gmail.com>,
 Mike Marshall <hubcap@omnibond.com>,
 Nadia Yvette Chambers <nyc@holomorphy.com>,
 Chao Yu <chao2.yu@samsung.com>, linux-nilfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Al Viro <viro@zeniv.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>, y2038@lists.linaro.org,
 Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, Joern Engel <joern@logfs.org>,
 Prasad Joshi <prasadjoshi.linux@gmail.com>, logfs@logfs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Julia Lawall <Julia.Lawall@lip6.fr>,
 David Howells <dhowells@redhat.com>, Firo Yang <firogm@gmail.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Michal Hocko <mhocko@suse.com>,
 Konstantin Khlebnikov <koct9i@gmail.com>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 "J. Bruce Fields" <bfields@fieldses.org>,
 Jeff Layton <jlayton@poochiereds.net>,
 Trond Myklebust <trond.myklebust@primarydata.com>,
 Anna Schumaker <anna.schumaker@netapp.com>,
 "David S. Miller" <davem@davemloft.net>, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, Steven Whitehouse <swhiteho@redhat.com>,
 Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com,
 Mark Fasheh <mfasheh@suse.com>, Joel Becker <jlbec@evilplan.org>,
 ocfs2-devel@oss.oracle.com, Anton Vorontsov <anton@enomsg.org>,
 Colin Cross <ccross@android.com>, Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 fuse-devel@lists.sourceforge.net, Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
 Sean Hefty <sean.hefty@intel.com>,
 Hal Rosenstock <hal.rosenstock@gmail.com>, linux-rdma@vger.kernel.org,
 Robert Richter <rric@kernel.org>, oprofile-list@lists.sf.net,
 Alexei Starovoitov <ast@kernel.org>, Hugh Dickins <hughd@google.com>,
 linux-mm@kvack.org, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org,
 Eric Van Hensbergen <ericvh@gmail.com>,
 Ron Minnich <rminnich@sandia.gov>, Latchesar Ionkov <lucho@ionkov.net>,
 v9fs-developer@lists.sourceforge.net, Ian Kent <raven@themaw.net>,
 autofs@vger.kernel.org, Matthew Garrett <matthew.garrett@nebula.com>,
 Jeremy Kerr <jk@ozlabs.org>, Matt Fleming <matt@codeblueprint.co.uk>,
 linux-efi@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>,
 Josh Triplett <josh@joshtriplett.org>, Boaz Harrosh <ooo@electrozaur.com>,
 Benny Halevy <bhalevy@primarydata.com>, Dave Kleikamp <shaggy@kernel.org>,
 jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH 04/21] fs: Replace CURRENT_TIME with current_fs_time() for
 inode timestamps
Date: Sat, 11 Jun 2016 00:23:39 +0200
Message-ID: <3828814.bejVmX1kJo@wuerfel>
In-Reply-To: <1465448705-25055-5-git-send-email-deepa.kernel@gmail.com>
References: <1465448705-25055-1-git-send-email-deepa.kernel@gmail.com>
 <1465448705-25055-5-git-send-email-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, June 8, 2016 10:04:48 PM CEST Deepa Dinamani wrote:
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: Steve French <sfrench@samba.org>
> Cc: linux-cifs@vger.kernel.org
> Cc: samba-technical@lists.samba.org
> Cc: Joern Engel <joern@logfs.org>
> Cc: Prasad Joshi <prasadjoshi.linux@gmail.com>
> Cc: logfs@logfs.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Firo Yang <firogm@gmail.com>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Changman Lee <cm224.lee@samsung.com>
> ...


Hi Deepa,


Just FYI, the vger.kernel.org list server and some others
intentionally reject mails with more than 1024 characters in the
Cc header, to stop people from cross-posting to too many folks.

I realize that you merged the patch after Linus' comment about
doing things in fewer steps for the simple conversion, which is
fine, but then the patch should be obvious enough that you
don't need to Cc every single maintainer and mailing list.

I've had some cases like this, and I usually remove the people
that are less likely to reply, leaving one per subsystem.
Leaving out the cleartext names is another trick you can use
if you think that you really need to Cc more people than
allowed ;-)

	Arnd
