Subject: Re: I have not used the selabel interface replacement for
 matchpathcon, that much
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <49B1464A.6020606@redhat.com>
References: <49B1464A.6020606@redhat.com>
Content-Type: text/plain
Date: Fri, 06 Mar 2009 13:35:45 -0500
Message-Id: <1236364545.16365.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-03-06 at 10:50 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Is there an equivalent to this?
> 
> The question we are getting is can we speed up the execution of
> restorecon in boot.
> 
> restorecon /etc/resolv.conf
> 
> should only search prefix /etc.

man selabel_file

SELABEL_OPT_SUBSET is the option you want to set in the options
structure for selabel_open(3).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
