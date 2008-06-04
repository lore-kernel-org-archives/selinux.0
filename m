Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m54J5AJI002291
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2008 15:05:10 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m54J599V023137
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2008 19:05:09 GMT
Received: by wx-out-0506.google.com with SMTP id i26so184065wxd.30
        for <selinux@tycho.nsa.gov>; Wed, 04 Jun 2008 12:05:09 -0700 (PDT)
Message-ID: <dd18b0c30806041205n1841767fn40071790d9dcfd57@mail.gmail.com>
Date: Wed, 4 Jun 2008 19:05:08 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Paul Moore" <paul.moore@hp.com>
Subject: Re: NetLabel
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200806041031.33060.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30806032355v44c0b5d2u965e3e7a65ba2e24@mail.gmail.com>
	 <200806041031.33060.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 4, 2008 at 2:31 PM, Paul Moore <paul.moore@hp.com> wrote:
> On Wednesday 04 June 2008 2:55:15 am Justin Mattock wrote:
>> Hello; Hopefully this is the right list to post this question,
>> after looking at  NetLabel, in dmesg I couldn't help but see:
>> [    0.570655] NetLabel: Initializing
>> [    0.570660] NetLabel:  domain hash size = 128
>> [    0.570663] NetLabel:  protocols = UNLABELED CIPSOv4
>> [    0.570730] NetLabel:  unlabeled traffic allowed by default
>>
>> "unlabeled traffic allowed by default."
>> is this similar to selinux (handle_unkown=deny, if so is there an
>> option to change this to "unlabeled traffic deny."
>
> Nope, the two are completely unrelated.  By default, NetLabel allows
> unlabeled traffic to pass (meaning the netlbl_skbuff_getattr() function
> returns an empty secattr and no error, the LSM does the actual packet
> pass/drop) so as to keep networking working for the majority of users
> who do not configure NetLabel.  If you were to disable unlabeled
> traffic using NetLabel only CIPSO and static/fallback (using 2.6.25 or
> greater) labeled traffic would be allowed into the system.
>
> Unless you really know what you are doing I wouldn't mess with this
> setting.
>
>> Also is there a location for this in the kernel i.g. /proc/sys/net/*
>> regards;
>
> There are some sysctl variables which offer control of the
> NetLabel/CIPSO functionality they do no toggle the unlabeled allow/deny
> behavior, for that you need the netlabel_tools package, specifically
> netlabelctl.
>
>  * http://netlabel.sf.net
>
> --
> paul moore
> linux @ hp
>

I'm going to answer honestly I don't know what I'm doing, so with that
in mind maybe I should just leave this for now,
I did have a look at the netlabel_tools package, but like what I said
in the first sentence, I need to really study this
before venturing into this, (that way I'm not stuck with no internet.)
regards;


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
