Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OB3VrT025200
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 07:03:31 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OB2kMZ026606
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 11:02:46 GMT
Subject: Re: kde 3.3's kdm creating /var/run/xdmctl
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040823205404.GC7540@lkcl.net>
References: <20040823205404.GC7540@lkcl.net>
Content-Type: text/plain
Message-Id: <1093345329.1800.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 24 Aug 2004 07:02:09 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-23 at 16:54, Luke Kenneth Casson Leighton wrote:
> also i find that on creation of this directory, its permission
> is set to var_run_t not xdm_var_run_t.
> 
> i'm not entirely sure what to do.
> 
> at the moment as a preliminary measure i've added permissions
> for xdm_t to create, access and delete sockets in both var_run_t
> _and_ xdm_var_run_t in order to deal with the mess.

What creates the directory?  If it is kdm itself, then extend the
file_type_auto_trans(xdm_t, var_run_t, xdm_var_run_t, fifo_file) rule to
also cover dir (replace fifo_file with { dir fifo_file}).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
