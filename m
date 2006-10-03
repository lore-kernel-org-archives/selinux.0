Subject: xinetd integration with SELinux (Was:  LSPP Development Telecon
	10/02/2006 Minutes)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Loulwa Salem <loulwas@us.ibm.com>
Cc: selinux@tycho.nsa.gov, Steve Grubb <sgrubb@redhat.com>,
        lspp-list <redhat-lspp@redhat.com>
In-Reply-To: <45227C09.2010904@us.ibm.com>
References: <45227C09.2010904@us.ibm.com>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 11:30:22 -0400
Message-Id: <1159889422.19176.48.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-03 at 10:04 -0500, Loulwa Salem wrote:
> xinetd
> -------
>      GW: anyone has problems with xinetd
>      PM: there was a discussion on mailing list on the thread of sec id
> 	reconciliation that I told steve about. Basically Stephen smalley had
> 	some concerns about xinetd. I have not seen a reply from Steve.
>      DW: what is this about?
>      PM: Stephen smalley basically wanted to use, and I'm gonna make up a term
> 	here, a hybrid context. he wasn't happy with blindly taking the ftp
> 	context. I think we can handle that in user space so probably not a big
> 	deal
>      GW: so we'll keep discussing xinetd next week as well

To clarify, if xinetd simply runs the service in the peer context, then
the TE domain of the service won't be what we expect it to be, e.g.
instead of running gssftp (/usr/kerberos/sbin/ftpd) in ftpd_t, it would
end up running in the peer's domain (e.g. unconfined_t under targeted,
user_t under strict, or if we had a distinct domain for the ftp client,
whatever domain it would run in).

Looking back, I first raised this issue on redhat-lspp Sep 29 2005 (yes
2005) in response to earlier discussion of the xinetd patch, but
unfortunately lost track of it and didn't remember when the xinetd patch
finally resurfaced this year.  Sorry.

xinetd can ask the kernel what context it would normally run the service
in by default via security_compute_create(), and can adjust the MLS
component based on the peer context.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
