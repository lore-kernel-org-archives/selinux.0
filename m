Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r2DE2xwu020663
	for <selinux@tycho.nsa.gov>; Wed, 13 Mar 2013 10:02:59 -0400
Received: by mail-qa0-f52.google.com with SMTP id bs12so647203qab.11
        for <selinux@tycho.nsa.gov>; Wed, 13 Mar 2013 07:02:57 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: "Langland, Blake" <blangland@integrity-apps.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: SELinux network labeling
Date: Wed, 13 Mar 2013 10:02:54 -0400
Message-ID: <2547229.Czz0AkDGmt@sifl>
In-Reply-To: <514080E7.8020602@tycho.nsa.gov>
References: <DA8D339A60101247B36E202899B1C93A7C9378@CHUNEX01.integrity-apps.com> <514080E7.8020602@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, March 13, 2013 09:36:39 AM Stephen Smalley wrote:
> netlabel vs labeled ipsec:  netlabel only supports passing MLS labels
> via CIPSO, no user:role:type preservation.  labeled ipsec supports
> passing the entire security context, including user:role:type.

Just one quick comment, and a word of caution, that the differences between 
CIPSO and labeled IPsec are much greater than what is described above.

>From a SELinux policy perspective Stephen does touch on the main point: CIPSO 
labeled traffic will look like system_u:object_r:netlabel_peer_t:{MLS-LABEL} 
to SELinux regardless of the user:role:type of the sender (only the "MLS-
LABEL" information is passed over the wire) while labeled IPsec will pass the 
full context over the wire.  However, stepping back just the SELinux policy 
there are other differences between the two protocols that need to be 
considered when building a full solution.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
