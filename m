Subject: Re: [PATCH] pam_namespace : allow use of X while polyinstantiating
	/tmp - v3
From: Tomas Mraz <tmraz@redhat.com>
To: janak@us.ibm.com
Cc: selinux@tycho.nsa.gov, russell@coker.com.au, sds@tycho.nsa.gov,
        klaus@atsec.com, sgrubb@redhat.com, dwalsh@redhat.com,
        Valdis.Kletnieks@vt.edu
In-Reply-To: <1150998899.30134.8.camel@localhost.localdomain>
References: <1150820592.31280.2.camel@localhost.localdomain>
	 <200606220735.k5M7ZOUI016994@turing-police.cc.vt.edu>
	 <1150965442.3351.7.camel@perun.kabelta.loc>
	 <1150998899.30134.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 20:16:47 +0200
Message-Id: <1151000207.3351.35.camel@perun.kabelta.loc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-06-22 at 13:54 -0400, Janak Desai wrote:
> On Thu, 2006-06-22 at 10:37 +0200, Tomas Mraz wrote:

> Yes, thanks for find this and other problems. I was using pam_unix
> sources to see how signal handlers are managed by pam modules. It too
> takes non-NULL return values as good previous signal handler value. I
> should have looked at the man page as well.
> 
> Tomas, should I send a patch with just this change or the create a
> v4 version of the patch? I am going to be unavailable in about an hour
> so I can do this on Monday.

You don't have to send the patch. I've already submitted pam_namespace
patch with the above fixed for upstream review to pam-patches mailing
list.

-- 
Tomas Mraz <tmraz@redhat.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
