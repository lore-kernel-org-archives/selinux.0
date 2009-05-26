Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4QI51ig019217
	for <selinux@tycho.nsa.gov>; Tue, 26 May 2009 14:05:01 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4QI4t5p011122
	for <selinux@tycho.nsa.gov>; Tue, 26 May 2009 18:04:55 GMT
Message-ID: <4A1C2F25.8090205@redhat.com>
Date: Tue, 26 May 2009 14:04:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Justin Mattock <justinmattock@gmail.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Introducing SELinux Sanbox
References: <4A1C0BC7.2@redhat.com> <dd18b0c30905261012wa397008wef0a4388d6ee1e58@mail.gmail.com>
In-Reply-To: <dd18b0c30905261012wa397008wef0a4388d6ee1e58@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/26/2009 01:12 PM, Justin Mattock wrote:
> On Tue, May 26, 2009 at 8:33 AM, Daniel J Walsh<dwalsh@redhat.com>  wrote:
>> For those who do not ordinarily read my blog.
>>
>> http://danwalsh.livejournal.com/28545.html
>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>> with
>> the words "unsubscribe selinux" without quotes as the message.
>>
>
> hey, nice article.
> What are your thoughts about
> flashplayer?
> I myself enjoy watching T.V. through flash,
> although seeing all of the avc's generated does scare me a bit.
> even though the avc's are just {read, geattr, search, open}
> (looked into gnash, but compiling that from source requires quit a bit)
>
> If only flash could be as simple as watching T.V. through mplayer,
> which generates far less avc's.
>
Flash should work with nsplugin_t if you turn on the
allow_unconfined_nsplugin_transition
boolean

You should not be seeing any avc's from this in F10/F11.  You might need 
to fix the labeling in your homedir.

restorecon -R -v ~/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
