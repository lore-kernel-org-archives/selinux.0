Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QG0bxQ008542
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 11:00:37 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1QG1wdB000686
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 16:01:58 GMT
Subject: [Fwd: Re: Changes to kerberos policy]
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 16:02:14 +0000
Message-Id: <1172505734.19655.18.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Resend to list.

-------- Forwarded Message --------
> From: Christopher J. PeBenito <cpebenito@tresys.com>
> To: Daniel J Walsh <dwalsh@redhat.com>
> Bcc: cpebenito@tresys.com
> Subject: Re: Changes to kerberos policy
> Date: Mon, 26 Feb 2007 11:00:53 -0500
> 
> On Tue, 2007-02-20 at 12:02 -0500, Daniel J Walsh wrote:
> > Eliminate excess avc messages created when using kerberos libraries
> > 
> > krb5kdc wans to setsched
> > 
> > Also uses a fifo_file to communicate.
> > 
> > Needs to search_network_sysctl
> 
> Merged except for this:
> 
> -       dontaudit $1 krb5kdc_conf_t:dir list_dir_perms;
> +       dontaudit $1 krb5kdc_conf_t:dir r_dir_perms;
> 
> since they are equivalent and we want to use the new perm sets.
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
