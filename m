Message-ID: <473E03F0.2040606@redhat.com>
Date: Fri, 16 Nov 2007 15:56:16 -0500
From: Peter Staubach <staubach@redhat.com>
MIME-Version: 1.0
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
CC: labeled-nfs@linux-nfs.org, selinux@tycho.nsa.gov
Subject: Re: [RFC Labeled NFS] Labeling support for NFSv4
References: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
In-Reply-To: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David P. Quigley wrote:
> This is the first set of patches for the labeled-nfs work since early August.
> Much has changed since then and we have a reasonably functional prototype of
> the dumb server implementation. This patch series provides the ability to
> retrieve and set labels on the server, provides callback notification for label
> changes on the server, and life-cycle management for the fattr structure which
> is used to transport the labels.
>
> The patch series should apply on top of any 2.6.24-rc2 kernel and I know for a
> fact that it will apply on top of commit 
> 9418d5dc9ba40b88737580457bf3b7c63c60ec43 in Linus's git tree. To get the tree
> up and running for testing just apply the patch and have fun.

How is the work going on with the NFSv4 IETF WG?

    Thanx...

       ps

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
