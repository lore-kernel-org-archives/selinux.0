Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4QIsr63029463
	for <selinux@tycho.nsa.gov>; Tue, 26 May 2009 14:54:53 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4QIsm5p009330
	for <selinux@tycho.nsa.gov>; Tue, 26 May 2009 18:54:48 GMT
Message-ID: <4A1C3AD9.6020903@redhat.com>
Date: Tue, 26 May 2009 14:54:17 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Justin Mattock <justinmattock@gmail.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Introducing SELinux Sanbox
References: <4A1C0BC7.2@redhat.com>	 <dd18b0c30905261012wa397008wef0a4388d6ee1e58@mail.gmail.com>	 <4A1C2F25.8090205@redhat.com> <dd18b0c30905261152u6643c64eg205135e81fb69550@mail.gmail.com>
In-Reply-To: <dd18b0c30905261152u6643c64eg205135e81fb69550@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/26/2009 02:52 PM, Justin Mattock wrote:
> On Tue, May 26, 2009 at 11:04 AM, Daniel J Walsh<dwalsh@redhat.com>  wrote:
>> On 05/26/2009 01:12 PM, Justin Mattock wrote:
>>> On Tue, May 26, 2009 at 8:33 AM, Daniel J Walsh<dwalsh@redhat.com>    wrote:
>>>> For those who do not ordinarily read my blog.
>>>>
>>>> http://danwalsh.livejournal.com/28545.html
>>>>
>>>>
>>>> --
>>>> This message was distributed to subscribers of the selinux mailing list.
>>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>>>> with
>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>
>>> hey, nice article.
>>> What are your thoughts about
>>> flashplayer?
>>> I myself enjoy watching T.V. through flash,
>>> although seeing all of the avc's generated does scare me a bit.
>>> even though the avc's are just {read, geattr, search, open}
>>> (looked into gnash, but compiling that from source requires quit a bit)
>>>
>>> If only flash could be as simple as watching T.V. through mplayer,
>>> which generates far less avc's.
>>>
>> Flash should work with nsplugin_t if you turn on the
>> allow_unconfined_nsplugin_transition
>> boolean
>>
>> You should not be seeing any avc's from this in F10/F11.  You might need to
>> fix the labeling in your homedir.
>>
>> restorecon -R -v ~/
>>
>>
>
> yeah I noticed F11 was setup nicely
> (you wouldn't even know there is a policy)
>
> over here I've a home brewed distro
> with just the bare essentials to run.
>
> The policy was fetched from svn a few days ago,
> firefox is the latest 3.5 beta 4(did compile a few months
> ago, but found it taking half the day to do so.)
> and then libflashplayer.so(with just the bare needs
> gtk+,pango,libpng,libcurl) located in /usr/lib/firefox/plugins.
> (probably should relocate to the home dir, and setup the restorecon
> daemon)
>
> As for the home directory, at the moment I setup namespace.so
> (but since I'm the only one using the machine probably
> doesn't make a difference).
>
> As for other plugins for firefox, I did have a chance to
> run nsplugin(but then with the latest system I just built
> decided to leave that out, as well as mozplugger, and any
> other plug-in except flash.)
>
ok

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
