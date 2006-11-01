Message-ID: <4548B792.7070604@hp.com>
Date: Wed, 01 Nov 2006 10:04:50 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, jbrindle@tresys.com,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        gcwilson@us.ibm.com
Subject: Re: SELinux Networking Enhancements
References: <000601c6fd2e$ceea6ab0$cc0a010a@tcssec.com> <Pine.LNX.4.64.0610312242270.27961@d.namei>
In-Reply-To: <Pine.LNX.4.64.0610312242270.27961@d.namei>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Tue, 31 Oct 2006, Venkat Yekkirala wrote:
> 
>>Implementation issues aside, lately I have been wondering about doing
>>something in the filter table using something we could call secfilter
>>or so.
>>
>>You would still use secmark to label the packets, but they (along with
>>any external labels) could get filtered in the secfilter module. This
>>way we could control what external labels could come thru from what peers.
>>For internal labels it would be more of an assurance thing. This would also
>>automatically take care of forwarding controls.
> 
> Ok, so, there'd be an iptables match which looked up the security context 
> on the SA the packet arrives/departs on?  Sounds like it could work.  
> Perhaps call it xfrmlabel ?

What we name it probably isn't that important, but I sorta prefer Venkat's
original suggestion of secfilter (or secidfilter, or <generic security
token>filter) since it sounds like this new component would be strictly for
filtering and not labeling.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
