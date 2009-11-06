Message-ID: <4AF4AFFC.9060505@tycho.nsa.gov>
Date: Fri, 06 Nov 2009 18:23:40 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: selinux@tycho.nsa.gov, Larry Ross <selinux.larry@gmail.com>,
        paul@city-fan.org
Subject: Re: "security_compute_sid: invalid context" error when starting/stopping
 mysqld daemon
References: <81092d890911041557u78860e4ar65d2a1eb6964656e@mail.gmail.com> <4AF482CA.4090109@tycho.nsa.gov> <81092d890911061239t22c15f7p9aa4c907962de8cf@mail.gmail.com> <20091106221120.GA4921@notebook3.grift.internal>
In-Reply-To: <20091106221120.GA4921@notebook3.grift.internal>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/06/2009 05:11 PM, Dominick Grift wrote:
> On Fri, Nov 06, 2009 at 12:39:57PM -0800, Larry Ross wrote:
>   
>> On Fri, Nov 6, 2009 at 12:10 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
>>
>>     
>>>  On 11/04/2009 06:57 PM, Larry Ross wrote:
>>>       
>>>> I have two selinux users that need to be able to stop and start the
>>>> mysql daemon, which is started by the initialization scripts.  When
>>>> the daemon is stopped and started by the secadm_u user, it ends up in
>>>> the context secadm_u:secadm_r:mysqld_t.  When it is stopped and
>>>> started by the dbadm_u user, it ends up in the
>>>> dbadm_u:dbadm_r:mysqld_t context.  When it is started by the init
>>>> scripts it ends up in the system_u:system_r:mysqld_t domain.
>>>>
>>>> I would like it to alway end up in the system_r:mysqld_t domain, but
>>>> can't seem to find any documentation that describes how to get that to
>>>> work.
>>>>
>>>> If I add a role_transition rule to transition the role to system_r
>>>> when the executable is run:
>>>> role_transition sysadm_r mysqld_safe_exec_t system_r;
>>>> role_transition dbadm_r  mysqld_safe_exec_t system_r;
>>>> I end up getting these errors:
>>>>
>>>> Nov  4 15:41:36 localhost kernel: type=1401 audit(1257378096.775:46):
>>>> security_compute_sid:  invalid context
>>>> dbadm_u:system_r:mysqld_safe_t:s0 for
>>>> scontext=dbadm_u:dbadm_r:initrc_t:s0
>>>> tcontext=system_u:object_r:mysqld_safe_exec_t:s0 tclass=process
>>>>
>>>> I believe I have the rules that should allow this, but obviously I am
>>>> missing something.
>>>> role dbadm_r types mysqld_safe_t;
>>>> role sysadm_r types mysqld_safe_t;
>>>> role system_r types mysqld_safe_t;
>>>> and this:
>>>> allow initrc_t mysqld_safe_t : process transition ;
>>>> which is what the "security_compute_sid" message looks like it is
>>>>         
>>> missing.
>>>       
>>>> Does anyone know where I can find a good description of how to get a
>>>> service to transistion back into system_r when started by a user or
>>>> have any idea what I am missing?
>>>>         
>>>
>>> The run_init program was designed to solve this problem, take a look at
>>> the man page.
>>>
>>> On Fedora at least, the "service" command calls run_init internally, so
>>> doing "service mysqld start" should in theory start it up in the
>>> system_r role.  If you're just running "/etc/init.d/mysld start" it
>>> won't transition.
>>>
>>>       
>> That would be great, but I am trying to use this as normal users on a system
>> to which the root account is locked.  As far as I know, run_init always asks
>> for the root password.  Is there a way to use it without having access to
>> the root password?
>>     
> I think you can use pam_rootok in /etc/pam.d/run_init. I dont know the details of the top of my head because i use Fedora and the policy that i posted earlier so that i automatically transition to initrc_t without run_init.
>   


Yes, /etc/pam.d/run_init controls the password check done by run_init. 
Also, it only asks for the password of whatever user is running it, not
always the root password.  The only reason it asks for a password is to
verify that a human is present.

"run_init id -Z" from sysadm_r should print out
"system_u:system_r:initrc_t".  Other roles might need the following line
of policy to be able to run run_init (using the example of staff):

seutil_run_runinit(staff_t, staff_r)

The policy snippet Dominick posted earlier also works.



>  
> BTW, I am using RHEL 5.3, do you know if service there calls run_init
> internally?

I was mistaken about this, as pointed out by Paul, service doesn't call
run_init.



-- 

Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
