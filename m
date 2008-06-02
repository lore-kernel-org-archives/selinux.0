Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m52GcXkG008914
	for <selinux@tycho.nsa.gov>; Mon, 2 Jun 2008 12:38:34 -0400
Received: from dmzmta101.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m52GcTxv022212
	for <selinux@tycho.nsa.gov>; Mon, 2 Jun 2008 16:38:33 GMT
Received: from BLUMS0034.bluelnk.net (blums0034.bluelnk.net [10.40.96.55])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m52GavRm002011
	for <selinux@tycho.nsa.gov>; Mon, 2 Jun 2008 12:36:57 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: changing role to user_r
Date: Mon, 2 Jun 2008 09:38:23 -0700
Message-ID: <0794F277152EF94AA637E3AECF5CB70FB9E3C3@blums0042.bluelnk.net>
References: <dd18b0c30805302311n7daac8e9ob6d818860e545b08@mail.gmail.com>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Justin Mattock" <justinmattock@gmail.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Which SELinux user are you logging in as?

When you type "semanage user -l", does that user list user_r as one of
its available roles? If not, you won't be able to change to user_r

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On
> Behalf Of Justin Mattock
> Sent: Friday, May 30, 2008 11:11 PM
> To: selinux@tycho.nsa.gov
> Subject: changing role to user_r
> 
> Hello, I'm running an experiment with SELinux and seem to be at a crux
> with changing roles:
> newrole -r user_r
> I get a permission denied, the allow rule is this: allow newrole_t
> user_t:process transition;
> I don't have a problem changing to sysadm_r any thoughts on what I'm
> missing?
> 
> --
> Justin P. Mattock
> 
> --
> This message was distributed to subscribers of the selinux mailing
list.
> If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
