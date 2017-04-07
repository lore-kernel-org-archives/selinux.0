Message-ID: <58E7F439.9070604@quarksecurity.com>
Date: Fri, 07 Apr 2017 16:19:05 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Dennis Sherrell <sherrellconsulting@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Nick Kralevich <nnk@google.com>,
 SELinux <Selinux@tycho.nsa.gov>
Subject: Re: MLS directory label inheritance rules
References: <CAFJ0LnFHgkGSY73LwKNUbn+r+E6+TivuSkZq851y12ZvQ85Qbw@mail.gmail.com>
 <1491594062.20167.4.camel@tycho.nsa.gov>
 <1491595109.20167.6.camel@tycho.nsa.gov>
 <CAN1YQdEfpw-D2fTSVKK2VHOCRuB=k7QLzhpK0vvaYXvD8B++XQ@mail.gmail.com>
In-Reply-To: <CAN1YQdEfpw-D2fTSVKK2VHOCRuB=k7QLzhpK0vvaYXvD8B++XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Dennis Sherrell wrote:
> In a thread ending with Nick Kravelich's contact infirmation, it was
> written:
>
> "
> If you write top secret data it should stay top secret even if you're
> writing to a folder that is normally reserved for secret data, or perhaps
> mixed data. Iirc it uses the MLS of the process when creating the file
> entry."
>
> I disagree. Top Secret data shoud not be written to a folder which was not
> provisioned for such. Allowing persons or processess of lower
> classification access to "containers" with higher clearance requirements
> could cause a data spill. Any thoughts as to active handling of such?
>

These are just the default labeling rules. The reading or writing would 
still need to be allowed by the TE policy and not removed by the 
constraints. MLS constraints should prevent a write from a TS subject to 
a S object regardless of what the default rule says the label should be.

> Dennis Sherrell
> Sherrell Consulting
> Bakersfield, California Company #136601
> Counter-Terrorism
> Cybernetic Countermeasure Developer
>
> On Fri, Apr 7, 2017, 12:55 PM Stephen Smalley<sds@tycho.nsa.gov>  wrote:
>
>> On Fri, 2017-04-07 at 15:41 -0400, Stephen Smalley wrote:
>>> On Fri, 2017-04-07 at 11:39 -0700, Nick Kralevich wrote:
>>>> When a file is created in a directory, the default label for the
>>>> file
>>>> is based on the label of the enclosing directory (unless something
>>>> like setfscreatecon is used). For example:
>>>>
>>>> bullhead:/ # cd /data/misc/zoneinfo/
>>>>
>>>> bullhead:/data/misc/zoneinfo # ls -ladZ .
>>>> drwxrwxr-x 2 system system u:object_r:zoneinfo_data_file:s0 4096
>>>> 1971-06-19 17:07 .
>>>> bullhead:/data/misc/zoneinfo # touch asdf
>>>> bullhead:/data/misc/zoneinfo # ls -ladZ . asdf
>>>>
>>>> drwxrwxr-x 2 system system u:object_r:zoneinfo_data_file:s0 4096
>>>> 2017-04-07 18:32 .
>>>> -rw-rw-rw- 1 root   root   u:object_r:zoneinfo_data_file:s0    0
>>>> 2017-04-07 18:32 asdf
>>>>
>>>> note how the label of the "asdf" file matches the label of the
>>>> enclosing directory.
>>>>
>>>> However, that's not true when the directory uses categories. In
>>>> that
>>>> case, the newly created file inherits the label, but not the
>>>> categories. For example:
>>>>
>>>> bullhead:/data/data # cd /data/data/com.android.chrome
>>>> bullhead:/data/data/com.android.chrome # ls -ladZ .
>>>> drwx------ 6 u0_a60 u0_a60 u:object_r:app_data_file:s0:c512,c768
>>>> 4096
>>>> 1971-07-15 15:31 .
>>>> bullhead:/data/data/com.android.chrome # touch asdf
>>>> bullhead:/data/data/com.android.chrome # ls -laZd . asdf
>>>> drwx------ 6 u0_a60 u0_a60 u:object_r:app_data_file:s0:c512,c768
>>>> 4096
>>>> 2017-04-07 18:35 .
>>>> -rw-rw-rw- 1
>>>> root   root   u:object_r:app_data_file:s0              0
>>>> 2017-04-07 18:35 asdf
>>>>
>>>> Note how the label is maintained, but the "c512,c768" portion is
>>>> not
>>>> maintained. While this example occurs when I'm running in a
>>>> permissive
>>>> domain, it also occurs in an enforcing domain.
>>>>
>>>> The inconsistency seems weird, and I'm sure there's a good reason
>>>> why
>>>> this occurs that I'm not familiar with. Can someone help me
>>>> understand
>>>> if this is expected, and if so, why?
>>> First, the good news is that you get to specify which behavior you
>>> want
>>> for each context field and object class through policy (as long as
>>> your
>>> kernel and policy version supports it), see:
>>> https://selinuxproject.org/page/DefaultRules
>>>
>>> Second, there are different defaults for each of the fields of the
>>> security contexts based on what is most normative for that particular
>>> security model.  The user identity defaults to that of the creating
>>> process since we typically do not allow a process to create files
>>> with
>>> a different user identity and want the file to reflect its creator
>>> (this is defined through constraints on user identity in policies
>>> that
>>> define more than one, unlike Android). The role defaults to the fixed
>>> object_r role because originally we didn't envision a use case for
>>> roles on files.  The MLS range defaults to the low/current level of
>>> the
>>> process because a process is typically not allowed to create files at
>>> a
>>> different level and we want the file to reflect the sensitivity of
>>> the
>>> data which originated from the process. The type defaults to a
>>> related
>>> object type (in this case that of the parent directory) because
>>> process
>>> domains and object types are separate (aside from overlapping use for
>>> /proc/pid) and the relationships among them are explicit through the
>>> TE
>>> rules / access matrix rather than through implicit rules.
>>>
>>> Of course, in addition to being able to globally configure the
>>> default
>>> behavior, you can also customize specific cases through the
>>> role/type/range_transition rules.
>>>
>>> With your example above, you wanted the file to inherit the level of
>>> the directory, but consider the situation where a process with
>>> categories (:s0:c512,c768) creates a file in some shared
>>> (mlstrustedobject) directory that is just :s0.  Do you want that file
>>> to end up as just :s0?  In the MLS world, that would be a downgrade /
>>> info leak.
>> I guess that's not a great example since then the file would also end
>> up with the same type by default and thus would be a mlstrustedobject
>> and accessible regardless of its level.  So you'd want a type
>> transition to a derived type for files created in that directory to
>> avoid that.
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
