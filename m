Subject: Re: Verify the integrity of downloaded archives
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bill Laut <wlsel@verizon.net>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200311060111.16197.wlsel@verizon.net>
References: <000001c3a3db$2dad18f0$02000a0a@lady>
	 <200311060111.16197.wlsel@verizon.net>
Content-Type: text/plain
Message-Id: <1068128683.4355.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 06 Nov 2003 09:24:43 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-11-06 at 01:11, Bill Laut wrote:
> While I'd love to meet a hacker who could successfully break into the NSA's 
> website to install a Trojan (;-), Oliver does bring up a good point.  As 
> SELinux gains a wider audience it would be reasonable to anticipate the 
> distro eventually getting mirrored at other sites.  Since the use of digital 
> signatures as an integrity-check is now commonplace within the Linux 
> community, would it be reasonable to start posting signatures on the NSA 
> website?

Possibly.  Since we originally released SELinux as a proof of concept /
reference implementation and it has never been intended to be a Linux
distribution unto itself (although it can be incorporated into one),
this hasn't been a major concern in the past.  However, I understand the
concern.  On the other hand, on what basis would you trust the key used
to sign the archives and patches?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
