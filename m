Message-ID: <415AC9D0.1080708@redhat.com>
Date: Wed, 29 Sep 2004 10:42:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Problems with fixfiles and setfiles.
References: <4159C55D.4050404@redhat.com> <200409300034.10552.russell@coker.com.au>
In-Reply-To: <200409300034.10552.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Wed, 29 Sep 2004 06:11, Daniel J Walsh <dwalsh@redhat.com> wrote:
>  
>
>>The fixfiles script is used to report and fix file contexts that are
>>invalid, the problem is that it gets a lot of
>>false positives.  Reviewing fixfiles.cron shows that most of the files
>>created by mozilla are reported as invalid.
>>It would be nice if we could remove these false positives by some means.
>>
>>If we had some mechanism of saying a file could have one of several
>>valid contexts, or be in a context that
>>has a certain attribute.
>>    
>>
>
>For files under the home directory the valid contexts are all the contexts 
>that the user in question can create (directly or indirectly).
>
>If the user does "mv .ssh .ssh-old" we don't want .ssh-old relabelled at 
>user_home_t.
>
>Maybe we should just have fixfiles skip the home directories?
>
>  
>
Yes I considered that, but fixfiles is just a front end to setfiles,  
which does not have an easy way of skipping home dirs.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
