Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lAJEgqgc004991
	for <selinux@tycho.nsa.gov>; Mon, 19 Nov 2007 09:42:52 -0500
Subject: Re: [PATCH 03/13] Security: Add hook to get full security xattr
	name
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: labeled-nfs@linux-nfs.org, selinux@tycho.nsa.gov
In-Reply-To: <781842.64970.qm@web36605.mail.mud.yahoo.com>
References: <781842.64970.qm@web36605.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 19 Nov 2007 09:42:42 -0500
Message-Id: <1195483362.20981.39.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-11-16 at 16:34 -0800, Casey Schaufler wrote:
> --- "David P. Quigley" <dpquigl@tycho.nsa.gov> wrote:
> 
> > When a caller wishes to get pull the extended attribute name for the security
> > module for use they normally concatinate the security namespace segment and
> > the
> > suffix provided by the lsm. This hook provides a mechanism to obtain the full
> > LSM xattr name. The patch also provides implementations for the dummy
> > security
> > module and SELinux.
> 
> What is the problem with the concatination scheme currently in
> use? I'm not going to defend it, but why change it?

Well the current getsuffix call has been removed by a patch submitted by
Adrian Bunk I think. Regardless it is no longer in the stable kernel and
other places in the xattr code take the xattr that they receive and then
pass an offset into it for the component. There are examples of this
method in the kernel already and it seems better to do this rather than
concatenating them. 

Pointer + offset as opposed to string concatenation.

Dave

> 
> > Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
> > Signed-off-by: Matthew N. Dodd <Matthew.Dodd@sparta.com>
> > ---
> >  include/linux/security.h |    7 +++++++
> >  security/dummy.c         |    6 ++++++
> >  security/security.c      |    6 ++++++
> >  security/selinux/hooks.c |    6 ++++++
> >  4 files changed, 25 insertions(+), 0 deletions(-)
> 
> Please cross post proposed LSM changes to the LSM mailing list.
> 
> 
> 
> Casey Schaufler
> casey@schaufler-ca.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
