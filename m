Message-ID: <4E3B09CA.30604@redhat.com>
Date: Thu, 04 Aug 2011 17:06:18 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 029/155] policycoreutils: fixfiles clean up /var/run and
References: <4E39B5E6.8000100@redhat.com>  <1312469767.20973.53.camel@moss-pluto>  <CACLa4ptckXGt6XEqDMnmeZhV3AzVwnL=ktSTtVTFGg+A=Ajcug@mail.gmail.com>  <CACLa4puk2gO=aV=oNj-Kmj=eSmYmquX0skKoCxso6o9tWcf_Ng@mail.gmail.com> <1312486409.20973.66.camel@moss-pluto> <4E3B007B.1020502@redhat.com> <4E3B085D.1050400@redhat.com>
In-Reply-To: <4E3B085D.1050400@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/04/2011 05:00 PM, Eric Paris wrote:
> On 08/04/2011 04:26 PM, Daniel J Walsh wrote:
>> On 08/04/2011 03:33 PM, Stephen Smalley wrote:
>>> On Thu, 2011-08-04 at 13:59 -0400, Eric Paris wrote:
>>>> well I guess [selinuxfs]/initial_contexts/unlabeled works for
>>>> the first part, but how to come up with the lib_t/var_t I
>>>> don't know.... more initial sids   :)
>>> 
>>> chcon --reference=/lib ... chcon --reference=/var ...
>>> 
>>> Or: chcon `matchpathcon /lib` ...
>>> 
>>> 
>> 
>> 
>> How about this patch...
> 
> If you don't have /selinux mounted in one of those two places secon
> -t will return your process type, which might delete the wrong
> files.
> 
I guess we should just exit with an error if this happens.
> Not that it makes a huge difference, but we don't really need to pare
> it down to just the type with secon -t and then search using
> *$TYPE*.
> 
Well if you are using mcstransd the MLS field could be translated.
> I also question the use of /sys/fs/selinux/ but I'm not sure we have
> a good way to find that in a script.....  Do we have one?
> 

grep selinuxfs /proc/self/mountinfo | awk '{ print $5 }'

> -Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
