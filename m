Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9JE2o8L012594
	for <selinux@tycho.nsa.gov>; Mon, 19 Oct 2009 10:02:50 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9JE1vO9014973
	for <selinux@tycho.nsa.gov>; Mon, 19 Oct 2009 14:01:58 GMT
Message-ID: <4ADC7184.7060605@redhat.com>
Date: Mon, 19 Oct 2009 10:02:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Larry Ross <selinux.larry@gmail.com>
CC: Dominick Grift <domg472@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: sshd error: Failed to get default security context
References: <81092d890910161715n12f3f523n16e02e08a3834b97@mail.gmail.com>	 <4AD9AD06.9030309@redhat.com>	 <20091018103341.GA8253@notebook1.grift.internal> <81092d890910181158p40beabe7pa77a09f015640519@mail.gmail.com>
In-Reply-To: <81092d890910181158p40beabe7pa77a09f015640519@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/18/2009 02:58 PM, Larry Ross wrote:
> On Sun, Oct 18, 2009 at 3:33 AM, Dominick Grift <domg472@gmail.com> wrote:
> 
>> On Sat, Oct 17, 2009 at 07:39:50AM -0400, Daniel J Walsh wrote:
>>> On 10/16/2009 08:15 PM, Larry Ross wrote:
>>>> I have created a custom selinux user for the strict policy on RHEL5.3
>> who's
>>>> purpose is to connect via ssh and scp files off the machine.  When that
>> user
>>>> tries to login via ssh, I see the following messages in
>> /var/log/secure:
>>>>
>>>> In enforcing:
>>>> Oct 16 07:49:40 localhost sshd[20461]: Accepted password for scpuser
>>>> from 192.168.1.1 port 64680 ssh2
>>>> Oct 16 07:49:40 localhost sshd[20461]: error: Failed to get default
>> security
>>>> context for scpuser.
>>>> Oct 16 07:49:40 localhost sshd[20461]: fatal: SELinux failure. Aborting
>>>> connection.
>>>>
>>>> In permissive:
>>>> Oct 16 07:55:59 localhost sshd[23302]: Accepted password for scpuser
>> from
>>>> 192.168.1.1 port 56254 ssh2
>>>> Oct 16 07:55:59 localhost sshd[23302]: error: Failed to get default
>> security
>>>> context for scpuser.
>>>> Oct 16 07:55:59 localhost sshd[23302]: error: SELinux failure.
>> Continuing in
>>>> permissive mode.
>>>>
>>>> Could someone explain what these messages mean?
>>
>> I am not sure about el5 but in Fedora:
>>
>> the files in /etc/selinux/<policy model>/contexts/targeted have
>> specifications that tell the login programs what context to use for the
>> specified seuser when he logs in.
>>
>> I wrote an article about adding customized user domains for Fedora:
>>
>>
>> http://selinux-mac.blogspot.com/2009/06/selinux-lockdown-part-four-customized.html
>>
>> And some screencasts:
>>
>> http://selinux-mac.blogspot.com/2009/06/selinux-screencasts.html
> 
> 
> Dominick,
>   Thanks for the links, I hadn't seen those before.  Those are great
> examples of _how_ to do it.  I am looking for something that helps me to
> understand _why_ things work the way they do.  In my case, I didn't need to
> add my user to /etc/selinux/strict/contexts/users, nothing tells me to do
> that or why it would work without it.  In fact, the strict policy only has
> the root user defined there.
> 
>    Dan recommended updating "default_types", that wasn't needed, but I don't
> know why he recommended that or how the system uses that file vs. the
> default_contexts file, which I had modified to include my custom users.
> 
>    Can anyone point me to some current documentation that explains this (or
> at least documentation that is not obviously out of date)?
> 
>    -- Larry
> 
> 
> 
>>>>
>>>> I believe that I have a default context defined in the "default
>> context"
>>>> file that should work. I believe I have an executable context available
>> for
>>>> this user (using rbash rather than bash).
>>>>
>>>> How is sshd making this decision?  It looks like it is calling
>> setexeccon,
>>>> but I'm not sure how that makes its decision.  Where should I look for
>> clues
>>>> as to how to fix it?
default_types tells the system which type to associate with a role.

User transitions are defined in several places.  

If you define a new role/type, you need to make sure your login program can transition to that role/type.  

# sesearch --allow -s sshd_t -p transition
Found 10 semantic av rules:
   allow sshd_t unpriv_userdomain : process { transition signal } ; 
   allow sshd_t nx_server_t : process transition ; 
   allow sshd_t oddjob_mkhomedir_t : process transition ; 
   allow sshd_t chkpwd_t : process transition ; 
   allow sshd_t passwd_t : process transition ; 
   allow sshd_t updpwd_t : process transition ; 
   allow sshd_t mount_t : process transition ; 
   allow sshd_t rssh_t : process transition ; 
   allow unconfined_login_domain unconfined_t : process transition ; 
   allow polydomain setfiles_t : process transition ; 

Probably defining your type as a unpriv_userdomain will allow this.

You also need to make sure system_r can reach your role

# sesearch --role_allow | grep system_r
   allow system_r sysadm_r;
   allow sysadm_r system_r;
   allow system_r guest_r;
   allow logadm_r system_r;
   allow system_r logadm_r;
   allow system_r nx_server_r;
   allow system_r staff_r;
   allow unconfined_r system_r;
   allow system_r unconfined_r;
   allow system_r user_r;
   allow webadm_r system_r;
   allow system_r webadm_r;
   allow system_r xguest_r;


Basically this means system_r:sshd_t can transition to myrole_r:myrole_t

Now you need to setup the user database.

You need to make sure your SELinux User includes that role.

# semanage user -a -R myrole_r myuser_u

Then you need to make sure your Linux User maps to your new user
# semanage login -a -s myuser_u dwalsh

Now you need to make sure the default transitions happen correctly.

for example.

Then you need to edit your 
/etc/selinux/targeted/contexts/default_contexts
or preferably
/etc/selinux/targeted/contexts/users/myrole_u

file.  The login program reads /etc/selinux/targeted/contexts/users/myrole_u first 

Hopefully all of this will be setup correctly and your domain should be reached.
>>>>
>>>>    Thank you,
>>>>    Larry
>>>>
>>> Did you add an entry to default_types?
>>>
>>> --
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
>>> the words "unsubscribe selinux" without quotes as the message.
>>
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
