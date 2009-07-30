Subject: Re: Help with SELinux policy for Usability Study
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Cliffe <cliffe@ii.net>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        slide@tresys.com
In-Reply-To: <4A71AD1A.5030406@ii.net>
References: <200907300352.n6U3qvAC012682@tarius.tycho.ncsc.mil>
	 <4A711890.2030101@ii.net>
	 <1248955358.11627.91.camel@moss-pluto.epoch.ncsc.mil>
	 <4A71AD1A.5030406@ii.net>
Content-Type: text/plain
Date: Thu, 30 Jul 2009 10:44:49 -0400
Message-Id: <1248965089.11627.137.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-07-30 at 22:24 +0800, Cliffe wrote:
> It adds the permissive line to both (I am not sure why kwrite seemed
> to be in enforcing mode). But the gui does not make this clear. I have
> mentioned this to the fedora-selinux mailing list.

Perhaps kwrite isn't actually running in kwrite_t at all.  Note that kde
has historically had a problem with launching all applications via a
single kde-init program, thereby preventing automatic domain transitions
on the specific application from working.  Not sure if that has been
fixed.  I don't use KDE.

> None there. It turns out they were in /var/log/messages
> 
> so 
> grep kwrite /var/log/audit/audit.log | audit2allow >> kwrite.te
> did the trick. It is strange that some AVCs go to /var/log/messages
> while others goto 
> /var/log/audit/audit.log

That seems like a bug to me in dbus.

Again, I'd suggest that you also include SLIDE in your study - it will
add a further data point and is a more flexible solution, even if it may
be slightly harder to get started.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
