From: Steve Grubb <sgrubb@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: setsebool
Date: Thu, 13 Jul 2006 07:34:35 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Michael C Thompson <thompsmc@us.ibm.com>,
        SE Linux <selinux@tycho.nsa.gov>
References: <44AD708E.10205@us.ibm.com> <44B5623C.8060600@us.ibm.com> <44B6265C.3010005@redhat.com>
In-Reply-To: <44B6265C.3010005@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607130734.35344.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 13 July 2006 06:54, Daniel J Walsh wrote:
> Is this a problem in the Kernel or libraries?  Or just the way it is?

I think the granted statement comes from policy. I was thinking that audit of 
granting when changing booleans would be dropped from policy when the 2.6.17 
kernel was out.

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
