Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v49GD3Xt001465
 for <selinux@tycho.nsa.gov>; Tue, 9 May 2017 12:13:05 -0400
Received: by mail-qk0-f177.google.com with SMTP id a72so5183366qkj.2
 for <selinux@tycho.nsa.gov>; Tue, 09 May 2017 09:13:00 -0700 (PDT)
Message-ID: <5911EA89.2060504@quarksecurity.com>
Date: Tue, 09 May 2017 12:12:57 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Karl MacMillan <karlwmacmillan@gmail.com>
CC: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
References: <20170506171920.GB20145@julius> <590F3B98.406@quarksecurity.com>
 <20170507154759.GA31890@julius> <590F78BA.5040800@quarksecurity.com>
 <20170508085555.GA3701@julius> <20170508093229.GB3701@julius>
 <B4D29110-19AF-4378-A933-DDA41D5B2A0B@gmail.com>
 <20170508194931.GB7367@julius>
 <8AE6E08C-5E9B-4166-AD82-EB57DF4CAE5C@gmail.com>
 <20170508204053.GC7367@julius> <20170508214714.GD7367@julius>
 <84F6F2D5-393C-4313-A88D-02E596729B8A@gmail.com>
In-Reply-To: <84F6F2D5-393C-4313-A88D-02E596729B8A@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Karl MacMillan wrote:
<snip>
>
>>> 5. any references to type attributes should be customizable: ie. process_types = ... filesystem_types = ... etc
>> I do not consider Linux access vectors to be customizable, unlike types ,attributes, booleans, tunables etc)
>>
>
> I know what you mean, but I have to point out that the domain attribute has been much more stable across many different operating systems than the object classes and access vectors.

This is true, and being able to specify subject types and object types 
(processes and files are instances of those) could make this useful for 
analysis of e.g., Xen policies... Not that I see a huge demand for that 
sort of thing
