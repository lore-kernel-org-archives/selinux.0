Message-ID: <53512680.8060303@tycho.nsa.gov>
Date: Fri, 18 Apr 2014 09:20:00 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: =?UTF-8?B?dG9hzIluIGN1zIA=?= <xuantoanbkfet@gmail.com>,
 selinux@tycho.nsa.gov
Subject: Re: Transition domain in SELinux
References: <CANh19KA2NX8RNt4u757_SY05Z84z9BsTfKhu3k+-rVzqfSAsMg@mail.gmail.com>
 <5351247F.2050504@tycho.nsa.gov>
In-Reply-To: <5351247F.2050504@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/18/2014 09:11 AM, Stephen Smalley wrote:
> On 04/18/2014 05:59 AM, toản cù wrote:
>> Hi all !
>> I just researching policy in selinux, and I am facing an issue when
>> transition domain. I want change domain from unconfined_t to staff_t
>> domain.(when process of type unconfined_t execute file of type
>> xuantoan_t :/type_transition unconfined_t xuantoan_t : process
>> staff_t;/). since process of type unconfined_t can access file of type
>> toanxt_t through staff_t domain.
>>
>> /policy_module(toanxt, 1.0.0);/
>> /require{/
>> /type unconfined_t;/
>> /type starr_t;/
>> /class process transition;/
>> /}/
>> /type toanxt_t;/
>> /type xuantoan_t;/
>> /type toanxt_exec_t;/
>> /
>> /
>> /allow staff_t  toanxt_exec_t : file { excute_no_trans   excute  open
>>  write getattr read}; /
>> /allow staff_t  toanxt_t : file { excute_no_trans   excute  open  write
>> getattr read};
>> /
>> /
>> /
>> /type_transition unconfined_t xuantoan_t : process staff_t;/
>> /allow unconfined_t xuantoan_t : file { execute };/
>> /allow staff_t xuantoan_t : file entrypoint;/
>> /allow unconfined_t staff_t : process transition;/
>> /
>> /
>> but after compile and insert, process of type unconfined_t not access
>> file of type toanxt_t. I don't know why, look forward your help!
> 
> I'm not sure what your goal is, but unconfined by its nature shouldn't
> need to transition to another domain to access some resource.  If you
> truly want to limit the user, then map the Linux user to staff_u via
> semanage login so that when they login, they run in
> staff_u:staff_r:staff_t and then set up transitions as appropriate from
> staff_t for accessing the content via your program.
> 
> unconfined -> staff would not merely be a domain transition but also a
> user and role transition.  But you really don't want that.
> 
> Also, try to use refpolicy interfaces (macros) rather than directly
> writing the raw allow and type_transition rules; they will help you
> ensure that you cover all the required accesses.  If using audit2allow,
> then audit2allow -R will try to match the denials against the closest
> refpolicy interface and generate corresponding macro calls for you.

For example, for your rules above, you should be using
domain_auto_trans() aka domain_auto_transition_pattern() for the domain
transition and can_exec() or exec_file_perms for executing the program
by staff_t if you want it to stay in-domain.  But as I noted above, this
won't help with the user and role issue and isn't really what you want
to do.
