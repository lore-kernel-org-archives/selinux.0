Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3E4341G015713
	for <selinux@tycho.nsa.gov>; Tue, 14 Apr 2009 00:03:04 -0400
Received: from smtp107.prem.mail.sp1.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id n3E433JN016443
	for <selinux@tycho.nsa.gov>; Tue, 14 Apr 2009 04:03:03 GMT
Message-ID: <49E40ACE.2070002@schaufler-ca.com>
Date: Mon, 13 Apr 2009 21:02:22 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Nicolas Williams <Nicolas.Williams@sun.com>,
        Jarrett Lu <Jarrett.Lu@sun.com>, dpquigl@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org, nfs-discuss@opensolaris.org,
        selinux@tycho.nsa.gov, nfsv4@ietf.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [nfsv4] my thoughts on how Labeled NFSv4 draft should move forward
References: <49DA6EF8.1080704@sun.com>  <20090410201718.GB1500@Sun.COM> <1239628757.6129.5.camel@localhost.localdomain>
In-Reply-To: <1239628757.6129.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
>> ...
>>
>>  - For DTE I've no idea what to do.  Policy agreement seems like a
>>    flight of fancy for DTE.  But *much* more importantly, because the
>>    process label transitions can span so many labels we simply cannot
>>    have too smart a server: the server can't meaningfully constrain the
>>    labels that a user@client can assert, therefore the server must trust
>>    all client assertions of process DTE labels or none at all.
>>
>>    I.e., for DTE we can only have "dumb" servers.
>>     
>
> Why?  While it is certainly true that a given client may be authorized
> to assert numerous discrete domains, that does not mean that a server
> cannot limit a client to a specific set of domains.  That can be modeled
> via a permission check on a label pair and security class, just like
> everything else.
>   

I think that the point is that for that to be interesting you need
to have a significant number of subject-label/object-label/class
triples from the client available on the server. Additionally, it
assumes that the object label available to the server is in fact
the label from that client, not the server, and not a different
client. Unless you can map the object label on the file, wherever
it originated, to a label that is appropriate to the client's
policy. And heaven forbid that the client that "owns" the label
on the file should change it's policy and reboot. Now what you have
is at best no mapping, and at worst a mapping that reflects the
old, no longer considered "secure" policy.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
