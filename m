Message-ID: <467824E8.5000409@redhat.com>
Date: Tue, 19 Jun 2007 14:48:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: James Athey <jathey@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Ted X Toth <txtoth@gmail.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: [RFC][PATCH] libselinux: refactored SWIG bindings
References: <1181744873.18728.10.camel@exodus.columbia.tresys.com>	 <1182253254.15064.4.camel@moss-spartans.epoch.ncsc.mil> <1182265710.14549.7.camel@exodus.columbia.tresys.com>
In-Reply-To: <1182265710.14549.7.camel@exodus.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Athey wrote:
> On Tue, 2007-06-19 at 07:40 -0400, Stephen Smalley wrote:
>   
>> Ted reports that this patch solves his problems with the libselinux
>> python bindings.  However, I noticed that it breaks
>> system-config-selinux due to excluding selinux_raw_to_trans_context and
>> friends.  Dan, can you check over the patch and see if there are any
>> other omissions from these python bindings that you need?
>>     
>
> That's an oversight on my part - I had already included the _raw
> functions in the wrapper, but had neglected to update the patch.
>
> A new patch is attached.
>   
Traceback (most recent call last):
  File "/usr/bin/audit2allow", line 30, in <module>
    import sepolgen.module as module
  File "/usr/lib/python2.5/site-packages/sepolgen/module.py", line 27, 
in <module>
    import selinux
  File "/usr/lib/python2.5/site-packages/selinux.py", line 7, in <module>
    import _selinux
ImportError: /usr/lib/python2.5/site-packages/_selinux.so: undefined 
symbol: fsetfilecon_raw


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
