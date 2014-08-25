Message-ID: <53FB545C.3080106@tycho.nsa.gov>
Date: Mon, 25 Aug 2014 11:21:00 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Stepan G. Fedorov" <stfedorov@gmail.com>, Paul Moore <paul@paul-moore.com>
Subject: Re: semanage interface has no effect
References: <53FB19C7.1040500@gmail.com>	<53FB35D2.3030307@tycho.nsa.gov>	<53FB4192.8090203@gmail.com>
 <CAHC9VhSwgERb2NoY8vK3nT=wxBh7fyaD7ECGoxcRij5P6u1XKQ@mail.gmail.com>
 <53FB4C5A.2030503@gmail.com>
In-Reply-To: <53FB4C5A.2030503@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/25/2014 10:46 AM, Stepan G. Fedorov wrote:
>> In this case the incoming packets would be labeled "unlabeled_t", just
>> like any other unlabeled data on the system. 
> 
> Can you, please tell where exactly I can see this in the linux source
> code for better understanding?
> 

secmark or peer label?

secmark label:  Unless set by net/netfilter/xt_*SECMARK.c, secmark
should just be zero (cleared upon skb allocation) and thus will be
remapped by security/selinux/ss/sidtab.c:sidtab_search_core() to the
UNLABELED initial SID.

peer label:  security/selinux/hooks.c:selinux_skb_peerlbl_sid() asks the
xfrm (ipsec) and netlabel (cipso) subsystems for any labeling
information for the packet and then calls
security/selinux/ss/services.c:security_net_peersid_resolve() to make
the final determination.  In the absence of any labeling information,
we'll also end up with SECSID_NULL i.e. 0 and then the sidtab will again
remap it to the UNLABELED initial SID.
