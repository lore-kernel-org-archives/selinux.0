Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8280IrT027150
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 04:00:19 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i827xS3w015794
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 07:59:29 GMT
Date: Thu, 2 Sep 2004 09:11:24 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: /dev entries which also need to be /.?u?dev'd
Message-ID: <20040902081124.GA5745@lkcl.net>
References: <20040831101602.GB2098@lkcl.net> <200409021711.59397.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409021711.59397.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 02, 2004 at 05:11:59PM +1000, Russell Coker wrote:
> On Tue, 31 Aug 2004 20:16, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > the following entries presently marked as /dev need, imo, to also
> > be modified to be ":%s/\/dev/\/.?u?dev/g" [in vi].
> >
> > the reason is as i explained that if someone using udev [with or
> > without tmpfs] does a
> >
> >  setfiles /etc/selinux/src/file_contexts/file_contexsts /.dev
> >
> > then they are buggered, without the above.
> 
> What if a rule such as the following was added at the end?
> /\.dev(/.*)? <<none>>
 
 as i understand it, that would result in /.dev and its contents
 from _not_ being affected by setfiles - neither setting nor
 unsetting any existing file contexts.

 that would mean that if the files in /.dev accidentally lost
 their file contexts [e.g. if you remember, 3 months ago i
 regularly had fsck.ext2 complain about extended attributes
 and _delete_ them in order to "fix" the problem]

 or if someone re-ran MAKEDEV in /.dev

 that they would still be unable to boot unless they remembered
 to manually set up a file context on each node.

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
