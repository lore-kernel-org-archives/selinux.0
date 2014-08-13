Date: Wed, 13 Aug 2014 13:30:22 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: shivnandan.k@samsung.com
Subject: Re: [PATCH] Security: List corruption occured during file system
 automation test
Message-ID: <20140813123021.GX18016@ZenIV.linux.org.uk>
References: <1407929653-27228-1-git-send-email-shivnandan.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407929653-27228-1-git-send-email-shivnandan.k@samsung.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Cc: selinux@tycho.nsa.gov, ashish.kalra@samsung.com, vidushi.koul@samsung.com,
 james.l.morris@oracle.com, linux-kernel@vger.kernel.org,
 shiv.jnumca08@gmail.com, narendra.m1@samsung.com, cpgs@samsung.com,
 rajat.suri@samsung.com, sds@tycho.nsa.gov, mohammad.a2@samsung.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Aug 13, 2014 at 05:04:13PM +0530, shivnandan.k@samsung.com wrote:
> From: Shivnandan Kumar <shivnandan.k@samsung.com>
> 
> List element was freed by  inode_free_security and then it uses rcu
> element to point inode_free_rcu, since it inside a union so it
> shares memory, sb_finish_set_opts now also try to free list element,

How in hell does it find that element?
