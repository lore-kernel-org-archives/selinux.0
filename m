Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA6AeVIi006154
	for <selinux@tycho.nsa.gov>; Sat, 6 Nov 2004 05:40:31 -0500 (EST)
Received: from kokytos.rz.informatik.uni-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA6AeX3E008921
	for <selinux@tycho.nsa.gov>; Sat, 6 Nov 2004 10:40:34 GMT
Date: Sat, 6 Nov 2004 11:40:31 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: James Carter <jwcart2@epoch.ncsc.mil>
Cc: Russell Coker <russell@coker.com.au>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Adding alternate root patch to restorecon (setfiles?)
Message-ID: <20041106104031.GB9912@rom.cip.ifi.lmu.de>
References: <41741A2C.8040408@redhat.com> <200410260138.19426.russell@coker.com.au> <20041025213122.GA2535@jmh.mhn.de> <200410270036.14935.russell@coker.com.au> <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* James Carter <jwcart2@epoch.ncsc.mil> [2004-11-05 22:37]:
> I haven't forgotten about this patch.  I will probably be working on
> merging it Monday, without the restorecon stuff at first.

Yes, that's OK. The restorecon stuff was more a "let's toss this idea
around to see what people say about it". I'm not sure myself if it
should be merged.
 
> The $1_domain_file_type attribute is an interesting idea, although the
> name is rather long.

I guess I'm just bad at naming. Feel free to take a shorter name. :)

Thanks,
Thomas


> This patch came just before I merged Dan's patch that added a
> httpdcontent attribute, so some changes will be needed to this patch.
>    
> On Tue, 2004-10-26 at 10:36, Russell Coker wrote:
> > On Tue, 26 Oct 2004 07:31, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
> > wrote:
> > > OK, what do you guys think about the following patch:
> > > It adds an attribute $1_domain_file_type, so all file types from derived
> > > user domains can be grouped together. It also adds a restorecon_domain()
> > > macro, so users can call restorecon to reset the labels on their files.
> > 
> > I've attached a patch named "tom.diff" which applies after your patch to tweak 
> > a few things.  The new attribute allows a better way of dealing with the 
> > locate policy so I changed it appropriately.  I added some use of 
> > sysadm_domain_file_type.  Some of the types you had given the attribute 
> > $1_domain_file_type seemed inappropriate, this includes the print spool type, 
> > some temporary files, and files under /var/run.
> > 
> > Whether we have the user_restorecon_t domain etc is something that needs more 
> > consideration.  The attached patch named "diff" has the user_domain_file_type 
> > stuff from your patch with my amendments but none of the restorecon changes.  
> > I think that "diff" is worthy of being included in CVS regardless of what we 
> > do with restorecon.
> -- 
> James Carter <jwcart2@epoch.ncsc.mil>
> National Security Agency

-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
