Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j14CQi53006661
	for <selinux@tycho.nsa.gov>; Fri, 4 Feb 2005 07:26:45 -0500 (EST)
Subject: Re: Best way to label a filesystem for another system
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Villalovos, John L" <john.l.villalovos@intel.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <60C14C611F1DDD4198D53F2F43D8CA3B03625283@orsmsx410>
References: <60C14C611F1DDD4198D53F2F43D8CA3B03625283@orsmsx410>
Content-Type: text/plain
Message-Id: <1107519609.8078.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 04 Feb 2005 07:20:09 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-03 at 17:08, Villalovos, John L wrote:
> I'm trying to figure out what is the best way for me to label (set file
> contexts) on a file system which will be used for an embedded system.
> 
> At the moment it is an EXT2 file system created by genext2fs.  I can
> mount the file system using the loop back device.
> 
> So I was hoping that the current utilities supported a --root option or
> something but they don't seem too.
> 
> Any good ideas on the best way to do this.
> 
> Also is there an easy way to parse the list of file contexts from the
> policy?  Could I write a script to parse the file and then do a chcon on
> each file/directory in my filesystem.

setfiles -r allows you to specify an alternate root path.  Don't
reinvent the logic for processing file_contexts; we have been moving in
the opposite direction, centralizing it all in the matchpathcon()
function in libselinux and rewriting all programs to use it.  In the
sourceforge CVS tree (and thus the next release on nsa.gov), setfiles
has also been rewritten in this manner.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
