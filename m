Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qACFY7hG025583
	for <selinux@tycho.nsa.gov>; Mon, 12 Nov 2012 10:34:10 -0500
Message-ID: <50A116F0.5050404@davequigley.com>
Date: Mon, 12 Nov 2012 10:34:08 -0500
From: "David P. Quigley" <selinux@davequigley.com>
MIME-Version: 1.0
To: "J. Bruce Fields" <bfields@fieldses.org>
CC: David Quigley <dpquigl@davequigley.com>, trond.myklebust@netapp.com,
        sds@tycho.nsa.gov, linux-nfs@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: Labeled NFS [v5]
References: <1352700947-3915-1-git-send-email-dpquigl@davequigley.com> <20121112152335.GH30713@fieldses.org>
In-Reply-To: <20121112152335.GH30713@fieldses.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/12/2012 10:23 AM, J. Bruce Fields wrote:
> On Mon, Nov 12, 2012 at 01:15:34AM -0500, David Quigley wrote:
>> The NFSv4 working group has finally accepted Labeled NFS as part of the NFSv4.2
>> specification and it has been decided that a reposting of the Labeled NFS code
>> for inclusion into mainline was a good idea. The patches have been rebased onto
>> v3.7-rc2 and have been tested against the SELinux testsuite with the only
>> failures being for features not supported by NFS.
> By the way, is there wireshark support anywhere for the labeled NFS
> protocol?
>
> --b.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Unfortunately I never got a chance to add it. You can see the label 
pretty clearly in wireshark but it comes up as an unknown attribute in 
the fattr decomposition. If someone knows how to do it I'd be glad to help.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
