Date: Wed, 18 Mar 2009 12:24:48 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Igor Zhbanov <izh1979@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, neilb@suse.de, Trond.Myklebust@netapp.com,
        David Howells <dhowells@redhat.com>, Andrew Morgan <morgan@kernel.org>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>
Subject: Re: =?utf-8?B?0J7RgtCy0LXRgjogVkZTLCBORlMg?=
	=?utf-8?Q?security_bug=3F_Shoul?=
	=?utf-8?Q?d?= CAP_MKNOD and CAP_LINUX_IMMUTABLE be added to
	CAP_FS_MASK?
Message-ID: <20090318172448.GB29523@us.ibm.com>
References: <20090316184926.GA6729@us.ibm.com> <1237237216.1035.195.camel@localhost.localdomain> <20090316231340.GC15522@us.ibm.com> <1237299633.6582.107.camel@localhost.localdomain> <20090317173903.GA31566@us.ibm.com> <1237312345.6582.140.camel@localhost.localdomain> <20090317182335.GB31633@us.ibm.com> <1237393287.12822.50.camel@localhost.localdomain> <20090318164712.GB27906@us.ibm.com> <20090318165730.GA15084@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090318165730.GA15084@fieldses.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting J. Bruce Fields (bfields@fieldses.org):
> On Wed, Mar 18, 2009 at 11:47:12AM -0500, Serge E. Hallyn wrote:
> > Ok, thanks for time.  It's all pretty clear to me now:
> > 
> > CAP_MKNOD and CAP_LINUX_IMMUTABLE need to be added to the CAP_FS_MASK
> > because, in 2.0 timeframe, fsuid==0 gave you those privileges.
> > 
> > xattrs didn't exist back then, so the setting of security.* and
> > trusted.* xattrs doesn't need to be enabled by fsuid==0.  So really
> > CAP_SETFCAP also doesn't need to be added to CAP_FS_MASK either.
> 
> Are we left with any simple one-sentence description of what CAP_FS_MASK
> means?  (Other than just a particular list of bits?)  I'm just wondering
> how additional bits will get decided in the future.

It means all the privileges that fsuid==0 historically meant.

At one time in the past, that meant CAP_MKNOD and CAP_LINUX_IMMUTABLE.

It has never meant setting security.* and trusted.* xattrs.

We could also define it as follows:
	CAP_FS_MASK is the privilege to bypass all fs-related DAC permissions
	security.* and trusted.* xattrs are MAC fs permissions
or something like that.

I guess one or both of those should go as a comment into capability.h

> > I'll send out a patch later today for 2.6, unless Igor wants to
> > do it (since he's the one who found this originally).
> 
> OK, apologies if I jumped the gun on the nfsd-specific patch--I lost

Nonsense, I appreciate it...  And there's certainly still a chance that
there will be objections to my interpretation, whereas the NFSD bit
seems straightened out.

> track of this discussion, thought it might take longer, and wanted to
> get the one patch into 2.6.30.  Feel free to revert that, or ignore it
> and leave it to me to revert it afterwards, as convenient....

I'm not sure what the best path forward is, so I'll go ahead and
incorporate your patch into mine for now.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
