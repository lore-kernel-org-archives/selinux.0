Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m54JPlD4006272
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2008 15:25:47 -0400
Received: from hs-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m54JPf9V002408
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2008 19:25:46 GMT
Received: by hs-out-0708.google.com with SMTP id k27so159850hsc.2
        for <selinux@tycho.nsa.gov>; Wed, 04 Jun 2008 12:25:41 -0700 (PDT)
Message-ID: <dd18b0c30806041225w4099b07bk3022310c437e0c8c@mail.gmail.com>
Date: Wed, 4 Jun 2008 19:25:40 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Paul Moore" <paul.moore@hp.com>
Subject: Re: NetLabel
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200806041514.17499.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30806032355v44c0b5d2u965e3e7a65ba2e24@mail.gmail.com>
	 <200806041031.33060.paul.moore@hp.com>
	 <dd18b0c30806041205n1841767fn40071790d9dcfd57@mail.gmail.com>
	 <200806041514.17499.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 4, 2008 at 7:14 PM, Paul Moore <paul.moore@hp.com> wrote:
> On Wednesday 04 June 2008 3:05:08 pm Justin Mattock wrote:
>> On Wed, Jun 4, 2008 at 2:31 PM, Paul Moore <paul.moore@hp.com> wrote:
>> > On Wednesday 04 June 2008 2:55:15 am Justin Mattock wrote:
>> >> Hello; Hopefully this is the right list to post this question,
>> >> after looking at  NetLabel, in dmesg I couldn't help but see:
>> >> [    0.570655] NetLabel: Initializing
>> >> [    0.570660] NetLabel:  domain hash size = 128
>> >> [    0.570663] NetLabel:  protocols = UNLABELED CIPSOv4
>> >> [    0.570730] NetLabel:  unlabeled traffic allowed by default
>> >>
>> >> "unlabeled traffic allowed by default."
>> >> is this similar to selinux (handle_unkown=deny, if so is there an
>> >> option to change this to "unlabeled traffic deny."
>> >
>> > Nope, the two are completely unrelated.  By default, NetLabel
>> > allows unlabeled traffic to pass (meaning the
>> > netlbl_skbuff_getattr() function returns an empty secattr and no
>> > error, the LSM does the actual packet pass/drop) so as to keep
>> > networking working for the majority of users who do not configure
>> > NetLabel.  If you were to disable unlabeled traffic using NetLabel
>> > only CIPSO and static/fallback (using 2.6.25 or greater) labeled
>> > traffic would be allowed into the system.
>> >
>> > Unless you really know what you are doing I wouldn't mess with this
>> > setting.
>> >
>> >> Also is there a location for this in the kernel i.g.
>> >> /proc/sys/net/* regards;
>> >
>> > There are some sysctl variables which offer control of the
>> > NetLabel/CIPSO functionality they do no toggle the unlabeled
>> > allow/deny behavior, for that you need the netlabel_tools package,
>> > specifically netlabelctl.
>> >
>> >  * http://netlabel.sf.net
>>
>> I'm going to answer honestly I don't know what I'm doing, so with
>> that in mind maybe I should just leave this for now,
>> I did have a look at the netlabel_tools package, but like what I said
>> in the first sentence, I need to really study this
>> before venturing into this, (that way I'm not stuck with no
>> internet.) regards;
>
> Sound like a good plan.  I wish I had some decent documentation to pass
> along but I haven't had a chance to write anything up so far ...
> regardless, if you have any questions don't hesitate to ask.
>
> Good luck.
>
> --
> paul moore
> linux @ hp
>

Cool thanks for the response and help. I think overall, I'm just
trying to make sure /etc/sysctl.conf is in good condition so my tcp
is not vulnerable to any kind of spoofing action.
regards;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
