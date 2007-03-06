Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l26FCvav001075
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 10:12:57 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l26FEOOM022835
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 15:14:24 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: rpc changes for policy
Date: Tue, 6 Mar 2007 10:14:41 -0500
Message-ID: <1173194082.15853.21.camel@sgc>
In-Reply-To: <200702261740.l1QHepN3030699@localhost.localdomain>
References: <200702261740.l1QHepN3030699@localhost.localdomain>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <dwalsh@localhost.localdomain>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 12:40 -0500, dwalsh@localhost.localdomain wrote:
> Many changes for gssd

Merged except:
 
> +term_use_controlling_term(gssd_t)

Shouldn't be needed since its a domain already.

> +# Manage the users kerberos tgt file
> +optional_policy(`
> +	files_manage_generic_tmp_files(gssd_t) 
> +')

Changed this to ifdef targeted since there shouldn't be generic tmp
files on strict.  Also moved the other generic_tmp calls from above.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
