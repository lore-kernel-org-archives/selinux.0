Subject: Re: "HASHTAB_OVERFLOW" undeclared
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Ken YANG <spng.yang@gmail.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <460BAA90.5060703@redhat.com>
References: <460B2925.1080403@gmail.com>
	 <1175166411.3864.504.camel@moss-spartans.epoch.ncsc.mil>
	 <460BAA90.5060703@redhat.com>
Content-Type: text/plain
Date: Thu, 29 Mar 2007 08:10:57 -0400
Message-Id: <1175170258.11403.7.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-29 at 08:01 -0400, Daniel J Walsh wrote:
> Stephen Smalley wrote:
> > On Thu, 2007-03-29 at 10:49 +0800, Ken YANG wrote:
> >   
> >> i want to use findcon to find a type "tmpfs_t".
> >> but in FC, there is setools* package contaning findcon.
> >> i find that secmds(findcon) is in setools-console subpackage
> >> why fc has not this subpackage?
> >>     
> >
> >   
> Because the same functionality is available in find.
> 
> # find / -context "*tmpfs_t*"

Can this be readded to the FC package?  The purpose of this tool is not
the same as find though they have similar functionality.  The purpose is
to index the system and copy the index and the policy off the machine to
the machine that you are doing the analysis on (think about analyzing a
system without X).  Then you can get extra information during analysis
without having to be on the machine you're analyzing.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
