Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5JJTAxi012313
 for <selinux@tycho.nsa.gov>; Fri, 19 Jun 2015 15:29:10 -0400
Message-ID: <55846D8E.5010904@tycho.nsa.gov>
Date: Fri, 19 Jun 2015 15:29:18 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: NFS
References: <CAEcA1_vvB2vUzPEssY=8v3emMfDhfksxYVS_B_rDk=HXoZapoA@mail.gmail.com>
In-Reply-To: <CAEcA1_vvB2vUzPEssY=8v3emMfDhfksxYVS_B_rDk=HXoZapoA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/19/2015 03:09 PM, Andrew Holway wrote:
> So how much of this got implemented? Whats the story with NFSv4?
> https://www.nsa.gov/research/_files/selinux/papers/nfsv3.pdf
>

The v3 work was experimental and there was no real way to upstream it in a 
compatible way.

Dave Quigley worked with the IETF on SELinux labeled NFS support for NFS 4.2 and 
it has been available since Fedora 20. This allows each file to have their own 
SELinux label on the server, but enforcement is only handled by the client.


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
