Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8FD7u5d030363
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2008 09:07:56 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8FD7utl017895
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2008 13:07:56 GMT
Message-ID: <48CE5E07.2010607@redhat.com>
Date: Mon, 15 Sep 2008 09:07:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: Murray McAllister <mmcallis@redhat.com>, James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "Confined and Unconfined User Domains" review
References: <48C6236D.4020408@redhat.com> <48C67DCD.2030104@redhat.com>	 <48CDBA0A.3000801@redhat.com>  <48CDC478.3050101@redhat.com> <1221477451.13007.20.camel@sulphur.notebook.internal>
In-Reply-To: <1221477451.13007.20.camel@sulphur.notebook.internal>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dominick Grift wrote:
> On Mon, 2008-09-15 at 12:12 +1000, Murray McAllister wrote:
> 
>> What sudo access does staff_t have?
> 
> I think staff can transition to all privileged user domains
> 
> secadm,logadm,webadm,auditadm,unconfined,sysadm etc. You can verify this
> in the staff role module in the source policy. staff_t may also be root
> however this root as staff_t will have the same permission as staff_t as
> unprivileged user.
> 
Well not in targeted policy.
Out of the box
sesearch --role_allow | grep staff
   allow staff_r sysadm_r;
   allow system_r staff_r;
   allow staff_r unconfined_r;
   allow staff_r webadm_r;

This means staff_r can become sysadm_r, unconfined_r and webadm_r in
Fedora 9/10 targeted policy.
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
