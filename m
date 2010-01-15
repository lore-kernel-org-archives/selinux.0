Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0FGUZ26016666
	for <selinux@tycho.nsa.gov>; Fri, 15 Jan 2010 11:30:35 -0500
Received: from fg-out-1718.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o0FGTE62014025
	for <selinux@tycho.nsa.gov>; Fri, 15 Jan 2010 16:29:15 GMT
Received: by fg-out-1718.google.com with SMTP id e21so264750fga.12
        for <selinux@tycho.nsa.gov>; Fri, 15 Jan 2010 08:30:33 -0800 (PST)
Message-ID: <4B509857.6020600@gmail.com>
Date: Fri, 15 Jan 2010 08:31:19 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Jiri Kosina <jkosina@suse.cz>
CC: selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix some typo's in avc.c
References: <1263538998-20088-1-git-send-email-justinmattock@gmail.com> <alpine.LNX.2.00.1001151131180.30977@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1001151131180.30977@pobox.suse.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/15/10 02:31, Jiri Kosina wrote:
> On Thu, 14 Jan 2010, Justin P. Mattock wrote:
>
>> Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
>> ---
>>   security/selinux/avc.c |    6 +++---
>>   1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
>> index f2dde26..3328b1f 100644
>> --- a/security/selinux/avc.c
>> +++ b/security/selinux/avc.c
>> @@ -337,7 +337,7 @@ static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
>>    * Look up an AVC entry that is valid for the
>>    * (@ssid, @tsid), interpreting the permissions
>>    * based on @tclass.  If a valid AVC entry exists,
>> - * then this function return the avc_node.
>> + * then this function returns the avc_node.
>
> Applied, thanks.
>

your welcome.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
