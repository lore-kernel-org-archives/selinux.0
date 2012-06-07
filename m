Message-ID: <4FD0C844.2070800@tresys.com>
Date: Thu, 7 Jun 2012 11:27:00 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
CC: <SELinux@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] Update SELinux policy capability to always check
 peer class.
References: <1339003731-6743-1-git-send-email-cpebenito@tresys.com> <1339003731-6743-2-git-send-email-cpebenito@tresys.com> <16742766.tXTOYM7uO2@sifl>
In-Reply-To: <16742766.tXTOYM7uO2@sifl>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/07/12 10:28, Paul Moore wrote:
> On Wednesday, June 06, 2012 01:28:51 PM Chris PeBenito wrote:
>> Update the always_check_network policy capability which, when enabled,
>> treats peer labeling as enabled, even if there is no Netlabel or
>> labeled IPSEC configuration.
>>
>> Signed-off-by: Chris PeBenito <cpebenito@tresys.com>
> 
> I still object to this patchset for all the same old reasons, but I feel 
> obligated to point out that this patchset is still incomplete/incorrect in 
> that it only deals with the socket_sock_rcv_skb hook.
 
I found the missing hooks, but does this need to affect selinux_ip_output()?  It seems like the answer is no, as it looks like its just applying the NetLabel on outgoing packets.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
