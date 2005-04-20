Message-ID: <4266A2F4.6040302@hp.com>
Date: Wed, 20 Apr 2005 14:44:04 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: jrdesai18-tech@yahoo.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: selinux-policy-mls is now available for your testing pleasure.
References: <20050420181222.60238.qmail@web50201.mail.yahoo.com>
In-Reply-To: <20050420181222.60238.qmail@web50201.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

jrdesai18-tech@yahoo.com wrote:
> --- Paul Moore <paul.moore@hp.com> wrote:
> 
>>Paul Moore wrote:
>>
>>>Stephen Smalley wrote:
>>>
>>>
>>>>On Tue, 2005-04-19 at 18:29 -0400, James Morris wrote:
>>>>
>>>>
>>>>>>12 Rebooted normally, i.e. 'rhgb quiet 5', and X failed to start
>>>>>
>>>>>
>>>>>Haven't tried X yet, not sure it's supposed to work.
>>>>
>>>>
>>>>Works for me.  Of course, you do need to have the allow_execmem=1
>>>>boolean enabled for X to run, but that is independent of
>>>>MLS.  /usr/sbin/setsebool -P allow_execmem=1.  Did the RPM include
>>
>>a
>>
>>>>booleans file?
>>>>
>>>
>>>Yes it did, however, the allow_execmem entry was missing.  I added
>>
>>it 
>>
>>>via setsebool and verified that it was in the booleans.local file
>>
>>and 
>>
>>>rebooted to see gdm startup this time but I could not login -
>>
>>according 
>>
>>>to the xsession-errors file Xlib failed to connect to the display,
>>
>>which 
>>
>>>was running on ":0.0".
>>>
>>
>>I was playing with this some more and a regular user was allowed to 
>>login via gdm - just not root.
>>
> 
> 
> Hi Paul,
> 
> I saw a similar problem. In my case /tmp/gconfd-root had a type
> other than tmp_t (I think it was sysadm_tmp or something like
> that). It is possible that it was there from a previous login
> of root when MLS was not active. Try removing that directory 
> and see if you can login as root.
> 
> -Janak

Hi Janak,

Thanks for the suggestion.  I made sure to clear out '/tmp' when I first 
ran into problems booting and I just checked it again - not gconf 
entries for root.

-- 
. paul moore . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. paul.moore@hp.com                                      hewlett packard
. (603) 884-5056                                          linux security

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
