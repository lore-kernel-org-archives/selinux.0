Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7QD8CKS012111
	for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2011 09:08:12 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7QD8B7u009816
	for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2011 13:08:12 GMT
Message-ID: <4E579ABB.5030808@tresys.com>
Date: Fri, 26 Aug 2011 09:08:11 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Eric Paris <eparis@redhat.com>, <qingtao.cao@windriver.com>,
        Eric Paris
	<eparis@parisplace.org>, <slawrence@tresys.com>,
        <selinux@tycho.nsa.gov>
Subject: Re: v0 Separate tunables from booleans
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com> <CACLa4pvMmx32JpX=vzOb8TvEqJ7HqTBVK=PNTFQjkiF924sMjA@mail.gmail.com> <4E55E8E7.1050804@windriver.com> <4E564860.2090502@redhat.com> <4E56F435.1080608@windriver.com> <4E57036F.4070900@redhat.com> <4E5798AD.5080908@redhat.com> <4E579A65.3090002@tresys.com>
In-Reply-To: <4E579A65.3090002@tresys.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/26/11 09:06, Christopher J. PeBenito wrote:
> On 08/26/11 08:59, Daniel J Walsh wrote:
>> I agree, I would like to take the patch to make tunables real, but we
>> need to have a similar level of diagnosis capability to what we have now.
>>
>> The admin needs to know what the tunables are and needs to be able to
>> take an AVC and see if any tunable/boolean would allow the AVC.
>>
>> If we had this, I would be racing towards the tunable.
>>
>> I see this as two steps.
>>
>> 1.  Implement what we have now in booleans in tunables to shrink the
>> size of policy.
>> 2.  Allow policy writers to define rules within tunables that is
>> currently not available in booleans.
>>     - Type Definitions
>>     - Assigning attributes
> 
> I would go farther than that.  I think it should be any statement that
> is allowed in an optional block.  If I can get the RBAC stuff in there,
> then I can get rid of the DIRECT_INITRC build option, which exists due
> to the role_transition statement in the init_run_daemon() interface.

By "get rid of" I mean "convert to tunable".

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
