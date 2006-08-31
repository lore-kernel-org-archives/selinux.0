Message-ID: <44F6F3A5.2020401@trustedcs.com>
Date: Thu, 31 Aug 2006 09:35:17 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Christopher PeBenito <cpebenito@tresys.com>
Subject: Re: [PATCH 2/3 v2] semantic MLS representation for range_trans_rules
References: <44F3192B.2000408@trustedcs.com>	 <44F6E74B.3030904@trustedcs.com> <1157033407.24429.94.camel@twoface.columbia.tresys.com>
In-Reply-To: <1157033407.24429.94.camel@twoface.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:

<snip>

>>diff --exclude=.svn -ruNp selinux-list/checkpolicy/policy_parse.y selinux-rangetrans-2/checkpolicy/policy_parse.y
>>--- selinux-list/checkpolicy/policy_parse.y	2006-08-25 06:16:11.000000000 -0500
>>+++ selinux-rangetrans-2/checkpolicy/policy_parse.y	2006-08-30 06:23:54.000000000 -0500
>>@@ -3616,6 +3616,65 @@ parse_categories(char *id, level_datum_t
>> 	return 0;
>> }
>> 
>>+static int
>>+parse_semantic_categories(char *id, level_datum_t * levdatum,
> 
> 
> hrm, did lindent do this?

Nope, the cut-paste-modify of parse_categories did it.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
