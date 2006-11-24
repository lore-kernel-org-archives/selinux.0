Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAOJ0I4J006127
	for <selinux@tycho.nsa.gov>; Fri, 24 Nov 2006 14:00:18 -0500
Received: from mailhub.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAOIxbN7001815
	for <selinux@tycho.nsa.gov>; Fri, 24 Nov 2006 18:59:37 GMT
From: "Paul Moore" <paul.moore@hp.com>
Subject: Re: [PATCH 10/13] NetLabel: use cipso_v4_doi_search() for local CIPSOv4 functions
Date: 24 Nov 2006 13:59:00 -0500
To: <viro@ftp.linux.org.uk>
Message-ID: <3247221600.11766119@mail.hp.com>
Cc: <eparis@parisplace.org>, <netdev@vger.kernel.org>, <selinux@tycho.nsa.gov>,
        <jmorris@namei.org>, <aviro@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----Original Message-----
From: Al Viro <viro@ftp.linux.org.uk>
Date: Friday, Nov 24, 2006 2:07 am
Subject: Re: [PATCH 10/13] NetLabel: use cipso_v4_doi_search() for local CIPSOv4 functions

On Thu, Nov 23, 2006 at 08:24:34PM -0500, Eric Paris wrote:
> On Fri, 2006-11-17 at 17:38 -0500, paul.moore@hp.com wrote:
> 
> > Index: net-2.6.20_netlabel-base-work/net/ipv4/cipso_ipv4.c
> > ===================================================================
> > --- net-2.6.20_netlabel-base-work.orig/net/ipv4/cipso_ipv4.c
> > +++ net-2.6.20_netlabel-base-work/net/ipv4/cipso_ipv4.c
> > @@ -1136,7 +1136,7 @@ int cipso_v4_validate(unsigned char **op
> >  	}
> >  
> >  	rcu_read_lock();
> > -	doi_def = cipso_v4_doi_getdef(ntohl(*((__be32 *)&opt[2])));
> > +	doi_def = cipso_v4_doi_search(ntohl(*((u32 *)&opt[2])));
> >  	if (doi_def == NULL) {
> >  		err_offset = 2;
> >  		goto validate_return_locked;
> 
> 
> This appears to reverse the previous endian work by Al Viro, was this
> intended?
>
>Mismerge, most likely.  Fixed in net-2.6.20 since then (
>commit 835ec2525544c744333bf0da00049f323eb75c58
>Author: Al Viro <viro@zeniv.linux.org.uk>
>Date:   Mon Nov 20 18:08:37 2006 -0800
>
>    [CIPSO]: Missing annotation in cipso_ipv4 update.
>) 
>
>Note that there are two changes in that line - u32 -> __be32 and
>..._getdef -> ..._search.  They do not really conflict, but any merge tool would throw a conflict at that point and apparently it got
>resolved the dumb way...
>

Yep, Al is right, I just made a dumb mistake when merging my code with the latest net-2.6.20 tree.  I thought I caught everything but it looks like I missed one.  Sorry.

. paul moore
. linux security @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
