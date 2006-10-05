Message-ID: <452528C0.1050907@us.ibm.com>
Date: Thu, 05 Oct 2006 10:46:08 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        jdesai@us.ibm.com
Subject: Re: [RFC PATCH] newrole suid breakdown
References: <452432FA.1060009@us.ibm.com> <45250F35.6030204@redhat.com> <452519BC.1060204@us.ibm.com> <45251C15.6020506@redhat.com>
In-Reply-To: <45251C15.6020506@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Michael C Thompson wrote:
>> Daniel J Walsh wrote:
>>> Michael C Thompson wrote:
<snip>
>> diff -Naur policycoreutils-1.30.30.dev/newrole/newrole.c 
>> policycoreutils-1.30.30.dev.rh/newrole/newrole.c
>> --- policycoreutils-1.30.30.dev/newrole/newrole.c    2006-10-04 
>> 17:01:17.000000000 -0500
>> +++ policycoreutils-1.30.30.dev.rh/newrole/newrole.c    2006-10-05 
>> 09:39:14.000000000 -0500
>> @@ -548,6 +548,7 @@
>>      uid_t uid;
>>      int fd;
>>      int enforcing;
>> +    int ignore_privilage_actions = 0;
>>      sigset_t empty;
>>  #ifdef USE_PAM
>>      int rc;            /* pam return code */
>> @@ -562,8 +563,11 @@
>>      };
>>  #endif
>>  
>> -    if (drop_capabilities())
>> -        return -1;
>> +    if (geteuid())
>> +        ignore_privilage_actions = 1;
>> +    else
>> +        if (drop_capabilities())
>> +            return -1;
>>  
>>   
> I think this is all you need.  Audit can handle the fact that it can't 
> send a message by sending it to /var/log/messages.  And if You use 
> pam_namespace.so you should fail if you are not setuid and you are not 
> root.

True, but right now we are set to abort newrole if those actions are 
expected to succeed (we have compiled with the respective _PRIV). Should 
that behavior be changed?

>>      /* Empty the signal mask in case someone is blocking a signal */
>>      sigemptyset(&empty);
>> @@ -662,7 +666,9 @@
>>      if (role_s && !type_s) {
>>          if (get_default_type(role_s, &type_s)) {
>>              fprintf(stderr, _("Couldn't get default type.\n"));
>> -            send_audit_message(0, old_context, new_context, ttyn);
>> +            if (!ignore_privilage_actions)
>> +                send_audit_message(0, old_context, new_context,
>> +                           ttyn);
>>              exit(-1);
>>          }
>>  #ifdef CANTSPELLGDB
>> @@ -851,7 +857,8 @@
>>  
>>      if (security_check_context(new_context) < 0) {
>>          fprintf(stderr, _("%s is not a valid context\n"), new_context);
>> -        send_audit_message(0, old_context, new_context, ttyn);
>> +        if (!ignore_privilage_actions)
>> +            send_audit_message(0, old_context, new_context, ttyn);
>>          exit(-1);
>>      }
>>  
>> @@ -960,12 +967,15 @@
>>  
>>  #ifdef USE_PAM
>>  #ifdef NAMESPACE_PRIV
>> -        rc = pam_close_session(pam_handle,0);
>> -        if(rc != PAM_SUCCESS) {
>> -            fprintf(stderr, "pam_close_session failed with %s\n",
>> -                pam_strerror(pam_handle, rc));
>> -            pam_end(pam_handle, rc);
>> -            exit(-1);
>> +        if (!ignore_privilage_actions) {
>> +            rc = pam_close_session(pam_handle,0);
>> +            if(rc != PAM_SUCCESS) {
>> +                fprintf(stderr,
>> +                    "pam_close_session failed with %s\n",
>> +                    pam_strerror(pam_handle, rc));
>> +                pam_end(pam_handle, rc);
>> +                exit(-1);
>> +            }
>>          }
>>  #endif
>>  
>> @@ -1026,21 +1036,24 @@
>>          exit(-1);
>>      }
>>  #ifdef NAMESPACE_PRIV
>> -    /* Ask PAM to setup session for user running this program */
>> -    rc = pam_open_session(pam_handle,0);
>> -    if(rc != PAM_SUCCESS) {
>> -        fprintf(stderr, "pam_open_session failed with %s\n",
>> -            pam_strerror(pam_handle, rc));
>> -        exit(-1);
>> +    if (!ignore_privilage_actions) {
>> +        /* Ask PAM to setup session for user running this program */
>> +        rc = pam_open_session(pam_handle,0);
>> +        if(rc != PAM_SUCCESS) {
>> +            fprintf(stderr, "pam_open_session failed with %s\n",
>> +                pam_strerror(pam_handle, rc));
>> +            exit(-1);
>> +        }
>>      }
>>  #endif
>> -
>> -    if (send_audit_message(1, old_context, new_context, ttyn))
>> -        exit(-1);
>> +    if (!ignore_privilage_actions)
>> +        if (send_audit_message(1, old_context, new_context, ttyn))
>> +            exit(-1);
>>      freecon(old_context);
>>  #ifdef NAMESPACE_PRIV
>> -    if (transition_to_caller_uid())
>> -        exit(-1);
>> +    if (!ignore_privilage_actions)
>> +        if (transition_to_caller_uid())
>> +            exit(-1);
>>  #endif
>>      execv(pw->pw_shell, argv + optind - 1);
>>  
>>   
> 
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
> with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
