Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA5Lb2Ii003459
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 16:37:03 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA5LZhgk017201
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 21:35:43 GMT
Subject: Re: Adding alternate root patch to restorecon (setfiles?)
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200410270036.14935.russell@coker.com.au>
References: <41741A2C.8040408@redhat.com>
	 <200410260138.19426.russell@coker.com.au>
	 <20041025213122.GA2535@jmh.mhn.de>
	 <200410270036.14935.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 16:39:48 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I haven't forgotten about this patch.  I will probably be working on
merging it Monday, without the restorecon stuff at first.

The $1_domain_file_type attribute is an interesting idea, although the
name is rather long.

This patch came just before I merged Dan's patch that added a
httpdcontent attribute, so some changes will be needed to this patch.
   
On Tue, 2004-10-26 at 10:36, Russell Coker wrote:
> On Tue, 26 Oct 2004 07:31, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
> wrote:
> > OK, what do you guys think about the following patch:
> > It adds an attribute $1_domain_file_type, so all file types from derived
> > user domains can be grouped together. It also adds a restorecon_domain()
> > macro, so users can call restorecon to reset the labels on their files.
> 
> I've attached a patch named "tom.diff" which applies after your patch to tweak 
> a few things.  The new attribute allows a better way of dealing with the 
> locate policy so I changed it appropriately.  I added some use of 
> sysadm_domain_file_type.  Some of the types you had given the attribute 
> $1_domain_file_type seemed inappropriate, this includes the print spool type, 
> some temporary files, and files under /var/run.
> 
> Whether we have the user_restorecon_t domain etc is something that needs more 
> consideration.  The attached patch named "diff" has the user_domain_file_type 
> stuff from your patch with my amendments but none of the restorecon changes.  
> I think that "diff" is worthy of being included in CVS regardless of what we 
> do with restorecon.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
