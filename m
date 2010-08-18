Message-ID: <4C6C24E4.2010401@gmail.com>
Date: Wed, 18 Aug 2010 11:22:28 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: SE-Linux <selinux@tycho.nsa.gov>, xorg@freedesktop.org
Subject: Re: SELinux xace crash with xfce4: Caught signal 11 (Segmentation
 fault). Server aborting
References: <AANLkTimXzCXhXRM=y91=5WrpgedkYzzCMTnf5f-cwPs-@mail.gmail.com> <4C6C1F2A.8020900@tycho.nsa.gov>
In-Reply-To: <4C6C1F2A.8020900@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/18/2010 10:58 AM, Eamon Walsh wrote:
> On 08/16/2010 01:27 PM, Justin Mattock wrote:
>> hello,
>> I'm in the process of building a new system from scratch, and am
>> noticing a crash when I have SELinux enabled(permissive)  with the
>> xserver_object_manager 1 boolean set to on(if I set this boolean to
>> off  I can login etc.. to my xfce4 session and all is good)
>>
>>
>
> I'm investigating this, thanks for the backtrace.
>
>
>


alright.. keep in mind this is fresh system(who knows what I missed)
also with xfce I used the stable version(which this hit), then am now 
upgrading to the git version(which hits also) but the transition is a 
with xfce4 is a bit tricky..

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
