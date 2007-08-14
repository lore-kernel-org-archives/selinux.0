Subject: Re: [PATCH 00/16] Permit filesystem local caching [try #3]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
        steved@redhat.com, trond.myklebust@fys.uio.no,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>
In-Reply-To: <861956.50630.qm@web36613.mail.mud.yahoo.com>
References: <861956.50630.qm@web36613.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Tue, 14 Aug 2007 13:42:48 -0400
Message-Id: <1187113368.26008.226.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-14 at 08:53 -0700, Casey Schaufler wrote:
> --- David Howells <dhowells@redhat.com> wrote:
> 
> > Casey Schaufler <casey@schaufler-ca.com> wrote:
> > 
> > > With Smack you can leave the label alone, raise CAP_MAC_OVERRIDE,
> > > do your business of setting the label correctly, and then drop
> > > the capability. No new hooks required.
> > 
> > That sounds like a contradiction.  How can you both leave it alone and set
> > it?
> 
> Whoops, sorry. You leave the process label alone and explicitly
> set the file label using the xattr interfaces.

xattr interfaces don't help with the initial labeling of the file when
it is created.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
