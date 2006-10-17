Message-ID: <45351ABE.3050006@trustedcs.com>
Date: Tue, 17 Oct 2006 13:02:38 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Daniel Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH 1/4] libselinux flask definition update for context class
References: <4534FDF8.2000609@trustedcs.com> <453518AB.4020303@tresys.com>
In-Reply-To: <453518AB.4020303@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Darrel Goeddel wrote:
> 
>> Update SELinux flask definition to include the context security class.
>> This also adds the "process setsockcreate" and "association polmatch" 
>> string
>> definitions that have been missing.
>>
>> Signed-off-by: Darrel Goeddel <dgoeddel@trustedcs.com>
>>
>> ---
>>
>> include/selinux/av_permissions.h |   76 
>> ---------------------------------------
> 
> 
> Why all the whitespace changes?

Those are the files created by using the tolib target in the flask directory
of the references policy (with Lindent changes...).  The same is true for the
kernel patch (except for the Lindent).  I asked about that earlier and was
guided to go with the generated files.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
