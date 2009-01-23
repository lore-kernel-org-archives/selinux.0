Date: Fri, 23 Jan 2009 13:59:44 -0800
From: Glenn Faden <Glenn.Faden@sun.com>
Subject: Re: [nfsv4] New MAC label support Internet Draft posted to IETF	website
In-reply-to: <497A02A0.9070405@redhat.com>
To: Peter Staubach <staubach@redhat.com>
Cc: Spencer Shepler <shepler@storspeed.com>,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, nfsv4@ietf.org, selinux@tycho.nsa.gov
Message-id: <497A3DD0.3030406@sun.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>
 <54E18340-3542-4AB4-843E-E92A67B709A7@storspeed.com>
 <497A02A0.9070405@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sun is also positive about David's proposal although we currently don't 
depend on it.

Labeled NFS services are currently provided by Solaris Trusted 
Extensions, without relying on NFS protocol extensions. Instead, Trusted 
Extensions uses the labels of the network endpoints to determine the 
labels of the underlying clients and servers. When acting as an NFS 
server, Trusted Extensions sends packets at the same label as the 
underlying exported filesystem. These endpoint labels are then 
implicitly used to enforce mount policy restrictions by the NFS client 
and server code in the kernel. A restriction of this implementation is 
that all files in a NFS mounted filesystem must have the same label.

In order for Solaris to support per-file labeling we will need NFS 
protocol extensions similar to what David has proposed.

--Glenn

Peter Staubach wrote:
> Spencer Shepler wrote:
>>
>> As David suggests, the NFSv4 working group is positive about this
>> work but until now, the show of specific interest within the NFSv4 
>> working group
>> has been very minimal.  If this work is to be added to the working 
>> group's
>> charter, there must be a show of interest.  This can be as simple as an
>> email to the nfsv4@ietf.org alias stating interest and brief description
>> of need/use.  This will demonstrate to the area director that work is
>> occurring and it is worthwhile to have the NFSv4 WG undertake the
>> work.
>>
>> So, please speak up, join the nfsv4 WG alias and participate as
>> interest and need declares. 
>
> I will start, I guess.
>
> We, Red Hat, are looking at this work as enabling some fundamental
> technologies for our virtual offerings.  We need the ability to
> run SELinux over NFS mounted file systems and the current NFSv4[.1]
> support is not sufficient to do it.
>
>    Thanx...
>
>       ps
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
