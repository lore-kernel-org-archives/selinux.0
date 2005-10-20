Subject: Re: Latest Diffs
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <432B043B.9020305@redhat.com>
References: <432B043B.9020305@redhat.com>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 16:23:18 -0400
Message-Id: <1129839798.25091.33.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Fri, 2005-09-16 at 13:43 -0400, Daniel J Walsh wrote:
> Add can_access_pty macro to handle pty output.
> 
> FIxes to make initrc scripts work
> 
> Allow login to work with pam_console and alsa
> 
> mcs transition rules
> 
> Allow users to interact with alsa.
> 
> Many fixes for amanda
> 
> added nsswithch_domain for any apps that communicate using nsswitch. 
> Consolodates can_ypbind, can_ldap, can_resolve, can_winbind.
> 
> Allow httpd to run as relay.
> 
> FIxes for apmd and audit, bluetooth and automount
> 
> More features for hplip under cups.
> 
> dovecot needs to be able to write to mail_spool_t
> 
> mysql can connect out to other mysql ports.
> 
> 
> Added openct, pegusus, readahead policies, roundup
> 
> Allow squid to relay additional protocols.
> 
> Remove mqueue genfscon entry
> 
> Change makefile to default to MCS policy.
> 
> Add dhcpd and pegasus ports
> 
> remove sysadm_r role from unconfined_t
> 
> Add capifs_t support.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
