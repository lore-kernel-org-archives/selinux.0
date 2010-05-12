Subject: Re: Labeling home directories in refpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>, refpolicy@oss1.tresys.com
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F52E5DBD95F@EUSAACMS0703.eamcs.ericsson.se>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F52E5DBD95F@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 May 2010 10:11:15 -0400
Message-ID: <1273673475.3738.21.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-05-12 at 10:04 -0400, Alan Rouse wrote:
> I'm trying to adapt a recent refpolicy snapshot (May 4) to OpenSUSE.
> (Previously I adapted the Fedora 12 policy, more as a learning
> exercise.)  Now I'm finding that the refpolicy is not labeling home
> directories properly (they all end up as default_t after "fixfiles -F
> relabel").   I'm running unprivileged users as user_u and root as
> sysadm_u, so I expect corresponding labels on files in the home
> directory.  Is there a special mechanism for getting the home dirs
> labeled consistent with the corresponding selinux user, or do I need
> to define labeling for the files individually in a new module?   And
> how do files in the home dir such as .ssh (which should have a type
> other than user_t) get their types?
>  
> Or perhaps something is broken in the distribution that is causing
> labels from the refpolicy not to be applied in the home dir?
>  
> Any insights would be appreciated!

Did you build with MONOLITHIC=n?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
