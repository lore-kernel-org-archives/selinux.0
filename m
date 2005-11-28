Subject: Re: Other unused permissions(Re: swapon unsuppoted?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200511271026.30694.russell@coker.com.au>
References: <200510121517.j9CFHl11010821@mms-r01.iijmio.jp>
	 <200510201443.j9KEhRHp013290@mms-r00.iijmio.jp>
	 <1129899172.2375.577.camel@moss-spartans.epoch.ncsc.mil>
	 <200511271026.30694.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 13:15:57 -0500
Message-Id: <1133201757.348.193.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-11-27 at 10:26 +1100, Russell Coker wrote:
> On Friday 21 October 2005 22:52, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > * netif : enforce_dest
> >
> > Correct - that was specific to one of the extended socket calls in the
> > original SELinux API.  Not sure it will ever be revived.
> 
> I think it would be a good idea to rename the unused entries with names such 
> as "unused1", "unused2", etc.  That makes it clear to everyone what their 
> status is and will result in anyone who proposes a new entry in taking the 
> spot of one of the old ones rather than just adding a new one to the end.
> 
> It will also avoid future discussions about this.

Yes, that would likely be a good idea.  Patches accepted.  cc'd selinux
list.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
