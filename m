Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i96CZmrT003880
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 08:35:48 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i96CZlKB007888
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 12:35:47 GMT
Subject: Re: policy patches
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Russell Coker <russell@coker.com.au>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20041006101046.GA5790@lkcl.net>
References: <200409292354.15227.russell@coker.com.au>
	 <200409300620.41527.russell@coker.com.au>
	 <1096648965.13366.35.camel@moss-lions.epoch.ncsc.mil>
	 <200410020344.04225.russell@coker.com.au>
	 <1096920735.3235.17.camel@moss-lions.epoch.ncsc.mil>
	 <4162C0C6.9090704@redhat.com>
	 <1097003202.30738.35.camel@moss-lions.epoch.ncsc.mil>
	 <20041006101046.GA5790@lkcl.net>
Content-Type: text/plain
Message-Id: <1097065954.3364.4.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 06 Oct 2004 08:32:34 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dan replied to me that it was the default download place for Firefox.

On Wed, 2004-10-06 at 06:10, Luke Kenneth Casson Leighton wrote:
> james, i didn't see a reply to your question about whether
> it was mozilla that defined the "~/My Downloads" directory:
> did i miss something?
> 
> i appreciate the issues of needing, ultimately, some helper-program
> intervention which determines (saaay... by asking for the user's
> password) whether a file should be saved with a file context of
> user_mozilla_t or user_home_t.
> 
> and that there needs to be a sandbox area in which files should be
> saved.
> 
> ... but does it _have_ to be in ~/My windows style downloads???
> 
> 
> On Tue, Oct 05, 2004 at 03:06:42PM -0400, James Carter wrote:
> > Merged.  
> > 
> > There are some minor changes such as My.Downloads instead of My
> > Downloads and not having {} around a single item.
> > 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
