Message-ID: <4BF3F338.4040604@gmail.com>
Date: Wed, 19 May 2010 07:18:32 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Shaz <shazalive@gmail.com>, TaurusHarry <harrytaurus2002@hotmail.com>,
        dwalsh@redhat.com, selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: Re: How to cross install policy store?
References: <BAY111-W21E4613ED1D1458B53C3A6ABE10@phx.gbl>	 <4BF28A59.402@redhat.com>	 <AANLkTimIvyXJNr8xRUAUryDHKGdhohaXwGfaN4ls_VVf@mail.gmail.com>	 <1274188841.8879.2.camel@moss-pluto.epoch.ncsc.mil>	 <1274190359.8879.28.camel@moss-pluto.epoch.ncsc.mil>	 <AANLkTilIi9IGW2LehHbc1FMw-T7NCjeyF9LSoHRbHtvm@mail.gmail.com>	 <1274210546.8879.139.camel@moss-pluto.epoch.ncsc.mil>	 <BAY111-W1931F5A339EB7088E04FDFABE20@phx.gbl>	 <AANLkTilDxLCFs5d0wkzUDHKNpkq7buNKzvFO86qVm9j2@mail.gmail.com>	 <4BF3E5C4.4070004@gmail.com> <1274276054.1143.75.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1274276054.1143.75.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/19/2010 06:34 AM, Stephen Smalley wrote:
> On Wed, 2010-05-19 at 06:21 -0700, Justin P. Mattock wrote:
>> On 05/19/2010 03:04 AM, Shaz wrote:
>>>> It's very true that both SELInux policy and policy store are
>>>> arch-independent. It takes about 70 minutes to build the policy store from
>>>> scratch on my embedded target, but I could copy and use the host policy
>>>> store on the target, only that it will take 20 minutes each time to change
>>>> SELinux attribute on the fly by the semanage tool, so I think I'd better
>>>> save all the trouble by committing the changes to SELInux source code on the
>>>> host instead.
>>>
>>> Sounds interesting. Let me try it too.
>>>
>>
>>
>> yep.. I built a policy on x86_64
>> then copied it to all my other machines(i586)
>> (no problem), but things like libselinux
>> will probably be a different story.
>
> Well, yes, because libselinux is executable code.  policy is just data.
>


hmm.. I'm wondering if something could be modified
with monolithic policies and the whole policy
version thing i.g. build.conf:

# Policy version
# By default, checkpolicy will create the highest
# version policy it supports.  Setting this will
# override the version.  This only has an
# effect for monolithic policies.
#OUTPUT_POLICY = 18


Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
