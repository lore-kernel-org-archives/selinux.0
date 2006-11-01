Message-ID: <4548C6D7.1050709@hp.com>
Date: Wed, 01 Nov 2006 11:09:59 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, jbrindle@tresys.com,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        gcwilson@us.ibm.com
Subject: Re: SELinux Networking Enhancements
References: <000601c6fd2e$ceea6ab0$cc0a010a@tcssec.com> <Pine.LNX.4.64.0610312242270.27961@d.namei> <4548B792.7070604@hp.com> <Pine.LNX.4.64.0611011059190.6253@d.namei>
In-Reply-To: <Pine.LNX.4.64.0611011059190.6253@d.namei>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Wed, 1 Nov 2006, Paul Moore wrote:
> 
>>>Ok, so, there'd be an iptables match which looked up the security context 
>>>on the SA the packet arrives/departs on?  Sounds like it could work.  
>>>Perhaps call it xfrmlabel ?
>>
>>What we name it probably isn't that important, but I sorta prefer Venkat's
>>original suggestion of secfilter (or secidfilter, or <generic security
>>token>filter) since it sounds like this new component would be strictly for
>>filtering and not labeling.
> 
> Well, it's matching labels on xfrms.  The filtering concept is implicit in 
> it being an iptables match, and secid/sec is vague.

I got the impression that Venkat was intending this to work for external labels
(both XFRM and NetLabel) as well as internal labels (SECMARK).  I would be a lot
happier if the name didn't limit it to just XFRM labeling.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
