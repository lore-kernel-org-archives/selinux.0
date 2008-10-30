Message-ID: <490A053E.3050405@tycho.nsa.gov>
Date: Thu, 30 Oct 2008 15:04:30 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, selinux@tycho.nsa.gov,
        sakaia@jp.fujitsu.com
Subject: Re: README in libselinux
References: <4909351B.5090805@ak.jp.nec.com> <1225377210.13709.12.camel@moss-spartans.epoch.ncsc.mil> <490A00F1.9040804@tycho.nsa.gov>
In-Reply-To: <490A00F1.9040804@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Stephen Smalley wrote:
>   
>> On Thu, 2008-10-30 at 13:16 +0900, KaiGai Kohei wrote:
>>   
>>     
>>> Hi,
>>>
>>> I got a question on the secure os users mailing-list in Japan.
>>> He said that he is interested in sVirt patches but not good at the way
>>> to apply the security policy of SELinux on userspace object manager, so
>>> it makes him hesitate to comment for the patches.
>>>
>>> We know great manpages are provided yet, but a structured documentation
>>> to implement SELinux aware userspace object managers is not well known.
>>> It is not unclear whether it should be included within README, or not.
>>>
>>> However, an official guidance for developers should be considered.
>>>
>>> Any comment?
>>>     
>>>       
>> The intent was that these papers would serve as such a reference,
>> although they don't necessarily go into the level of detail an
>> implementer might want and the interfaces have of course changed over
>> time:
>> http://www.nsa.gov/selinux/papers/gconf07-abs.cfm
>> http://www.nsa.gov/selinux/papers/xorg07-abs.cfm
>> http://www.nsa.gov/selinux/papers/radac07-abs.cfm
>>
>>   
>>     
>
> I started work on such a paper last year but it fell by the wayside. 
> Here's a summary of it:
>
> How to Write a Userspace Object Manager
>
> 1. Decide what classes and permissions your object manager will be
> enforcing control over.  These could already exist in policy, or if your
> object manager provides its own service a new set of classes and
> permissions will be needed.  This is a difficult step because trade-offs
> can be made:  two "different" actions on an object could be represented
> by different security classes for the two objects, different permissions
> on the same object type, or different types on the same object with the
> same permission.  Choose a set of object classses and permissions and be
> prepared for changes as you go.
>
> 2. Figure out how your objects will be labeled.  Who are the subjects? 
> What type transitions will be made to label each object?  Will some
> objects be lableled directly (not through a type transition)?  Are some
> objects lableled by name?  Will some objects be polyinstantiated?  Each
> object needs to be labeled, so there either needs to be space inside the
> object to store the label (via some opaque security field or user data
> field) or the SELinux code will need to store and manage labels itself.
>
> 3. Hook the SELinux code into the object manager so that it will gain
> control when:
>   a) The program starts up, so the AVC can be initialized.  You'll need
> to set selinux callbacks with selinux_set_callback(3), establish a
> mapping from names to numbers for your security classes and permissions
> with selinux_set_mapping(3), initialize the AVC with avc_open(3) and a
> label handle with selabel_open(3) if you're using the file contexts or a
> similar string-to-name mapping, look up the "unlabeled" context with
> security_get_initial_context(3), and anything else that needs to be done
> to get the userspace object manager set up and running.
>   b)  Objects are created and destroyed, so the object can be labeled
> properly.  There are compute_create() and compute_member() functions
> that mirror the kernel interfaces and which work on both SID's --
> avc_compute_create(3), avc_compute_member(3)  or security context
> strings directly  -- security_compute_create(3),
> security_compute_member(3).  A name lookup can be performed with
> selabel_lookup(3).  SID's (security_id_t pointers) are reference counted
> and need to be managed with sidput() and sidget() to prevent memory leaks.
>   c) Security decisions are made, so the policy can be queried. 
> avc_compute_create(3) and security_compute_av(3) are the key functions here.
>   

Whoops, avc_has_perm(3) is the key security decision function, not
avc_compute_create(3).

> 4. Figure out how the SELinux code will be configured.  If you have a
> mapping from names to contexts this can be either kept in a
> configuration file or a new backend for it could be added to
> libselinux.  There are various ancillary options such as permissive
> mode, and handle_unknown behavior which can be configured in the
> userspace AVC; this could be exposed to the user through conf file
> options or command line parameters.
>
>
>
>   


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
