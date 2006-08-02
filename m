Subject: Re: SMP enabled restorecon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Klaus Weidner <klaus@atsec.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, russell@coker.com.au,
        SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20060802202557.GC5967@w-m-p.com>
References: <200607300117.23329.russell@coker.com.au>
	 <200607302314.00725.russell@coker.com.au>
	 <200607310012.02943.russell@coker.com.au> <44D10261.4020005@redhat.com>
	 <20060802202557.GC5967@w-m-p.com>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 16:38:38 -0400
Message-Id: <1154551118.16917.216.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-02 at 15:25 -0500, Klaus Weidner wrote:
> On Wed, Aug 02, 2006 at 03:52:01PM -0400, Daniel J Walsh wrote:
> > You might want to look at what find is doing also, since it seems more 
> > efficient that restorecon
> > 
> > time restorecon -R /etc
> > real    0m5.729s
> > 
> > time find /etc/ | restorecon -f -
> > real    0m5.153s
> 
> This might be the leaf optimization (see find(1), -noleaf), "find" uses
> the directory hard link count to avoid stat()ing files when it knows that
> they cannot be directories.

Given that coreutils selinux support is being upstreamed and Jim
Meyering has rewritten chcon to use fts and openat-style functions, I
have to wonder whether we shouldn't just seek to merge
restorecon/setfiles-like functionality into chcon as an option and drop
them as separate entities.  IOW, have an option to chcon that says to
use matchpathcon to get the context instead of having the user specify
it as an argument.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
