Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i69GrxrT020615
	for <selinux@tycho.nsa.gov>; Fri, 9 Jul 2004 12:54:00 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i69Grebg017298
	for <selinux@tycho.nsa.gov>; Fri, 9 Jul 2004 16:53:40 GMT
Subject: Re: policy to allow upgrade of nfs-utils
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200407092252.08749.russell@coker.com.au>
References: <200407081319.05138.russell@coker.com.au>
	 <1089292484.6414.17.camel@moss-spartans.epoch.ncsc.mil>
	 <200407092252.08749.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1089392030.11726.66.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 09 Jul 2004 12:53:50 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-07-09 at 08:52, Russell Coker wrote:
> On Thu, 8 Jul 2004 23:14, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > On Wed, 2004-07-07 at 23:19, Russell Coker wrote:
> > > The attached policy patch is needed to allow nfs-utils to be upgraded to
> > > the latest version on a rawhide system.
> >
> > Should /etc/exports get its own type?
> 
> I guess so.  nfsd_etc_t or exports_t?

Doesn't matter to me, but it could be problematic to preserve the type
on the file, given that it is directly edited.  But directly allowing
initrc_t to write to etc_t violates an assertion (unless you have
unlimitedServices enabled, which renders the allow rule duplicative
anyway).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
