Message-ID: <47E1E050.7060006@tycho.nsa.gov>
Date: Wed, 19 Mar 2008 23:56:00 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Grubb <sgrubb@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Permissive mode for xace is broken.
References: <47C2CC18.6080801@redhat.com> <200802281617.17223.sgrubb@redhat.com> <47C767B4.7060606@tycho.nsa.gov> <200803171611.08351.sgrubb@redhat.com>
In-Reply-To: <200803171611.08351.sgrubb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve Grubb wrote:
> On Thursday 28 February 2008 21:02:28 Eamon Walsh wrote:
>   
>> Steve Grubb wrote:
>>     
>>> On Thursday 28 February 2008 13:51:05 Stephen Smalley wrote:
>>>       
>>>> On Thu, 2008-02-28 at 13:48 -0500, Eamon Walsh wrote:
>>>>         
>>>>> Stephen Smalley wrote:
>>>>>           
>>>>>> On Mon, 2008-02-25 at 20:12 -0500, Eamon Walsh wrote:
>>>>>>             
>>>>>>> Eamon Walsh wrote:
>>>>>>>               
>>>>>>>> The X object manager logs all avc's and status messages (including
>>>>>>>> the AVC netlink stuff) through the audit system using libaudit calls
>>>>>>>> (audit_log_user_avc_message, etc.)
>>>>>>>>                 
>>> Please tell me they have different record types. Also do you have any
>>> samples that we can look over to make sure they conform?
>>>       
>> type=USER_AVC msg=audit(1204226161.048:268): user pid=21267 uid=0
>> auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023
>> msg='avc:  denied  { read } for request=X11:QueryPointer
>> comm=/usr/libexec/at-spi-registryd xdevice="Virtual core pointer"
>> scontext=staff_u:staff_r:staff_t:s0
>> tcontext=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 tclass=x_device :
>> exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
>>     
>
> comm & xdevice are not escaped the right way. exe is. The audit utilities are 
> expecting the comm field to be comm="/usr/libexec/at-spi-registryd" in this 
> case. The standard has been untrusted fields have " " enclosing the field. 
> Whenever there is a space, double quote, or control character, its ASCII HEX 
> encoded with no quotes. xdevice is not a field that the audit system knows 
> about, so we could do something different with it, but comm is known for a 
> long time and has to follow the standards.
>   

Why can't libaudit automatically perform this escaping?  That way we 
avoid promulgating this "standard" into every caller of libaudit.

If everything is going to be name-value based, then I want a libaudit 
function that takes a list of name/value pairs.


> Also, is there any information about who caused the event? uid, auid, gid? 
> Even though this was a denied action, what is the results? Were they 
> successful (permissive) or was it really a failed and denied request?
>   

I don't understand this last part with the result of the action.  How am 
I supposed to specify this?

I need to modify libselinux (again) to support all of this extra uid and 
hostname stuff getting passed into the logging callback.


> Would it make sense to fill in the workspace:window information for the 
> terminal? If X is being used remotely, is the addr & hostname fields correct?
>   

The X server has a terminal that it runs on, /dev/tty7 or whatever.  The 
desktop workspaces and gnome-terminal/xterm pseudo-tty's are external to 
the X server and it doesn't know about them.


> That's the only things I notice at this point.
>
> -Steve
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>   


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
