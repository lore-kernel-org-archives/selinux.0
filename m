Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA5JJjIi002325
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 14:19:46 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA5JIPgk009916
	for <selinux@tycho.nsa.gov>; Fri, 5 Nov 2004 19:18:26 GMT
Subject: Re: selinux-doc patchset 2 of 2: Quoting attribute values
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <877jp1qsnp.fsf_-_@glaurung.internal.golden-gryphon.com>
References: <87is8msv81.fsf@glaurung.internal.golden-gryphon.com>
	 <1099503633.1213.153.camel@moss-spartans.epoch.ncsc.mil>
	 <87fz3qqc20.fsf@glaurung.internal.golden-gryphon.com>
	 <1099575909.3174.9.camel@moss-spartans.epoch.ncsc.mil>
	 <877jp1qsnp.fsf_-_@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Message-Id: <1099682118.6373.242.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 05 Nov 2004 14:15:18 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-11-04 at 15:13, Manoj Srivastava wrote:
>         Since attribute values need to be quoted unless  SHORTTAG YES
>  is specified,  this patchset, the second of two, does that.  Please
>  note that this patch assumes that the previous patchset that modified
>  the ID name tokens has already been applied.

Thanks, both patches merged, available in the sourceforge CVS tree.
> 
> ______________________________________________________________________
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
