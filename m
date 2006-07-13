Subject: Re: setsebool
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Michael C Thompson <thompsmc@us.ibm.com>, Steve Grubb <sgrubb@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <44B6265C.3010005@redhat.com>
References: <44AD708E.10205@us.ibm.com>
	 <200607061639.55819.sgrubb@redhat.com> <44AD7553.3050605@us.ibm.com>
	 <200607061712.05688.sgrubb@redhat.com> <44AE7C4E.2070500@us.ibm.com>
	 <44AFC876.8050501@redhat.com> <44B54FDC.7040505@us.ibm.com>
	 <44B55404.6090702@redhat.com> <44B55CB2.8010409@us.ibm.com>
	 <44B560CD.7080202@redhat.com> <44B5623C.8060600@us.ibm.com>
	 <44B6265C.3010005@redhat.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 08:07:40 -0400
Message-Id: <1152792460.10075.179.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-07-13 at 06:54 -0400, Daniel J Walsh wrote:
> How come when I set one boolean via setsebool I get an AVC granted 
> message for all the booleans? 
> 
> Is this a problem in the Kernel or libraries?  Or just the way it is?

libsemanage sets them all upon commit.
We could likely drop the auditallow statement on setbool as it isn't
particularly useful and we now have the explicit audit messages for
MAC_CONFIG_CHANGE.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
