Message-ID: <445F6E38.7070707@redhat.com>
Date: Mon, 08 May 2006 12:13:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: secon (Was: Policycoreutils patch)
References: <445BB803.4050409@redhat.com> <1147100068.23640.53.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1147100068.23640.53.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2006-05-05 at 16:39 -0400, Daniel J Walsh wrote:
>   
>> Broken audit2allow into two packages including avc.py so that other 
>> tools can use it.
>>
>> Began adding code to allow it to analyze AVC message and use plugin 
>> architecture to translate avc messages.
>>
>> Internationailization code added.
>>
>> Some po files translated.
>>
>> Fixes for semanage
>>
>> Cleanup of code
>>     
>
> What is the purpose of the secon utility added by this patch?
>   
The idea is to be able to use utility within bash to show what role/type 
you are in at the prompt.
James Antill built it and is experimenting with some other features.  We 
could obviously do this with python bindings, but wanted something light 
weight to handle MLS type situations.
> Assuming that it is useful, a few quick comments on the implementation:
> - The my_getXcon_raw functions should be moved into libselinux (without
> the my_ prefix, of course) so that we don't need any code outside of
> libselinux directly reading /proc/pid/attr files.
> - Falling back to the current context when the exec or fscreate context
> is not set is not correct.  Absence of exec or fscreate context just
> means that the default policy behavior (e.g. type_transition or default
> inheritance) will be applied.  While default inheritance would mean that
> the current context is applied for exec, there could be a
> type_transition, and it makes no sense at all for fscreate (where
> default inheritance combines information from the current context with
> the parent directory context).  I think you just want to report NULL /
> none or similar to the user.
> - The call to selinux_trans_to_raw_context() doesn't make sense since
> you are already calling the _raw functions.  If opt->disp_raw is set,
> then no further processing should be required, right?
>
>   
I have passed on your comments and we will get out a patch.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
