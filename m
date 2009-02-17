Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1HKeYUO014229
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 15:40:34 -0500
Received: from manicmethod.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1HKbCc1029183
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 20:37:12 GMT
Message-ID: <499B20AA.8050902@manicmethod.com>
Date: Tue, 17 Feb 2009 15:40:10 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to libsemanage to remove labeling of /root
References: <496C9A96.1080805@redhat.com> <499B1D53.4030602@manicmethod.com> <499B1EB7.40202@redhat.com> <499B1ECE.2040509@manicmethod.com> <499B2091.8000303@redhat.com>
In-Reply-To: <499B2091.8000303@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Joshua Brindle wrote:
>> Daniel J Walsh wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> Joshua Brindle wrote:
>>>> Daniel J Walsh wrote:
>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>> Hash: SHA1
>>>>>
>>>>> Policy should label /root with one label and this should not be
>>>>> effected
>>>>> by the passwd database.
>>>>>
>>>>> In Fedora policy we label this as admin_home_t.  Having this label vary
>>>>> depending on policy ends up with lines like
>>>>>
>>>>> dontaudit * user_home_t:dir search_dir_perms
>>>>> dontaudit * admin_home_t:dir search_dir_perms
>>>>> dontaudit * sysadmin_home_t:dir search_dir_perms
>>>>> dontaudit * staff_home_t:dir search_dir_perms
>>>>>
>>>>> Labeling this directory as user_home_t, opens the system to possible
>>>>> security risks since some domains have to be able to write to
>>>>> user_home_t when they would never be allowed to write to admin_home_t.
>>>> The comment right above the added lines seems to indicate that was
>>>> suppose to be root before, why is / excluded? Are we going to start a
>>>> huge whitelist for genhomedircon?
>>>>
>>>>                 if (strcmp(pwent->pw_dir, "/") == 0) {
>>>>                         /* don't relabel / genhomdircon checked to see
>>>> if root
>>>>                          * was the user and if so, set his home
>>>> directory to
>>>>                          * /root */
>>>>                         continue;
>>>>                 }
>>> No just /root
>>>
>>> /root should not be labeled based on genhomedircon.
>>>
>> Why are the exact same lines there for "/" then?
>>
>>
> Well I guess we do want to protect / and /root.
> 
> Others should be fixed by looking at the parent, so if I added /var as a
> homedir it would blow up saying it conflicts with the previous
> definition of /var.
> 

I don't think I understand the problem we are trying to solve here...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
