Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k51FXVXU004009
	for <selinux@tycho.nsa.gov>; Thu, 1 Jun 2006 11:33:31 -0400
Received: from e34.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k51FXUPk002462
	for <selinux@tycho.nsa.gov>; Thu, 1 Jun 2006 15:33:30 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k51FXUPU020440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 1 Jun 2006 11:33:30 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k51FXTVA253060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Thu, 1 Jun 2006 09:33:29 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k51FXTDT006627
	for <selinux@tycho.nsa.gov>; Thu, 1 Jun 2006 09:33:29 -0600
Message-ID: <447F08B9.8060707@us.ibm.com>
Date: Thu, 01 Jun 2006 11:33:13 -0400
From: Janak Desai <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
MIME-Version: 1.0
To: Tomas Mraz <tmraz@redhat.com>
CC: russell@coker.com.au, dwalsh@redhat.com, valdis.kletnieks@vt.edu,
        sgrubb@redhat.com, klaus@atsec.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH] pam_namespace : option to check instance parent mode
 and man page(s) updates
References: <44710A40.4060309@us.ibm.com>	 <200605221105.55104.russell@coker.com.au> <4471BA2C.7090806@us.ibm.com>	 <447E0B6E.5020902@us.ibm.com> <1149167654.3514.16.camel@perun.kabelta.loc>
In-Reply-To: <1149167654.3514.16.camel@perun.kabelta.loc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Tomas Mraz wrote:
> On Wed, 2006-05-31 at 17:32 -0400, Janak Desai wrote:
> 
>>This patch, which applies on top of the latest pam_namespace in rawhide, adds a new
>>command line option to allow an admin to bypass checking of the instance parent 
>>mode. It also updates namespace.conf and pam_namespace man pages to add text
>>relating this new option, interaction with share-subtree and possible config 
>>changes that would allow the use of pam_namespace with gdm and polyinstantiation
>>of /tmp.
> 
> 
> In the documentation files there is always written that the mode of the
> parent directory is checked to be 1000 but in the code you check only
> the user, group and other bits. Should the documentation be adjusted to
> say 000?

Oops. The documentation is correct. The code should also check for the
sticky bit. I will fix that and send updated patch later this afternoon.

-Janak

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
