Message-ID: <5266C409.30700@tycho.nsa.gov>
Date: Tue, 22 Oct 2013 14:29:29 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Joe MacDonald <joe@deserted.net>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH][v3] libselinux: support building on older PCRE libs
References: <20131022150005.GD3728@deserted.net> <1382461056-20536-1-git-send-email-joe@deserted.net>
In-Reply-To: <1382461056-20536-1-git-send-email-joe@deserted.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/22/2013 12:57 PM, Joe MacDonald wrote:
> Versions of PCRE prior to 8.20 did not have pcre_free_study().  In its
> absence, use pcre_free() instead.
> 
> Signed-off-by: Joe MacDonald <joe@deserted.net>

Thanks, applied.  I also applied the stat rename just for cleanliness,
although I think the real problem lies elsewhere.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
