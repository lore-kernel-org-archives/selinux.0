MIME-Version: 1.0
Sender: konishi.ryusuke@gmail.com
From: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
Date: Thu, 9 Jun 2016 22:05:47 +0900
Message-ID: <CAKFNMomnVXMO49LDGsZ=UAxyD7fF88Aq29d-XR5Brqsn41+TYw@mail.gmail.com>
Subject: Re: [PATCH 04/21] fs: Replace CURRENT_TIME with current_fs_time() for
 inode timestamps
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>, y2038@lists.linaro.org,
 Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, Joern Engel <joern@logfs.org>,
 Prasad Joshi <prasadjoshi.linux@gmail.com>, logfs@logfs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Julia Lawall <Julia.Lawall@lip6.fr>,
 David Howells <dhowells@redhat.com>, Firo Yang <firogm@gmail.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>,
 Chao Yu <chao2.yu@samsung.com>, linux-f2fs-devel@lists.sourceforge.net,
 Michal Hocko <mhocko@suse.com>, Konstantin Khlebnikov <koct9i@gmail.com>,
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
 Benny Halevy <bhalevy@primarydata.com>, osd-dev@open-osd.org,
 Mike Marshall <hubcap@omnibond.com>,
 pvfs2-developers@beowulf-underground.org,
 Nadia Yvette Chambers <nyc@holomorphy.com>,
 Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net,
 linux-nilfs <linux-nilfs@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

for nilfs2 bits:

Acked-by: Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>

Thanks,
Ryusuke Konishi
