Message-ID: <456AEA7B.7090702@tresys.com>
Date: Mon, 27 Nov 2006 08:39:07 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: More  small fixes to policycoreutils
References: <6FE441CD9F0C0C479F2D88F959B015885C7D9F@exchange.columbia.tresys.com> <4564AEB8.3050902@redhat.com> <4564B4D3.2070901@tresys.com> <4564BC26.8040706@redhat.com>
In-Reply-To: <4564BC26.8040706@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Joshua Brindle wrote:
>> Daniel J Walsh wrote:
>>> run_init patch for call pam_acct_mgmt
>>>
>>>
>>> ------------------------------------------------------------------------
>>>
>>> diff --exclude-from=exclude --exclude='*.po' --exclude='*.pot' -N -u 
>>> -r nsapolicycoreutils/run_init/run_init.c 
>>> policycoreutils-1.33.4/run_init/run_init.c
>>> --- nsapolicycoreutils/run_init/run_init.c    2006-11-16 
>>> 17:14:27.000000000 -0500
>>> +++ policycoreutils-1.33.4/run_init/run_init.c    2006-11-22 
>>> 14:11:25.000000000 -0500
>>> @@ -132,6 +132,14 @@
>>>          result = 1;    /* user authenticated OK! */
>>>      }
>>>  
>>> +    /* If we were successful, call pam_acct_mgmt() to reset the
>>> +         * pam_tally failcount.
>>> +         */
>>> +    if (result && (PAM_SUCCESS != pam_acct_mgmt(pam_handle, 0)) ) {
>>> +        fprintf(stderr, _("failed to get account information\n"));
>>> +        exit(-1);
>>> +    }   +
>>>      /* We're done with PAM.  Free `pam_handle'. */
>>>      pam_end(pam_handle, PAM_SUCCESS);
>>>  
>>
>> I thought the previous thread noted that this was unnecessary, or am I 
>> confused?
>>
> The pam_tally might not be required anymore.  But best practices says 
> put it in there.
> 

Ok,

Acked-By: Joshua Brindle <jbrindle@tresys.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
